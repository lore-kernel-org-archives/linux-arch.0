From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/11] xtensa queue 2013/08/30
Date: Fri, 30 Aug 2013 19:34:52 +0400
Message-ID: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:50488 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab3H3PfN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:13 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so1971105lbh.21
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:11 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris,

this is my current patch queue for xtensa, it is based on your for_next
branch.
There are fixes for the current issues:
- missing #include <asm/ftrace.h> that fixes build with enabled support for
  modules and tracing;
- fix for build warning on 64bit hosts;
- echo doesn't need -e, which breaks big endian variants build when the shell
  is dash;
- TIF_* flags are now checked atomically, and hardirqs tracing call is moved
  after possible rescheduling point;
- provide ccount_freq definition regardless of CONFIG_XTENSA_CALIBRATE_CCOUNT
  which fixes build with CONFIG_XTENSA_CALIBRATE_CCOUNT disabled;
- replace CCOUNT_PER_JIFFY with ccount_freq and simplify resulting
  expressions; remove CCOUNT_PER_JIFFY definition.
There's a patch that enables kernel preemption.
The rest are prerequisites and fixes for SMP:
- spinlock functions are renamed according to current kernel naming scheme,
  asm/spinlock_types.h is provided;
- exception handlers now get a3 and excsave reversed, exc_table reloads in
  entry.S are eliminated. This patch is ported from 2.6.29-smp;
- new fast_alloca handler is ported from 2.6.29-smp;
- __delay is fixed for small delays, which in turn fixes SMP kernel hangs
  with CONFIG_DEBUG_SPINLOCK enabled.

You can pull these changes from my git tree,
the following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:
  git://github.com/jcmvbkbc/linux-xtensa.git xtensa-fixes-for-upstream

Changes v1->v2:
- make __delay fix more explicit for constant delays less than 2;
- remove unneeded call to trace_hardirqs_off from TIF_* checking patch;
- add timer-related patches from Baruch Siach.
 
Baruch Siach (2):
  xtensa: fix !CONFIG_XTENSA_CALIBRATE_CCOUNT build failure
  xtensa: remove CCOUNT_PER_JIFFY

Chen Gang (1):
  xtensa: kernel: add "asm/ftrace.h" for pass compiling

Max Filippov (8):
  xtensa: fix arch spinlock function names
  xtensa: fix __delay for small loop count
  xtensa: fix build warning
  xtensa: check thread flags atomically on return from user exception
  xtensa: enable kernel preemption
  xtensa: keep a3 and excsave1 on entry to exception handlers
  xtensa: new fast_alloca handler
  xtensa: don't use echo -e needlessly

 arch/xtensa/Makefile                     |    4 +-
 arch/xtensa/boot/Makefile                |    2 +-
 arch/xtensa/include/asm/delay.h          |    9 +-
 arch/xtensa/include/asm/regs.h           |    1 +
 arch/xtensa/include/asm/spinlock.h       |   31 ++-
 arch/xtensa/include/asm/spinlock_types.h |   20 ++
 arch/xtensa/include/asm/timex.h          |    6 -
 arch/xtensa/kernel/align.S               |    5 +-
 arch/xtensa/kernel/coprocessor.S         |    9 +-
 arch/xtensa/kernel/entry.S               |  387 ++++++++++--------------------
 arch/xtensa/kernel/setup.c               |    4 +-
 arch/xtensa/kernel/time.c                |    8 +-
 arch/xtensa/kernel/vectors.S             |  250 ++++++++++++++-----
 arch/xtensa/kernel/xtensa_ksyms.c        |    3 +
 arch/xtensa/mm/misc.S                    |    4 +-
 15 files changed, 371 insertions(+), 372 deletions(-)
 create mode 100644 arch/xtensa/include/asm/spinlock_types.h

-- 
1.7.7.6
