Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfBLIad (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 03:30:33 -0500
From: guoren@kernel.org
Subject: [GIT PULL V2] csky fixes for v5.0-rc6
Date: Tue, 12 Feb 2019 16:30:25 +0800
Message-ID: <1549960225-23253-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190212083025.7ZuqZHv8y_oWiFzJ5vg--jsEP3Q8QKlr-dkIWnMy7uI@z>

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 749e649084d0acb8c5d28c0ec502d9cc023bff86:

  csky: Fixup dead loop in show_stack (2019-02-12 10:25:37 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (10):
	csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
	irqchip/csky: Optimize remove unnecessary loop irq handle
	irqchip/irq-csky-mpintc: Add triger type and priority
	dt-bindings: interrupt-controller: Update csky mpintc
	csky: Fixup wrong pt_regs size
	csky: coding convention: Use task_stack_page
	dt-bindings: csky,apb-intc: Add vector irq mode
	irqchip/csky: Add support-vector-irq for apb-intc
	csky: Fixup io-range page attribute for mmap("/dev/mem")
	csky: Fixup dead loop in show_stack

Signed-off-by: Guo Ren <ren_guo@c-sky.com>

----------------------------------------------------------------
Guo Ren (10):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      irqchip/csky: Optimize remove unnecessary loop irq handle
      irqchip/irq-csky-mpintc: Add triger type and priority
      dt-bindings: interrupt-controller: Update csky mpintc
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      dt-bindings: csky,apb-intc: Add vector irq mode
      irqchip/csky: Add support-vector-irq for apb-intc
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

 .../interrupt-controller/csky,apb-intc.txt         |   3 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  21 +++-
 arch/csky/include/asm/pgtable.h                    |   9 +-
 arch/csky/include/asm/processor.h                  |   4 +-
 arch/csky/kernel/dumpstack.c                       |   4 +
 arch/csky/kernel/ptrace.c                          |   3 +-
 arch/csky/kernel/smp.c                             |   3 +-
 arch/csky/mm/ioremap.c                             |  14 +++
 drivers/irqchip/irq-csky-apb-intc.c                |  59 +++++++----
 drivers/irqchip/irq-csky-mpintc.c                  | 113 +++++++++++++++++++--
 10 files changed, 196 insertions(+), 37 deletions(-)
