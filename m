Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:45945 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRFdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:33:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 18 Sep 2018 02:03:04 +0200
Message-ID: <87y3bzk6yv.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 00/20] siginfo cleanups for x86
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918000304.b-cQ_qo58tofkC1Lp1KkbbdjZi3IccJoSeKV0Y8fz8E@z>


I have been slowly going thought and reworking the arch specific
functions that generate siginfo.  The problems I have been addressing
is that using siginfo directly is error prone.  Using siginfo directly
makes it easy to leave fields initialized, and get confused about
which fields need to be filled in.

To address this I have added a series of helper functions to
kernel/signal.c, that are specific to exactly one use of struct siginfo
and take the parameters they need.

To use these functions the x86 signal handling needs some cleanups but
the net result appears to be less code that is easier to follow.

If while looking over these patches you see anything please let me know.
I don't think I missed something but to err is human.

Likewise if you would like to merge these patches via the tip tree
let me know.  Otherwise after the review is complete I plan on merging
these into my siginfo tree.  At this point I believe all of the
prerequisite patches are merged so it should not make a difference.

Eric W. Biederman (20):
      signal: Simplify tracehook_report_syscall_exit
      signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
      signal/x86: Move MCE error reporting out of force_sig_info_fault
      signal/x86: Use send_sig_mceerr as apropriate
      signal/x86: In trace_mpx_bounds_register_exception add __user annotations
      signal/x86: Move mpx siginfo generation into do_bounds
      signal/x86/traps: Factor out show_signal
      signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
      signal/x86/traps: Use force_sig_bnderr
      signal/x86/traps: Use force_sig instead of open coding it.
      signal/x86/traps: Simplify trap generation
      signal/x86: Remove pkey parameter from bad_area_nosemaphore
      signal/x86: Remove the pkey parameter from do_sigbus
      signal/x86: Remove pkey parameter from mm_fault_error
      signal/x86: Don't compute pkey in __do_page_fault
      signal/x86: Pass pkey not vma into __bad_area
      signal/x86: Call force_sig_pkuerr from __bad_area_nosemaphore
      signal/x86: Replace force_sig_info_fault with force_sig_fault
      signal/x86: Pass pkey by value
      signal/x86: Use force_sig_fault where appropriate

 arch/powerpc/include/asm/ptrace.h     |   2 +-
 arch/powerpc/kernel/traps.c           |   7 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |   9 +-
 arch/x86/include/asm/mpx.h            |  13 ++-
 arch/x86/include/asm/ptrace.h         |   2 +-
 arch/x86/include/asm/trace/mpx.h      |   4 +-
 arch/x86/kernel/ptrace.c              |  29 ++----
 arch/x86/kernel/traps.c               | 175 ++++++++++++++--------------------
 arch/x86/kernel/umip.c                |   8 +-
 arch/x86/kvm/mmu.c                    |  11 +--
 arch/x86/mm/fault.c                   | 161 +++++++++++--------------------
 arch/x86/mm/mpx.c                     |  30 ++----
 include/linux/ptrace.h                |  17 ++--
 include/linux/tracehook.h             |  13 +--
 14 files changed, 175 insertions(+), 306 deletions(-)

Eric
