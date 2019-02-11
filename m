Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfBKFIb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 00:08:31 -0500
From: guoren@kernel.org
Subject: [GIT PULL] csky fixes for v5.0-rc6
Date: Mon, 11 Feb 2019 13:08:19 +0800
Message-ID: <1549861699-11875-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190211050819.JjQraMZ0qj-5OShDhUk2cuxpShPpDb0GewVbe12fEIg@z>

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 757dc82a87669b1967faf89c6586c20a9aea2f6b:

  csky: Fixup dead loop in show_stack (2019-02-11 10:47:27 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (12):
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support
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
Guo Ren (12):
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support
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

 .../interrupt-controller/csky,apb-intc.txt         |   4 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  21 ++-
 arch/csky/include/asm/pgtable.h                    |   9 +-
 arch/csky/include/asm/processor.h                  |   4 +-
 arch/csky/kernel/dumpstack.c                       |   4 +
 arch/csky/kernel/ptrace.c                          |   3 +-
 arch/csky/kernel/smp.c                             |   3 +-
 arch/csky/mm/ioremap.c                             |  14 ++
 drivers/irqchip/irq-csky-apb-intc.c                | 151 +++++++++++++++++----
 drivers/irqchip/irq-csky-mpintc.c                  | 113 ++++++++++++++-
 10 files changed, 279 insertions(+), 47 deletions(-)
