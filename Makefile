#******************************************************************************
#*
#*  Copyright (C) 2009-2012 Broadcom Corporation
#*
#*  Licensed under the Apache License, Version 2.0 (the "License");
#*  you may not use this file except in compliance with the License.
#*  You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#*  Unless required by applicable law or agreed to in writing, software
#*  distributed under the License is distributed on an "AS IS" BASIS,
#*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#*  See the License for the specific language governing permissions and
#*  limitations under the License.
#*
#******************************************************************************

#LDLIBS = -lbluetooth
# CFLAGS=-g

CFLAGS=

all : brcm_patchram_plus brcm_bt_reset

install: all
	install -o root -g wheel -m 755 brcm_patchram_plus /usr/local/bin/brcm_patchram_plus
	install -o root -g wheel -m 755 brcm_bt_reset /usr/local/bin/brcm_bt_reset
	install -o root -g wheel -m 755 bt.init /usr/local/bin/bt.init
	install -o root -g wheel -m 755 bt.load /usr/local/bin/bt.load

install_firmware:
	install -C -o root -g root -m 644 lib/firmware/ap6210/bcm20710a1.hcd /lib/firmware/ap6210/bcm20710a1.hcd

brcm_patchram_plus.o : brcm_patchram_plus.c
	gcc -Wall -c -o brcm_patchram_plus.o brcm_patchram_plus.c

brcm_patchram_plus : brcm_patchram_plus.o
	gcc -o brcm_patchram_plus brcm_patchram_plus.o

brcm_bt_reset.o : brcm_bt_reset.c
	gcc -Wall -c -o brcm_bt_reset.o brcm_bt_reset.c

brcm_bt_reset : brcm_bt_reset.o
	gcc -o brcm_bt_reset brcm_bt_reset.o

clean:
	rm -f brcm_bt_reset brcm_bt_reset.o brcm_patchram_plus brcm_patchram_plus.o

