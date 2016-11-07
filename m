From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][ATCH 0/3] sycalls: Remove args i and n from syscall_get_arguments()
Date: Mon, 07 Nov 2016 16:26:34 -0500
Message-ID: <20161107212634.529267342@goodmis.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbcKGVcj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Nov 2016 16:32:39 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

At Linux Plumbers, Andy Lutomirski approached me to tell me that the
syscall_get_arguments() implementation in x86 was horrible and gcc
certainly gets it wrong. He said that since the tracepoints only pass
in 0 and 6 for i and n repectively, it should be optimized for that case.
Inspecting the kernel, I discovered that all users pass in 0 for i and
only one file passing in something other than 6 for the number of arguments.
That code happens to be my own code used for the special syscall tracing.
That can easily be converted to just using 0 and 6 as well, and only copying
what is needed. Which is probably the faster path anyway for that case.

I haven't run the numbers (I can do that when I get some time), but since
pretty much all use cases use 0 and 6 and that would allow these functions
not to need strange logic to handle odd cases, I think this is still a win.

I haven't looked at removing those same parameters from syscall_set_arguments()
yet.

Thoughts?

-- Steve


Steven Rostedt (3):
      ptrace: Remove maxargs from task_current_syscall()
      tracing/syscalls: Pass in hardcoded '6' into syscall_get_arguments()
      syscalls: Remove start and number from syscall_get_arguments() args

----
 arch/arc/include/asm/syscall.h        |  7 ++--
 arch/arm/include/asm/syscall.h        | 23 ++---------
 arch/arm64/include/asm/syscall.h      | 22 ++---------
 arch/blackfin/include/asm/syscall.h   | 22 +++++++----
 arch/c6x/include/asm/syscall.h        | 41 ++++----------------
 arch/frv/include/asm/syscall.h        | 26 +++----------
 arch/h8300/include/asm/syscall.h      | 34 ++++-------------
 arch/hexagon/include/asm/syscall.h    |  4 +-
 arch/ia64/include/asm/syscall.h       |  5 +--
 arch/metag/include/asm/syscall.h      |  4 +-
 arch/microblaze/include/asm/syscall.h |  4 +-
 arch/mips/include/asm/syscall.h       |  3 +-
 arch/mn10300/include/asm/syscall.h    | 32 +++-------------
 arch/nios2/include/asm/syscall.h      | 42 ++++----------------
 arch/openrisc/include/asm/syscall.h   |  6 +--
 arch/parisc/include/asm/syscall.h     | 30 ++++-----------
 arch/powerpc/include/asm/syscall.h    |  8 ++--
 arch/s390/include/asm/syscall.h       | 11 +++---
 arch/sh/include/asm/syscall_32.h      | 26 +++----------
 arch/sh/include/asm/syscall_64.h      |  4 +-
 arch/sparc/include/asm/syscall.h      |  4 +-
 arch/tile/include/asm/syscall.h       |  4 +-
 arch/um/include/asm/syscall-generic.h | 39 +++----------------
 arch/x86/include/asm/syscall.h        | 72 ++++++++---------------------------
 fs/proc/base.c                        |  2 +-
 include/asm-generic/syscall.h         | 11 ++----
 include/linux/ptrace.h                |  4 +-
 include/trace/events/syscalls.h       |  2 +-
 kernel/seccomp.c                      |  2 +-
 kernel/trace/trace_syscalls.c         | 10 +++--
 lib/syscall.c                         | 22 ++++-------
 31 files changed, 139 insertions(+), 387 deletions(-)
