Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfBMHHV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 02:07:21 -0500
From: guoren@kernel.org
Subject: [GIT PULL V3] csky fixes for v5.0-rc6
Date: Wed, 13 Feb 2019 15:07:08 +0800
Message-ID: <1550041628-19985-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190213070708.TjdlZVJ8YVa7sIzvvyNKvq-zDyNJ7S3oM3gsEaJYCW4@z>

Hi Linus,

This is third version of pull-request from csky, we removed all patches of drivers.

Best Regards
 Guo Ren

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 131aee8b9807bc98379fa5a0270389dbc7dcec90:

  csky: Fixup dead loop in show_stack (2019-02-13 09:48:14 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (5):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

----------------------------------------------------------------
Guo Ren (5):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

 arch/csky/include/asm/pgtable.h   |  9 +++++++--
 arch/csky/include/asm/processor.h |  4 ++--
 arch/csky/kernel/dumpstack.c      |  4 ++++
 arch/csky/kernel/ptrace.c         |  3 ++-
 arch/csky/kernel/smp.c            |  3 ++-
 arch/csky/mm/ioremap.c            | 14 ++++++++++++++
 6 files changed, 31 insertions(+), 6 deletions(-)
