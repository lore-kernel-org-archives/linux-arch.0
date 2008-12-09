From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/12] PCI: unify P2P bridge INTx swizzling
Date: Tue, 09 Dec 2008 16:11:36 -0700
Message-ID: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:35124 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYLIXLk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:11:40 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

This series adds a pci_swizzle_interrupt_pin() function in the PCI
core.  Most architectures currently implement this independently.

After this series, many of the callers of pci_swizzle_interrupt_pin()
follow a similar pattern.  I'd like to consolidate those callers, too,
but I haven't started that yet.

One strange thing I'd like to understand eventually is why the
swizzle in acpi_pci_irq_derive() does something special for CardBus
bridges, while no other architecture does.

Comments welcome.

These patches have been compile-tested on:
    alpha
    arm
    ia64
    mips
    powerpc (ppc64)
    sh
    x86 (32-bit)
    x86 (64-bit)

I've boot-tested these architectures:
    ia64
    x86 (32-bit)

I haven't compiled parisc for want of a cross-compiler.

Bjorn

---

Bjorn Helgaas (12):
      PCI: x86: use generic pci_swizzle_interrupt_pin()
      PCI: sh: use generic pci_swizzle_interrupt_pin()
      PCI: powerpc: use generic pci_swizzle_interrupt_pin()
      PCI: parisc: use generic pci_swizzle_interrupt_pin()
      PCI: mips: use generic pci_swizzle_interrupt_pin()
      PCI: arm: use generic pci_swizzle_interrupt_pin()
      PCI: alpha: use generic pci_swizzle_interrupt_pin()
      PCI: add pci_swizzle_interrupt_pin()
      x86/PCI: minor logic simplications
      x86/PCI: use config space encoding for interrupt pins
      PCI: use config space encoding in pci_get_interrupt_pin()
      PCI Hotplug: cpqphp: use config space PCI interrupt pin encoding


 arch/alpha/kernel/pci.c           |    2 +
 arch/alpha/kernel/pci_impl.h      |    9 +-----
 arch/alpha/kernel/sys_dp264.c     |    2 +
 arch/alpha/kernel/sys_eiger.c     |    2 +
 arch/alpha/kernel/sys_miata.c     |    2 +
 arch/alpha/kernel/sys_noritake.c  |    2 +
 arch/alpha/kernel/sys_ruffian.c   |    2 +
 arch/alpha/kernel/sys_sable.c     |    2 +
 arch/arm/kernel/bios32.c          |    6 ++--
 arch/arm/mach-integrator/pci.c    |   11 +-------
 arch/mips/pci/pci-ip27.c          |    6 ----
 arch/mips/pci/pci.c               |    9 +-----
 arch/powerpc/kernel/prom_parse.c  |    7 +----
 arch/sh/drivers/pci/ops-cayman.c  |    9 +-----
 arch/sh/drivers/pci/pci.c         |    7 +----
 arch/x86/pci/irq.c                |   54 +++++++++++++++++--------------------
 arch/x86/pci/visws.c              |    7 +----
 drivers/parisc/dino.c             |    4 +--
 drivers/parisc/iosapic.c          |    3 +-
 drivers/pci/hotplug/cpqphp_ctrl.c |    4 +--
 drivers/pci/hotplug/cpqphp_pci.c  |    2 +
 drivers/pci/pci.c                 |   10 +++++--
 include/linux/pci.h               |    1 +
 23 files changed, 60 insertions(+), 103 deletions(-)

-- 
Signature
