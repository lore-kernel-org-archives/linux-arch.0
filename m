Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:39046 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXPId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:08:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 11:07:05 +0200
Message-ID: <871s9j462u.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20180924090705.NDj7y-Mw5oY8IlYYc6NeZL0Y80eEwq-t_sGz8JotoPs@z>


This is the continuation of my work to sort out signaling of exceptions
with siginfo.  The old signal sending functions by taking a siginfo
argument resulted in their callers having to deal with the fiddly nature
of siginfo directly.  In small numbers of callers this is not a problem
but in the number of callers in the kernel this resulted in cases
where fields were not initialized or improperly initialized before
being passed to userspace.

To avoid having to worry about those issues I have added new signal
sending functions that each deal wit a different siginfo case.  When
using these functions there is no room for the fiddly nature of siginfo
to cause mistakes.

This is my set of changes to update arm64 to use those functions.
Along with some refactoring so those functions can be cleanly used.

Folks please review and double check me.  I think I have kept these
changes simple and obviously correct but I am human and mess up
sometimes.

After these patches have had a chance to be reviewed I plan to merge
them by my siginfo tree.  If you would rather take them in the arm64
tree let me know.   All of the prerequisites should have been merged
through Linus's tree several releases ago.

Eric W. Biederman (15):
      signal/arm64: Push siginfo generation into arm64_notify_die
      signal/arm64: Remove unneeded tsk parameter from arm64_force_sig_info
      signal/arm64: Factor out arm64_show_signal from arm64_force_sig_info
      signal/arm64: Factor set_thread_esr out of __do_user_fault
      signal/arm64: Consolidate the two hwpoison cases in do_page_fault
      signal/arm64: For clarity separate the 3 signal sending cases in do_page_fault
      signal/arm64: Expand __do_user_fault and remove it
      signal/arm64: Only perform one esr_to_fault_info call in do_page_fault
      signal/arm64: Only call set_thread_esr once in do_page_fault
      signal/arm64: Add and use arm64_force_sig_fault where appropriate
      signal/arm64: Add and use arm64_force_sig_mceerr as appropriate
      signal/arm64: Remove arm64_force_sig_info
      signal/arm64: In ptrace_hbptriggered name the signal description string
      signal/arm64: Add and use arm64_force_sig_ptrace_errno_trap
      signal/arm64: Use send_sig_fault where appropriate

 arch/arm64/include/asm/system_misc.h |  3 +-
 arch/arm64/include/asm/traps.h       |  5 +-
 arch/arm64/kernel/debug-monitors.c   | 11 ++---
 arch/arm64/kernel/fpsimd.c           | 10 ++--
 arch/arm64/kernel/ptrace.c           | 16 +++---
 arch/arm64/kernel/sys_compat.c       | 13 ++---
 arch/arm64/kernel/traps.c            | 67 ++++++++++++-------------
 arch/arm64/mm/fault.c                | 94 +++++++++++++-----------------------
 8 files changed, 90 insertions(+), 129 deletions(-)
