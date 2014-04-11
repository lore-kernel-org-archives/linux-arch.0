From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 00/15] wire up renameat2 syscall for various archs
Date: Fri, 11 Apr 2014 12:25:36 +0200
Message-ID: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:47127 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588AbaDKK0I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:08 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3934588eek.20
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:07 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This series wires up the recently added renameat2 syscall for archs that are
up-to-date in the sense that they appear to support the latest syscalls.  I
haven't touched the rest of them..

Plus three NR_syscalls miscalculation fixes.

Untested.

Thanks,
Miklos

---
Miklos Szeredi (15):
      i386: add renameat2 syscall
      arm: __NR_syscalls fix
      arm: add renameat2 syscall
      arm64: __NR_compat_syscalls fix
      arm64: add renameat2 syscall
      m68k: add renameat2 syscall
      mips: add renameat2 syscall
      ia64: add renameat2 syscall
      parisc: add renameat2 syscall
      powerpc: add renameat2 syscall
      s390: NR_syscalls fix
      s390: add renameat2 syscall
      sparc: add renameat2 syscall
      xtensa: add renameat2 syscall
      asm-generic: add renameat2 syscall

---
 arch/arm/include/asm/unistd.h          |  2 +-
 arch/arm/include/uapi/asm/unistd.h     |  1 +
 arch/arm/kernel/calls.S                |  1 +
 arch/arm64/include/asm/unistd32.h      |  3 ++-
 arch/ia64/include/asm/unistd.h         |  2 +-
 arch/ia64/include/uapi/asm/unistd.h    |  1 +
 arch/m68k/include/asm/unistd.h         |  2 +-
 arch/m68k/include/uapi/asm/unistd.h    |  1 +
 arch/m68k/kernel/syscalltable.S        |  1 +
 arch/mips/include/uapi/asm/unistd.h    | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S         |  1 +
 arch/mips/kernel/scall64-64.S          |  1 +
 arch/mips/kernel/scall64-n32.S         |  1 +
 arch/mips/kernel/scall64-o32.S         |  1 +
 arch/parisc/include/uapi/asm/unistd.h  |  3 ++-
 arch/parisc/kernel/syscall_table.S     |  1 +
 arch/powerpc/include/asm/systbl.h      |  1 +
 arch/powerpc/include/asm/unistd.h      |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h |  1 +
 arch/s390/include/uapi/asm/unistd.h    |  3 ++-
 arch/s390/kernel/compat_wrapper.c      |  1 +
 arch/s390/kernel/syscalls.S            |  1 +
 arch/sparc/include/uapi/asm/unistd.h   |  3 ++-
 arch/sparc/kernel/systbls_32.S         |  1 +
 arch/sparc/kernel/systbls_64.S         |  2 ++
 arch/x86/syscalls/syscall_32.tbl       |  1 +
 arch/xtensa/include/uapi/asm/unistd.h  |  5 ++++-
 include/uapi/asm-generic/unistd.h      |  4 +++-
 28 files changed, 46 insertions(+), 16 deletions(-)
