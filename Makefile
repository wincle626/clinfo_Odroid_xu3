#Copyright (c) 2013 Simon Leblanc
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

CC=clang
EXEC = clinfo

#CFLAGS = -Wall -O3 -std=c99 -L/root/enpower/mali/driver/userspacebindrv/fbdev/fbdev -L/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/lib -L/root/enpower/pocl/pocl-git/install/lib -I/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/include -I/root/enpower/pocl/pocl-git/install/include
# CFLAGS = -Wall -O3 -std=c99 -L/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/lib -L/root/enpower/mali/driver/userspacedrv/fbdev/fbdev -L/root/enpower/pocl/pocl-git-icd/install/lib/ -L/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/lib -L/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/common -I/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/include -I/root/enpower/pocl/pocl-git-icd/install/include -I/root/enpower/sdk/Mali_OpenCL_SDK_v1.1.0/include -I/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/common
CFLAGS = -Wall -O3 -std=c99 -L/root/enpower/pocl/hwloc/hwloc-1.11.2/install/lib -L/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/lib -L/root/enpower/mali/driver/userspacedrv/fbdev/fbdev -L/root/enpower/pocl/pocl-git-icd/install/lib/ -L/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/lib -L/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/common -I/root/enpower/pocl/ocl-icd/ocl-icd-2.2.9/install/include -I/root/enpower/pocl/pocl-git-icd/install/include -I/root/enpower/sdk/Mali_OpenCL_SDK_v1.1.0/include -I/root/enpower/mali/sdk/Mali_OpenCL_SDK_v1.1.0/common
LDFLAGS =

ifeq ($(shell uname),Darwin)
	LDFLAGS += -framework OpenCL
else
	LDFLAGS += -lOpenCL -lm -lpthread
	#LDFLAGS += -lMali -lm
endif

prefix = /usr/local
bindir = bin
mandir = share/man/man1


CC = cc
RM = rm -f
INSTALL = install

.PHONY: clean install uninstall

all: $(EXEC)

$(EXEC): clinfo.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean:
	$(RM) $(EXEC)

install: $(EXEC)
	$(INSTALL) $(EXEC) $(prefix)/$(bindir)/
	$(INSTALL) clinfo.1 $(prefix)/$(mandir)/$(EXEC).1

uninstall:
	@test -s $(prefix)/$(bindir)/$(EXEC) \
	|| { echo "Not found: $(prefix)/$(bindir)/$(EXEC)"; exit 1; }
	$(RM) $(prefix)/$(bindir)/$(EXEC)
	@test -s $(prefix)/$(mandir)/$(EXEC).1 \
	|| { echo "Not found: $(prefix)/$(mandir)/$(EXEC).1"; exit 1; }
	$(RM) $(prefix)/$(mandir)/$(EXEC).1
