From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/6] PCI: use common INTx swizzling loop
Date: Tue, 16 Dec 2008 21:36:50 -0700
Message-ID: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:1423 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYLQEgy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2008 23:36:54 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

This series adds a pci_common_swizzle() function in the PCI
core and changes several architectures to use it instead of
architecture-specific code.

Comments welcome.

Bjorn
---

Bjorn Helgaas (6):
      PCI: x86/visws: use generic INTx swizzle from PCI core
      PCI: sh: use generic INTx swizzle from PCI core
      PCI: mips: use generic INTx swizzle from PCI core
      PCI: arm: use generic INTx swizzle from PCI core
      PCI: alpha: use generic INTx swizzle from PCI core
      PCI: add pci_common_swizzle() for INTx swizzling


 arch/alpha/kernel/pci.c         |   18 ------------------
 arch/alpha/kernel/pci_impl.h    |    4 ++--
 arch/arm/include/asm/mach/pci.h |    2 +-
 arch/arm/kernel/bios32.c        |   27 ---------------------------
 arch/mips/pci/pci.c             |   17 +----------------
 arch/sh/drivers/pci/pci.c       |   17 +----------------
 arch/x86/pci/visws.c            |   15 +--------------
 drivers/pci/pci.c               |   20 ++++++++++++++++++++
 include/linux/pci.h             |    1 +
 9 files changed, 27 insertions(+), 94 deletions(-)
