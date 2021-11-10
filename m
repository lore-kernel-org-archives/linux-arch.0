Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD24C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 10 Nov 2021 15:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CB16121F
	for <linux-arch@archiver.kernel.org>; Wed, 10 Nov 2021 15:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhKJPgE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:36:04 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:57264 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhKJPgD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Nov 2021 10:36:03 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43408)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mkpb9-00D7ay-Ag; Wed, 10 Nov 2021 08:33:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:49312 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mkpb7-0078Yj-3a; Wed, 10 Nov 2021 08:33:14 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Nov 2021 09:32:19 -0600
Message-ID: <87tugkm3gc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mkpb7-0078Yj-3a;;;mid=<87tugkm3gc.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ODbtNUjXRYXy9ycHDl6Q3sQqvT4ZS3h4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] exit cleanups for v5.16
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Linus,

Please pull the exit-cleanups-for-v5.16 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16

  HEAD: f91140e4553408cacd326624cd50fc367725e04a Arnd Bergmann <arnd@arndb.de>


While looking at some issues related to the exit path in the kernel I
found several instances where the code is not using the existing
abstractions properly.

This set of changes introduces force_fatal_sig a way of sending
a signal and not allowing it to be caught, and corrects the
misuse of the existing abstractions that I found.

A lot of the misuse of the existing abstractions are silly things such
as doing something after calling a no return function, rolling BUG by
hand, doing more work than necessary to terminate a kernel thread, or
calling do_exit(SIGKILL) instead of calling force_sig(SIGKILL).

In the review a deficiency in force_fatal_sig and force_sig_seccomp
where ptrace or sigaction could prevent the delivery of the signal was
found.  I have added a change that adds SA_IMMUTABLE to change that
makes it impossible to interrupt the delivery of those signals, and
allows backporting to fix force_sig_seccomp.

Arnd found an issue where a function passed to kthread_run had the wrong
prototype, and after my cleanup was failing to build.

Arnd Bergmann (1):
      soc: ti: fix wkup_m3_rproc_boot_thread return type

Eric W. Biederman (22):
      exit/doublefault: Remove apparently bogus comment about rewind_stack_do_exit
      exit: Remove calls of do_exit after noreturn versions of die
      reboot: Remove the unreachable panic after do_exit in reboot(2)
      signal/sparc32: Remove unreachable do_exit in do_sparc_fault
      signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
      signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
      signal/powerpc: On swapcontext failure force SIGSEGV
      signal/sparc: In setup_tsb_params convert open coded BUG into BUG
      signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
      signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
      signal/s390: Use force_sigsegv in default_trap_handler
      exit/kthread: Have kernel threads return instead of calling do_exit
      signal: Implement force_fatal_sig
      exit/syscall_user_dispatch: Send ordinary signals on failure
      signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
      signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig
      signal/x86: In emulate_vsyscall force a signal instead of calling do_exit
      exit/rtl8723bs: Replace the macro thread_exit with a simple return 0
      exit/rtl8712: Replace the macro thread_exit with a simple return 0
      exit/r8188eu: Replace the macro thread_exit with a simple return 0
      signal: Replace force_sigsegv(SIGSEGV) with force_fatal_sig(SIGSEGV)
      signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed

 arch/arc/kernel/process.c                          |  2 +-
 arch/m68k/kernel/traps.c                           |  2 +-
 arch/mips/kernel/r2300_fpu.S                       |  4 +--
 arch/mips/kernel/syscall.c                         |  9 ------
 arch/nds32/kernel/traps.c                          |  2 +-
 arch/nds32/mm/fault.c                              |  6 +---
 arch/openrisc/kernel/traps.c                       |  2 +-
 arch/openrisc/mm/fault.c                           |  4 +--
 arch/powerpc/kernel/signal_32.c                    |  6 ++--
 arch/powerpc/kernel/signal_64.c                    |  9 ++++--
 arch/s390/include/asm/kdebug.h                     |  2 +-
 arch/s390/kernel/dumpstack.c                       |  2 +-
 arch/s390/kernel/traps.c                           |  2 +-
 arch/s390/mm/fault.c                               |  2 --
 arch/sh/kernel/cpu/fpu.c                           | 10 ++++---
 arch/sh/kernel/traps.c                             |  2 +-
 arch/sh/mm/fault.c                                 |  2 --
 arch/sparc/kernel/signal_32.c                      |  4 +--
 arch/sparc/kernel/windows.c                        |  6 ++--
 arch/sparc/mm/fault_32.c                           |  1 -
 arch/sparc/mm/tsb.c                                |  2 +-
 arch/um/kernel/trap.c                              |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |  3 +-
 arch/x86/kernel/doublefault_32.c                   |  3 --
 arch/x86/kernel/vm86_32.c                          | 10 +++----
 arch/xtensa/kernel/traps.c                         |  2 +-
 arch/xtensa/mm/fault.c                             |  3 +-
 drivers/firmware/stratix10-svc.c                   |  4 +--
 drivers/soc/ti/wkup_m3_ipc.c                       |  7 +++--
 drivers/staging/r8188eu/core/rtw_cmd.c             |  2 +-
 drivers/staging/r8188eu/core/rtw_mp.c              |  2 +-
 drivers/staging/r8188eu/include/osdep_service.h    |  2 --
 drivers/staging/rtl8712/osdep_service.h            |  1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  2 +-
 .../rtl8723bs/include/osdep_service_linux.h        |  2 --
 fs/exec.c                                          |  2 +-
 fs/ocfs2/journal.c                                 |  5 +---
 include/linux/sched/signal.h                       |  1 +
 include/linux/signal_types.h                       |  3 ++
 include/uapi/asm-generic/signal-defs.h             |  1 +
 kernel/entry/syscall_user_dispatch.c               | 12 +++++---
 kernel/kthread.c                                   |  2 +-
 kernel/reboot.c                                    |  1 -
 kernel/signal.c                                    | 34 +++++++++++++++-------
 net/batman-adv/tp_meter.c                          |  2 +-
 48 files changed, 98 insertions(+), 97 deletions(-)

Link: https://lkml.kernel.org/r/87y26nmwkb.fsf@disp2133

Eric
