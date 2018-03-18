From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 0/6] remove in-kernel syscall invocations (part 3 == compat cruft)
Date: Sun, 18 Mar 2018 17:10:50 +0100
Message-ID: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Here is a third series of patches which reduce the number of syscall
invocations from within the kernel. Once this long-term goal is achieved,
the syscall entry path can be streamlined.

This series focuses on a few compat syscall definitions in arch/ which
have no other in-kernel users. In particular, it introduces generic compat
syscalls for a handful of mm- and fs-related functions. Their calling
convention depends on whether the architecture sets
	__ARCH_WANT_LE_COMPAT_SYS (little-endian calling convention)
and/or	__ARCH_WANT_COMPAT_SYS_WITH_PADDING.

As I am not used to non-x86 architectures, please bear with me in case I
broke something or missed some peculiarities. In particular, I was
surprised that a couple of compat syscall definitions used "u64" or
"unsigned long" as parameter definitions -- though the code makes it clear
that they expected an "u32" or an "unsigned int" instead. CVE-2009-0029
seems to be handled already by the compat_sys_*() compat_SyS_*() /
C_SYSC_*() indirection provided for by include/linux/compat.h. Or do I
miss something here?

I did not bother addressing metag and tile, as they are going away.
Parisc and sh (sys_sh32.c in particular) provide similar wrappers for
"native" (non-compat) use, so they are left as-is as well.

Patches 5 and 6 in this series are x86-only.

Thanks,
	Dominik

Dominik Brodowski (6):
  fs: provide a generic compat_sys_fallocate() implementation
  fs: provide a generic compat_sys_truncate64() implementation
  fs: provide generic compat_sys_p{read,write}64() implementations
  mm: provide generic compat_sys_readahead() implementation
  x86: use _do_fork() in compat_sys_x86_clone()
  x86: remove compat_sys_x86_waitpid()

 arch/mips/include/asm/unistd.h         |  8 ++++
 arch/mips/kernel/linux32.c             | 35 ---------------
 arch/mips/kernel/scall64-o32.S         | 10 ++---
 arch/powerpc/include/asm/unistd.h      |  5 +++
 arch/powerpc/kernel/sys_ppc32.c        | 30 -------------
 arch/s390/include/asm/unistd.h         |  4 ++
 arch/s390/kernel/compat_linux.c        | 33 --------------
 arch/s390/kernel/compat_linux.h        |  5 ---
 arch/s390/kernel/syscalls/syscall.tbl  | 10 ++---
 arch/sparc/include/asm/unistd.h        |  4 ++
 arch/sparc/kernel/sys_sparc32.c        | 41 -----------------
 arch/sparc/kernel/systbls.h            | 19 --------
 arch/sparc/kernel/systbls_64.S         |  4 +-
 arch/x86/entry/syscalls/syscall_32.tbl | 12 ++---
 arch/x86/ia32/sys_ia32.c               | 46 +------------------
 arch/x86/include/asm/sys_ia32.h        | 14 ------
 arch/x86/include/asm/unistd.h          |  5 +++
 fs/open.c                              | 52 +++++++++++++++++++++-
 fs/read_write.c                        | 74 +++++++++++++++++++++++++++++--
 include/linux/compat.h                 | 42 ++++++++++++++++++
 mm/readahead.c                         | 81 ++++++++++++++++++++++++----------
 21 files changed, 266 insertions(+), 268 deletions(-)

-- 
2.16.2
