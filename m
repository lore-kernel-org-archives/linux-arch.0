From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Sat,  7 Apr 2018 09:46:48 +0200
Message-ID: <20180407074651.29014-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Ingo,

as discussed yesterday, here is a mini-series (mostly) implementing your
suggestion on how to tidy up the naming convention for syscall stubs.

For the generic case, we now will have:

t	        kernel_waitid	# common C function (see kernel/exit.c)

i	      __in_sys_waitid	# inlined helper doing the actual work
				# (takes parameters as declared)

T	      __do_sys_waitid	# C function calling inlined helper
				# (takes parameters of type long; casts
				#  them to the declared type)

i	__in_compat_sys_waitid	# inlined helper doing the actual work
				  (takes parameters as declared)

T	__do_compat_sys_waitid	# compat C function calling inlined helper
				# (takes parameters of type long, casts
				#  them to unsigned long and then to the
				#  declared type)

T	            sys_waitid	# alias to __do_sys_waitid() (taking
				# parameters as declared), to be included
				# in syscall table

T	     compat_sys_waitid	# alias to __do_compat_sys_waitid()
				# (taking parameters as declared), to
				# be included in syscall table


For 64-bit x86, kernel_waitid, __do_sys_waitid and __in_sys_waitid are the
same. But instead of sys_waitid and compat_sys_waitid, there are:

T	      __x64_sys_waitid	# x86 64-bit-ptregs -> C stub, calls
				# __do_sys_waitid(); to be included in
				# syscall table

T	     __ia32_sys_waitid	# IA32_EMULATION 32-bit-ptregs -> C stub,
				# calls __do_sys_waitid(); to be included
				# in syscall table unless there is a
				# compat syscall stub [in that case, it is
				# unused]

T     __ia32_compat_sys_waitid	# IA32_EMULATION 32-bit-ptregs -> C stub,
				# calls __do_compat_sys_waitid(); to be
				# included in syscall table

T      __x32_compat_sys_waitid	# x32 64-bit-ptregs -> C stub, calls
				# __do_compat_sys_waitid(); to be included
				# in syscall table

In short (0xffffffff prefix removed, re-ordered):

810f0af0 t            kernel_waitid	# common (32/64) kernel helper

<inline>            __in_sys_waitid	# inlined helper doing actual work
810f0be0 t          __do_sys_waitid	# C func calling inlined helper

<inline>     __in_compat_sys_waitid	# inlined helper doing actual work
810f0d80 t   __do_compat_sys_waitid	# compat C func calling inlined helper

810f2080 T         __x64_sys_waitid	# x64 64-bit-ptregs -> C stub
810f20b0 T        __ia32_sys_waitid	# ia32 32-bit-ptregs -> C stub [unused]
810f2470 T __ia32_compat_sys_waitid	# ia32 32-bit-ptregs -> compat C stub
810f2490 T  __x32_compat_sys_waitid	# x32 64-bit-ptregs -> compat C stub

The kbuild test robot barked at an alleged +20038 bytes kernel size regression
for i386-tinyconfig due to the first patch of this series. That seems to be a
false positive, as it likely doesn't take into account the change to
scripts/bloat-o-meter. Moreover, I could not reproduce such a size regression
on local i386 builds.

Thanks,
	Dominik

Dominik Brodowski (3):
  syscalls: clean up syscall stub naming convention
  syscalls: clean up compat syscall stub naming convention
  syscalls: rename struct pt_regs-based sys_*() to __x64_sys_*()

 Documentation/process/adding-syscalls.rst |   4 +-
 arch/x86/entry/syscalls/syscall_32.tbl    | 720 +++++++++++-----------
 arch/x86/entry/syscalls/syscall_64.tbl    | 710 ++++++++++-----------
 arch/x86/entry/syscalls/syscalltbl.sh     |  14 +-
 arch/x86/entry/vsyscall/vsyscall_64.c     |   6 +-
 arch/x86/include/asm/syscall_wrapper.h    | 142 +++--
 arch/x86/include/asm/syscalls.h           |   2 +-
 include/linux/compat.h                    |  24 +-
 include/linux/syscalls.h                  |  12 +-
 scripts/bloat-o-meter                     |   4 +-
 10 files changed, 841 insertions(+), 797 deletions(-)

-- 
2.17.0
