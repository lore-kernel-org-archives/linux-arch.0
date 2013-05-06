From: Ralf Baechle <ralf@linux-mips.org>
Subject: Build errors caused by modalias generation patch
Date: Mon, 6 May 2013 18:02:54 +0200
Message-ID: <20130506160253.GA27181@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:38562 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab3EFQDA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 May 2013 12:03:00 -0400
Received: from localhost.localdomain ([127.0.0.1]:33511 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823037Ab3EFQC7CMy5d (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Mon, 6 May 2013 18:02:59 +0200
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

Andreas,

doing builds of all MIPS defconfigs I observed a fair number of them
were failing to build with errors like these:

cobalt_defconfig:

  CC [M]  drivers/hid/usbhid/hid-quirks.o
  LD [M]  drivers/hid/usbhid/usbhid.o
FATAL: drivers/hid/usbhid/usbhid: sizeof(struct usb_device_id)=32 is not a modulo of the size of section __mod_usb_device_table=48.
Fix definition of struct usb_device_id in mod_devicetable.h
make[5]: *** [drivers/hid/usbhid/usbhid.o] Error 1

gpr_defconfig:

  LD [M]  drivers/atm/fore_200e.o
FATAL: drivers/atm/fore_200e: sizeof(struct pci_device_id)=32 is not a modulo of the size of section __mod_pci_device_table=56.
Fix definition of struct pci_device_id in mod_devicetable.h
make[4]: *** [drivers/atm/fore_200e.o] Error 1

jazz_defconfig:

  Building modules, stage 2.
  MODPOST 355 modules
FATAL: drivers/block/floppy: sizeof(struct pnp_device_id)=16 is not a modulo of the size of section __mod_pnp_device_table=24.
Fix definition of struct pnp_device_id in mod_devicetable.h
make[3]: *** [__modpost] Error 1

malta_defconfig:

  LD [M]  drivers/net/ethernet/chelsio/cxgb3/cxgb3.o
FATAL: drivers/net/ethernet/chelsio/cxgb3/cxgb3: sizeof(struct pci_device_id)=32 is not a modulo of the size of section __mod_pci_device_table=392.
Fix definition of struct pci_device_id in mod_devicetable.h
make[7]: *** [drivers/net/ethernet/chelsio/cxgb3/cxgb3.o] Error 1
make[6]: *** [drivers/net/ethernet/chelsio/cxgb3] Error 2
make[5]: *** [drivers/net/ethernet/chelsio] Error 2

etc.

I can reproduce the issue can only building with a separate object directory.

Reverting 6543becf26fff612cdadeed7250ccc8d49f67f27 [mod/file2alias: make
modalias generation safe for cross compiling] fixes these for me.

  Ralf
