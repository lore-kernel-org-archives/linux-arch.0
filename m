Return-Path: <arnd@arndb.de>
Received: from natnoddy.rzone.de ([81.169.145.166]:45821 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262070AbUDDAfy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 3 Apr 2004 19:35:54 -0500
Received: from p508a8fcc.dip0.t-ipconnect.de (p508A8FCC.dip0.t-ipconnect.de [80.138.143.204])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i340ZqOj016348
	for <linux-arch@vger.kernel.org>; Sun, 4 Apr 2004 02:35:53 +0200 (MEST)
From: Arnd Bergmann <arnd@arndb.de>
Subject: consolidate compat readv/writev/execve/select/nfsservctl
Date: Sun, 4 Apr 2004 02:19:30 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404040219.30785.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I have taken a closer look at some of the compat syscall handlers that
have not been consolidated yet. I'm following up with patches to
introduce new compat_sys_* functions for the largest four ones. All of
these have some bugs on most architectures, usually resulting from
missing updates after the native handler was changed.

For readv, writev, execve and select, ia64 and x86_64 use a different
method from the others and I chose to use the more common one, which
is a bit more code but avoids an extra copy of the user data.

The patches apply both to todays 2.6.5-rc3 snapshot as well as
2.6.5-rc3-mm4. They are also available at
http://www.arndb.de/patches/linux/2.6.5-rc3/. They are compile tested
for s390x and x86_64 and I've checked them functionally (except
nfsservctl) with LTP on x86_64.

Please test.

	Arnd <><

 arch/ia64/ia32/ia32_entry.S        |    6 
 arch/ia64/ia32/sys_ia32.c          |  357 ---------------
 arch/mips/kernel/linux32.c         |  533 -----------------------
 arch/mips/kernel/scall64-n32.S     |    6 
 arch/mips/kernel/scall64-o32.S     |    6 
 arch/parisc/kernel/sys_parisc32.c  |  539 -----------------------
 arch/parisc/kernel/syscall_table.S |    8 
 arch/ppc64/kernel/misc.S           |    6 
 arch/ppc64/kernel/sys_ppc32.c      |  761 ---------------------------------
 arch/s390/kernel/compat_linux.c    |  699 ------------------------------
 arch/s390/kernel/compat_wrapper.S  |   40 -
 arch/s390/kernel/syscalls.S        |    8 
 arch/sparc64/kernel/sys_sparc32.c  |  749 --------------------------------
 arch/sparc64/kernel/sys_sunos32.c  |   16 
 arch/sparc64/kernel/systbls.S      |    8 
 arch/x86_64/ia32/ia32entry.S       |    8 
 arch/x86_64/ia32/sys_ia32.c        |  531 -----------------------
 fs/compat.c                        |  845 +++++++++++++++++++++++++++++++++++++
 include/linux/compat.h             |   13 
 19 files changed, 946 insertions(+), 4193 deletions(-)
