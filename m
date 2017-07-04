From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: RISC-V Linux Port v4
Date: Tue,  4 Jul 2017 12:50:53 -0700
Message-ID: <20170704195102.3974-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35844 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdGDTvW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2017 15:51:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so31801718pfk.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2017 12:51:22 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

Thanks to everyone who has participated in the review process so far.  There
have only been a few changes since the v3 patch set:

 * The cmpxchg64 syscall is no longer enabled on 32-bit systems.  It's not
   possible to provide this on SMP systems, and it's not necessary as glibc
   knows not to call it.

 * We provide a ELF_HWCAP so users can determine the ISA of the machine the
   kernel is running on.

 * The multi-line comments are in a better form.

 * There were a handful of headers that could be replaced with the asm-generic
   versions, and a few unnecessary definitions.

 * We no longer use printk, but instead use pr_*.

 * A few Kconfig and defconfig entries have been cleaned up.

Since things have really calmed down, I think it would be good to try and get
this into 4.13 (ie, during this merge window).  This might let us get into the
upcoming glibc release as well.  Does that seem possible?

Like last time, in case one gets eaten by the mailing list this is also
available as a git tree on our Git Hub

  https://github.com/riscv/riscv-linux/tree/riscv-for-submission-arch-v4

This patch set just contains the arch code, we have various drivers that are
required to build and boot a RISC-V system.  A tree that contains this patch
set merged with all our other patch sets lives at

  https://github.com/riscv/riscv-linux/tree/riscv-for-submission-v4

  a83d4bb70b76 pci: Add a generic, weakly-linked pcibios_fixup_bus
  a3445d3b4ff1 pci: Add a generic, weakly-linked pcibios_align_resource
  d97ac4f5bb1d Merge branch 'riscv-for-submission-arch-v4' into riscv-for-submission-v4
  0705a31372d4 Merge branch 'riscv-for-submission-clk-v2' into riscv-for-submission-v4
  a6c8eb9af199 Merge branch 'riscv-for-submission-irq-v2' into riscv-for-submission-v4
  3e5b46967f66 Merge branch 'riscv-for-submission-lib-v2' into riscv-for-submission-v4
  8ca3c2cdefed Merge branch 'riscv-for-submission-pci-v3' into riscv-for-submission-v4
  e1aa9abddfa8 Merge branch 'riscv-for-submission-tty-v2' into riscv-for-submission-v4

If you're going to try to build or boot the kernel, I'd recommend using that.

Thanks to everyone who has helped review our port!

[PATCH 1/9] RISC-V: Init and Halt Code
[PATCH 2/9] RISC-V: Atomic and Locking Code
[PATCH 3/9] RISC-V: Generic library routines and assembly
[PATCH 4/9] RISC-V: ELF and module implementation
[PATCH 5/9] RISC-V: Task implementation
[PATCH 6/9] RISC-V: Device, timer, IRQs, and the SBI
[PATCH 7/9] RISC-V: Paging and MMU
[PATCH 8/9] RISC-V: User-facing API
[PATCH 9/9] RISC-V: Build Infastructure
