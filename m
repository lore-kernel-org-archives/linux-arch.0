From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 0/2] Add PCI support on nios2 architecture
Date: Tue, 22 Sep 2015 15:19:25 +0800
Message-ID: <1442906367-10935-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
List-Id: linux-arch.vger.kernel.org

This patchset adding pci support for nios2 architecture.
It requires pci_fixup_irqs() from setup-irq.c.

Ley Foon Tan (2):
  nios2: Add architectural support for PCIe
  PCI: Build setup-irq.o for nios2

 arch/nios2/Kconfig            | 24 +++++++++++++++++++++
 arch/nios2/include/asm/Kbuild |  2 +-
 arch/nios2/include/asm/io.h   | 11 +++++++++-
 arch/nios2/include/asm/pci.h  | 50 +++++++++++++++++++++++++++++++++++++++++++
 arch/nios2/kernel/Makefile    |  1 +
 arch/nios2/kernel/pci.c       | 33 ++++++++++++++++++++++++++++
 drivers/pci/Makefile          |  1 +
 7 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 arch/nios2/include/asm/pci.h
 create mode 100644 arch/nios2/kernel/pci.c

-- 
1.8.2.1
