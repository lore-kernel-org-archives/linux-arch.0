From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: RISC-V Linux Port v3
Date: Wed, 28 Jun 2017 11:55:29 -0700
Message-ID: <20170628185538.1804-1-palmer@dabbelt.com>
References: <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36833 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdF1Szx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 14:55:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so9150659pgn.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Jun 2017 11:55:53 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

Thanks to everyone who has particpated in the review process so far.  We've
made a handful of changes since the v2 port, and at this point aside from a
handful of FIXMEs floating around the code I don't think there's anything left
I know about that's still missing for a minimal port.  I believe I've addressed
every review comment so far, if I've missed yours then I'm sorry but I'd like
to request you resend it.

A highlight of the changes since the v1 patch set includes:

 * We've split out all our drivers into separate patch sets, which I've already
   sent out to the relevant maintainers.  I haven't included those patches in
   this patch set, but some of them are necessary to build our port.  A git
   tree that contains all our patch sets merged together lives at
   <https://github.com/riscv/riscv-linux/tree/riscv-for-submission-v3>.

 * The patch set is now split up differently: rather than being split per
   directory it is split per topic.  Hopefully this will make it easier to
   review the port on the mailing list.  The split is a bit rough, so you
   probably still want to look at the patch set as a whole.

 * atomic.h has been completely rewritten and is hopefully now correct.  I've
   attempted to sanitize the various other memory model related code as well,
   and I think it should all be sane now aside from a handful of FIXMEs
   commented in the code.

 * We've changed the cmpexchg syscall to always exist and to not be
   multiplexed.  There is also a VDSO entry for compare and exchange, which
   allows kernels with the A extension to execute user code without the A
   extension reasonably fast.

 * Our user-visible register state now contains enough space for the Q
   extension for 128-bit floating point, as well as a few words to allow
   extensibility to future ISA extensions like the eventual V extension for
   vectors.

 * A handful of driver cleanups, but these have been split into separate patch
   sets now so I won't duplicate them here.

The full list of patches is below

  [PATCH 1/9] RISC-V: Init and Halt Code
  [PATCH 2/9] RISC-V: Atomic and Locking Code
  [PATCH 3/9] RISC-V: Generic library routines and assembly
  [PATCH 4/9] RISC-V: ELF and module implementation
  [PATCH 5/9] RISC-V: Task implementation
  [PATCH 6/9] RISC-V: Device, timer, IRQs, and the SBI
  [PATCH 7/9] RISC-V: Paging and MMU
  [PATCH 8/9] RISC-V: User-facing API
  [PATCH 9/9] RISC-V: Build Infastructure

In case one gets eaten by the mailing list, this is also availiable as a git
tree on our Git Hub

  https://github.com/riscv/riscv-linux/tree/riscv-for-submission-arch-v3

This patch set just contains the arch code, we have various drivers that are
required to build and boot a RISC-V system.  A tree that contains this patch
set merged with all our other patch sets lives at

  https://github.com/riscv/riscv-linux/tree/riscv-for-submission-v3

  commit 319a127e0685ed294996e0e6b25b229f42ec1d6e
  Merge: a980edd4a4b7 e67734c51bc9
  Author: Palmer Dabbelt <palmer@dabbelt.com>
  Date:   Wed Jun 28 10:45:14 2017 -0700
  
      Merge branch 'riscv-for-submission-arch-v3' into riscv-for-submission-v3

If you're going to try to build or boot the kernel, I'd recommend using that.

Thanks to everyone who has helped review our port!
