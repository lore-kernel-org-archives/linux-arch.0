Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfDANoX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 09:44:23 -0400
Message-ID: <20190401134104.676620247@goodmis.org>
Date: Mon, 01 Apr 2019 09:41:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/6 v3] sycalls: Remove args i and n from syscall_get_arguments()
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190401134104.CaTeZ5VFlMBad7zxcKJcv41chiWnW8AylUeYeEKGshY@z>

[ Looking for acks ]

Two and a half years ago I sent out 3 patches and a title letter that
had this[1]:

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

It received positive comments but also Linus asked to remove the separate
arg pointers and replace them with a single structure and fill that
instead. But for some reason, this got pushed aside and forgotten (probably,
had to do with the fact that I left Red Hat shortly after this).

Recently, it was brought back up again[2] and I decided to dust off these
patches and resubmit them. I also added one more patch to do the same
for syscall_set_arguments() that I did for syscall_get_arguments() even
though syscall_set_arguments() currently (and never has) had any callers.
But we are told that in the near future it may have one.

The changes do optimize the logic a little, but for most archs I just kept
the same logic (loops and such) as I don't have a way to test it, and
didn't want to break the logic.

I added a new struct syscall_info that holds seccomp_data and also
includes a stack pointer (sp) field. I would change seccomp_data,
but because its in include/uapi/linux/seccomp.h I didn't want to
touch it and break userspace. Perhaps we could add the field at the
end, but I didn't want to chance it (unless others say its OK).

I ran these through zero-day-bot and compiled tested these changes for
all architectures except for csky which I do not have a cross compiler
for.

Note the following archs fail normal builds, but they fail the same
with these patches:

   arc
   h8300
   parisc64

Note, you may notice that I have "(Red Hat)" as the author of the
first three patches (even though they are signed off by "(VMware)").
This is because those patches were originally written while I was
working for Red Hat. But as I forward ported them while working for
VMware, my signed-off-by reflects that.

[1] - https://lore.kernel.org/lkml/20161107212634.529267342@goodmis.org/T/#u
[2] - https://lore.kernel.org/lkml/20190326151244.GC16837@redhat.com/T/#u


Changes since v2:

 - Added Dmitry's two patches to fix riscv and csky
 - Rebased to handle the two new patches

Dmitry V. Levin (2):
      riscv: Fix syscall_get_arguments() and syscall_set_arguments()
      csky: Fix syscall_get_arguments() and syscall_set_arguments()

Steven Rostedt (Red Hat) (3):
      ptrace: Remove maxargs from task_current_syscall()
      tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
      syscalls: Remove start and number from syscall_get_arguments() args

Steven Rostedt (VMware) (1):
      syscalls: Remove start and number from syscall_set_arguments() args

----
 arch/arc/include/asm/syscall.h        |   7 +-
 arch/arm/include/asm/syscall.h        |  47 ++---------
 arch/arm64/include/asm/syscall.h      |  46 ++---------
 arch/c6x/include/asm/syscall.h        |  79 ++++---------------
 arch/csky/include/asm/syscall.h       |  26 ++-----
 arch/h8300/include/asm/syscall.h      |  34 ++------
 arch/hexagon/include/asm/syscall.h    |   4 +-
 arch/ia64/include/asm/syscall.h       |  13 +---
 arch/ia64/kernel/ptrace.c             |   7 +-
 arch/microblaze/include/asm/syscall.h |   8 +-
 arch/mips/include/asm/syscall.h       |   3 +-
 arch/mips/kernel/ptrace.c             |   2 +-
 arch/nds32/include/asm/syscall.h      |  62 +++------------
 arch/nios2/include/asm/syscall.h      |  84 ++++----------------
 arch/openrisc/include/asm/syscall.h   |  12 +--
 arch/parisc/include/asm/syscall.h     |  30 ++-----
 arch/powerpc/include/asm/syscall.h    |  15 ++--
 arch/riscv/include/asm/syscall.h      |  24 ++----
 arch/s390/include/asm/syscall.h       |  28 +++----
 arch/sh/include/asm/syscall_32.h      |  47 +++--------
 arch/sh/include/asm/syscall_64.h      |   8 +-
 arch/sparc/include/asm/syscall.h      |  11 ++-
 arch/um/include/asm/syscall-generic.h |  78 +++----------------
 arch/x86/include/asm/syscall.h        | 142 ++++++++--------------------------
 arch/xtensa/include/asm/syscall.h     |  33 ++------
 fs/proc/base.c                        |  17 ++--
 include/asm-generic/syscall.h         |  21 ++---
 include/linux/ptrace.h                |  11 ++-
 include/trace/events/syscalls.h       |   2 +-
 kernel/seccomp.c                      |   2 +-
 kernel/trace/trace_syscalls.c         |   9 ++-
 lib/syscall.c                         |  57 ++++++--------
 32 files changed, 247 insertions(+), 722 deletions(-)
