Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:39307 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfE2Phu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 11:37:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190523003916.20726-1-ebiederm@xmission.com>
Date: Wed, 29 May 2019 10:37:41 -0500
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 22 May 2019 19:38:50 -0500")
Message-ID: <87k1e91dbu.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 00/26] signal: Remove task argument from force_sig_info
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190529153741.y2HGh5-KPw5Mm7LR_j0Vk9SSTTh0Mq6did7p-FAuDJI@z>

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Folks,
>
> If folks can look this over and see if I have missed something I would
> appreciate it.
>
> The force_sig_info interface is designed to handle synchronous exceptions
> like page faults.  The locking in force_sig_info does not handle being
> called on a remote task that is already running.  It has been a long
> standing problem over the years that it is not obvious to people that
> restriction exists or that force_sig is for exceptions and they call it
> somewhere inappropriate.  A recently fixed example is
> 6376360ecbe5 ("mm: hwpoison: use do_send_sig_info() instead of force_sig()").
>
> I was looking over the force_sig family of functions not long ago and
> realized that there really are not that many cases where they are called
> with on a process other than current and it is possible to remove the
> current parameter, which should make it hard to make this mistake naively.
>
> I found exactly two legitimate places where force_sig was being called on a
> non-current task.  On mips force_fcr31_sig is called in switch_to on next
> the task that we are in the middle of making current.  On parisc in
> user_enable_single_step on a task that is stopped in a SIGKILL safe way in
> ptrace.  Both to my eyes appear to meet all of the criterion for being
> safe to call from force_sig.  
>
> While reviewing that last ptrace case I found a funny corner case bug
> of PTRACE_KILL, and so that fix is included in this patset as well.
>
> Through "signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of
> force_sig" the patches in this patchset are bug fixes.  I don't think any
> of them are urgent as they have existed for a long time, but definitely worth
> fixes.
>
> The rest of the changes are cleanups that carefully remove the task parameters
> from the entire force_sig family of functions.  Until at last force_sig_info
> only takes a struct siginfo.

It has been a week.  I have applied this to my siginfo-next branch.

Eric

>
> Eric W. Biederman (26):
>   signal: Correct namespace fixups of si_pid and si_uid
>   signal/ptrace: Simplify and fix PTRACE_KILL
>   signal/arm64: Use force_sig not force_sig_fault for SIGKILL
>   signal/drbd: Use send_sig not force_sig
>   signal/bpfilter: Fix bpfilter_kernl to use send_sig not force_sig
>   signal/pid_namespace: Fix reboot_pid_ns to use send_sig not force_sig
>   signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig
>
>   signal: Remove task parameter from force_sigsegv
>   signal: Remove task parameter from force_sig
>   signal: Remove task parameter from force_sig_mceerr
>   signal/x86: Remove task parameter from send_sigtrap
>   signal/um: Remove task parameter from send_sigtrap
>   signal/sh: Remove tsk parameter from force_sig_info_fault
>   signal/riscv: Remove tsk parameter from do_trap
>   signal/nds32: Remove tsk parameter from send_sigtrap
>   signal/arm: Remove tsk parameter from ptrace_break
>   signal/arm: Remove tsk parameter from __do_user_fault
>   signal/unicore32: Remove tsk parameter from __do_user_fault
>   signal: Explicitly call force_sig_fault on current
>   signal: Use force_sig_fault_to_task for the two calls that don't deliver to current
>   signal: Remove the task parameter from force_sig_fault
>   signal: Properly set TRACE_SIGNAL_LOSE_INFO in __send_signal
>   signal: Move the computation of force into send_signal and correct it.
>   signal: Generate the siginfo in force_sig
>   signal: Factor force_sig_info_to_task out of force_sig_info
>   signal: Remove the signal number and task parameters from force_sig_info
>
>  arch/alpha/kernel/signal.c                |   4 +-
>  arch/alpha/kernel/traps.c                 |   2 +-
>  arch/alpha/mm/fault.c                     |   4 +-
>  arch/arc/kernel/process.c                 |   4 +-
>  arch/arc/kernel/signal.c                  |   2 +-
>  arch/arc/kernel/traps.c                   |   2 +-
>  arch/arc/mm/fault.c                       |   4 +-
>  arch/arm/include/asm/traps.h              |   2 +-
>  arch/arm/kernel/ptrace.c                  |   6 +-
>  arch/arm/kernel/signal.c                  |   4 +-
>  arch/arm/kernel/traps.c                   |   4 +-
>  arch/arm/mm/alignment.c                   |   2 +-
>  arch/arm/mm/fault.c                       |  13 +-
>  arch/arm64/kernel/traps.c                 |   9 +-
>  arch/c6x/kernel/signal.c                  |   2 +-
>  arch/c6x/kernel/traps.c                   |   2 +-
>  arch/csky/abiv1/alignment.c               |   2 +-
>  arch/csky/abiv2/fpu.c                     |   2 +-
>  arch/csky/kernel/signal.c                 |   4 +-
>  arch/csky/kernel/traps.c                  |   2 +-
>  arch/csky/mm/fault.c                      |   4 +-
>  arch/h8300/kernel/ptrace_h.c              |   4 +-
>  arch/h8300/kernel/ptrace_s.c              |   2 +-
>  arch/h8300/kernel/signal.c                |   2 +-
>  arch/hexagon/kernel/signal.c              |   2 +-
>  arch/hexagon/kernel/traps.c               |  12 +-
>  arch/hexagon/mm/vm_fault.c                |   4 +-
>  arch/ia64/kernel/brl_emu.c                |   6 +-
>  arch/ia64/kernel/signal.c                 |   8 +-
>  arch/ia64/kernel/traps.c                  |  24 +--
>  arch/ia64/kernel/unaligned.c              |   2 +-
>  arch/ia64/mm/fault.c                      |   2 +-
>  arch/m68k/kernel/signal.c                 |   4 +-
>  arch/m68k/kernel/traps.c                  |  20 +--
>  arch/m68k/mm/fault.c                      |   4 +-
>  arch/microblaze/kernel/exceptions.c       |   2 +-
>  arch/microblaze/kernel/signal.c           |   2 +-
>  arch/microblaze/mm/fault.c                |   2 +-
>  arch/mips/kernel/branch.c                 |  18 +--
>  arch/mips/kernel/kprobes.c                |   2 +-
>  arch/mips/kernel/signal.c                 |   8 +-
>  arch/mips/kernel/signal_n32.c             |   4 +-
>  arch/mips/kernel/signal_o32.c             |   8 +-
>  arch/mips/kernel/traps.c                  |  50 +++---
>  arch/mips/kernel/unaligned.c              |  20 +--
>  arch/mips/mm/fault.c                      |   4 +-
>  arch/mips/sgi-ip22/ip22-berr.c            |   2 +-
>  arch/mips/sgi-ip22/ip28-berr.c            |   2 +-
>  arch/mips/sgi-ip27/ip27-berr.c            |   2 +-
>  arch/mips/sgi-ip32/ip32-berr.c            |   2 +-
>  arch/nds32/kernel/fpu.c                   |   2 +-
>  arch/nds32/kernel/signal.c                |   2 +-
>  arch/nds32/kernel/traps.c                 |  17 +-
>  arch/nds32/mm/fault.c                     |   4 +-
>  arch/nios2/kernel/signal.c                |   4 +-
>  arch/nios2/kernel/traps.c                 |   2 +-
>  arch/openrisc/kernel/signal.c             |   2 +-
>  arch/openrisc/kernel/traps.c              |  12 +-
>  arch/openrisc/mm/fault.c                  |   4 +-
>  arch/parisc/kernel/ptrace.c               |   6 +-
>  arch/parisc/kernel/signal.c               |   2 +-
>  arch/parisc/kernel/traps.c                |  14 +-
>  arch/parisc/kernel/unaligned.c            |   4 +-
>  arch/parisc/math-emu/driver.c             |   2 +-
>  arch/parisc/mm/fault.c                    |   4 +-
>  arch/powerpc/kernel/process.c             |   2 +-
>  arch/powerpc/kernel/signal_32.c           |   6 +-
>  arch/powerpc/kernel/signal_64.c           |   2 +-
>  arch/powerpc/kernel/traps.c               |   4 +-
>  arch/powerpc/mm/fault.c                   |   5 +-
>  arch/powerpc/platforms/cell/spufs/fault.c |   9 +-
>  arch/powerpc/platforms/cell/spufs/run.c   |   2 +-
>  arch/riscv/include/asm/bug.h              |   2 +-
>  arch/riscv/kernel/signal.c                |   2 +-
>  arch/riscv/kernel/traps.c                 |  11 +-
>  arch/riscv/mm/fault.c                     |   6 +-
>  arch/s390/kernel/compat_signal.c          |   4 +-
>  arch/s390/kernel/signal.c                 |   4 +-
>  arch/s390/kernel/traps.c                  |   6 +-
>  arch/s390/mm/fault.c                      |   6 +-
>  arch/sh/kernel/cpu/sh2a/fpu.c             |   2 +-
>  arch/sh/kernel/cpu/sh4/fpu.c              |   2 +-
>  arch/sh/kernel/cpu/sh5/fpu.c              |   4 +-
>  arch/sh/kernel/hw_breakpoint.c            |   2 +-
>  arch/sh/kernel/ptrace_64.c                |   4 +-
>  arch/sh/kernel/signal_32.c                |   4 +-
>  arch/sh/kernel/signal_64.c                |   4 +-
>  arch/sh/kernel/traps.c                    |   4 +-
>  arch/sh/kernel/traps_32.c                 |  10 +-
>  arch/sh/kernel/traps_64.c                 |   2 +-
>  arch/sh/math-emu/math.c                   |   2 +-
>  arch/sh/mm/fault.c                        |  11 +-
>  arch/sparc/kernel/process_64.c            |   4 +-
>  arch/sparc/kernel/signal32.c              |   8 +-
>  arch/sparc/kernel/signal_32.c             |   4 +-
>  arch/sparc/kernel/signal_64.c             |   8 +-
>  arch/sparc/kernel/sys_sparc_32.c          |   2 +-
>  arch/sparc/kernel/sys_sparc_64.c          |   2 +-
>  arch/sparc/kernel/traps_32.c              |   4 +-
>  arch/sparc/kernel/traps_64.c              |  41 +++--
>  arch/sparc/mm/fault_32.c                  |   4 +-
>  arch/sparc/mm/fault_64.c                  |   2 +-
>  arch/um/kernel/exec.c                     |   2 +-
>  arch/um/kernel/ptrace.c                   |   7 +-
>  arch/um/kernel/skas/mmu.c                 |   2 +-
>  arch/um/kernel/tlb.c                      |   4 +-
>  arch/um/kernel/trap.c                     |  16 +-
>  arch/unicore32/kernel/signal.c            |   4 +-
>  arch/unicore32/kernel/traps.c             |   2 +-
>  arch/unicore32/mm/fault.c                 |  13 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c     |   4 +-
>  arch/x86/include/asm/ptrace.h             |   3 +-
>  arch/x86/kernel/cpu/mce/core.c            |   2 +-
>  arch/x86/kernel/ptrace.c                  |   9 +-
>  arch/x86/kernel/signal.c                  |   2 +-
>  arch/x86/kernel/traps.c                   |  10 +-
>  arch/x86/kernel/umip.c                    |   2 +-
>  arch/x86/kernel/uprobes.c                 |   2 +-
>  arch/x86/kernel/vm86_32.c                 |   2 +-
>  arch/x86/mm/fault.c                       |   9 +-
>  arch/x86/mm/mpx.c                         |   2 +-
>  arch/x86/um/signal.c                      |   4 +-
>  arch/xtensa/kernel/signal.c               |   2 +-
>  arch/xtensa/kernel/traps.c                |   8 +-
>  arch/xtensa/mm/fault.c                    |   4 +-
>  drivers/block/drbd/drbd_int.h             |   2 +-
>  drivers/block/drbd/drbd_main.c            |   2 +-
>  drivers/block/drbd/drbd_nl.c              |   2 +-
>  drivers/misc/lkdtm/bugs.c                 |   2 +-
>  fs/cifs/connect.c                         |   2 +-
>  fs/exec.c                                 |   2 +-
>  include/linux/ptrace.h                    |   2 +-
>  include/linux/sched/signal.h              |  13 +-
>  include/linux/syscalls.h                  |   2 +-
>  kernel/events/uprobes.c                   |   4 +-
>  kernel/pid_namespace.c                    |   2 +-
>  kernel/ptrace.c                           |  43 +++--
>  kernel/rseq.c                             |   4 +-
>  kernel/seccomp.c                          |   2 +-
>  kernel/signal.c                           | 182 ++++++++++++++--------
>  mm/memory-failure.c                       |   2 +-
>  net/bpfilter/bpfilter_kern.c              |   2 +-
>  security/safesetid/lsm.c                  |   4 +-
>  143 files changed, 510 insertions(+), 465 deletions(-)
