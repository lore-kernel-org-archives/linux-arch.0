From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 0/7] use struct pt_regs based syscall calling for x86-64
Date: Fri, 30 Mar 2018 11:37:13 +0200
Message-ID: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On top of all the patches which remove in-kernel calls to syscall functions
sent out yesterday[*[, it now becomes easy for achitectures to re-define the
syscall calling convention. For x86, this may be used to merely decode those
entries from struct pt_regs which are needed for a specific syscall.

	[*] http://lkml.kernel.org/r/20180329112426.23043-1-linux@dominikbrodowski.net

This approach avoids leaking random user-provided register content down
the call chain. Therefore, the last patch of this series extends the
register clearing in the entry path to a few more registers.

To exemplify: sys_recv() is a classic 4-parameter syscall. For this syscall,
the DEFINE_SYSCALL macro creates the following stub:

	asmlinkage long sys_recv(struct pt_regs *regs)
	{
		return SyS_recv(regs->di, regs->si, regs->dx, regs->r10);
	}

The assembly of that function then becomes, in slightly reordered fashion:

	<sys_recv>:
		callq	<__fentry__>

		/* decode regs->di, ->si, ->dx and ->r10 */
		mov	0x70(%rdi),%rdi
		mov	0x68(%rdi),%rsi
		mov	0x60(%rdi),%rdx
		mov	0x38(%rdi),%rcx

		[ SyS_recv() is inlined here by the compiler, as it is tiny ]
		/* clear %r9 and %r8, the 5th and 6th args */
		xor	%r9d,%r9d
		xor	%r8d,%r8d

		/* do the actual work */
		callq	__sys_recvfrom

		/* cleanup and return */
		cltq
		retq

For IA32_EMULATION and X32, additional care needs to be taken as they use
different registers to pass parameters to syscalls; vsyscalls need to be
modified to use this new calling convention as well.

This actual conversion of x86 syscalls is heavily based on a proof-of-concept
by Linus[*]. This patchset here differs, for example, as it provides a generic
config symbol ARCH_HAS_SYSCALL_WRAPPER, introduces <asm/syscall_wrapper.h>,
splits up the patch into several parts, and adds the actual register clearing.

	[*] Accessible at
	    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git WIP-syscall
	    It contains an additional patch
		x86: avoid per-cpu system call trampoline
	    which is not included in my series as it addresses a different
	    issue, but may be of interest to the x86 maintainers as well.

Compared to v4.16-rc5 baseline and on a random kernel config, these patches
(in combination with the large do-not-call-syscalls-in-the-kernel series)
lead to a minisculue increase in text (+0.005%) and data (+0.11%) size on a
pure 64bit system,

	    text	   data	   bss	     dec	    hex	filename
	18853337	9535476	938380	29327193	1bf7f59	vmlinux-orig
	18854227	9546100	938380	29338707	1bfac53	vmlinux,

with IA32_EMULATION and X32 enabled, the situation is just a little bit worse
for text size (+0.009%) and data (+0.38%) size.

	    text	   data	   bss	     dec	    hex	filename
	18902496	9603676	938444	29444616	1c14a08	vmlinux-orig
	18904136	9640604	938444	29483184	1c1e0b0 vmlinux.

The 64bit part of this series has worked flawlessly on my local system for a
few weeks. IA32_EMULATION and x32 has passed some basic testing as well, but
has not yet been tested as extensively as x86-64. Pure i386 kernels are left
as-is, as they use a different asmlinkage anyway.

A few questions remain, from important stuff to bikeshedding:

1) Is it acceptable to pass the existing struct pt_regs to the sys_*()
   kernel functions in emulate_vsyscall(), or should it use a hand-crafted
   struct pt_regs instead?

2) Is it the right approach to generate the __sys32_ia32_*() names to
   include in the syscall table on-the-fly, or should they all be listed
   in arch/x86/entry/syscalls/syscall_32.tbl ?

3) I have chosen to name the default 64-bit syscall stub sys_*(), same as
   the "normal" syscall, and the IA32_EMULATION compat syscall stub
   compat_sys_*(), same as the "normal" compat syscall. Though this
   might cause some confusion, as the "same" function uses a different
   calling convention and different parameters on x86, it has the
   advantages that
        - the kernel *has* a function sys_*() implementing the syscall,
          so those curious in stack traces etc. will find it in plain
          sight,
        - it is easier to handle in the syscall table generation, and
        - error injection works the same.


The whole series is available at

        https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-WIP

Thanks,
	Dominik

Dominik Brodowski (6):
  syscalls: introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER
  syscalls/x86: use struct pt_regs based syscall calling for 64bit
    syscalls
  syscalls: prepare ARCH_HAS_SYSCALL_WRAPPER for compat syscalls
  syscalls/x86: use struct pt_regs based syscall calling for
    IA32_EMULATION and x32
  syscalls/x86: unconditionally enable struct pt_regs based syscalls on
    x86_64
  x86/entry/64: extend register clearing on syscall entry to lower
    registers

Linus Torvalds (1):
  x86: don't pointlessly reload the system call number

 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/calling.h               |   2 +
 arch/x86/entry/common.c                |  20 ++--
 arch/x86/entry/entry_64.S              |   3 +-
 arch/x86/entry/entry_64_compat.S       |   6 ++
 arch/x86/entry/syscall_32.c            |  15 ++-
 arch/x86/entry/syscall_64.c            |   6 +-
 arch/x86/entry/syscalls/syscall_64.tbl |  74 ++++++-------
 arch/x86/entry/syscalls/syscalltbl.sh  |   8 ++
 arch/x86/entry/vsyscall/vsyscall_64.c  |  14 +--
 arch/x86/include/asm/syscall.h         |   4 +
 arch/x86/include/asm/syscall_wrapper.h | 189 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/syscalls.h        |  17 ++-
 include/linux/compat.h                 |  22 ++++
 include/linux/syscalls.h               |  25 ++++-
 init/Kconfig                           |  10 ++
 kernel/sys_ni.c                        |  10 ++
 kernel/time/posix-stubs.c              |  10 ++
 18 files changed, 365 insertions(+), 71 deletions(-)
 create mode 100644 arch/x86/include/asm/syscall_wrapper.h

-- 
2.16.3
