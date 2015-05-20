Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57959 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbbETPH5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2015 11:07:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/9] converting system calls to 64-bit time_t, part 2
Date: Wed, 20 May 2015 17:07:16 +0200
Message-ID: <1432134445-804487-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: baolin.wang@linaro.org, albert.aribaud@3adev.fr, john.stultz@linaro.org, bamvor.zhangjian@linaro.org, ruchandani.tina@gmail.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20150520150716.bhHpVrSUNlC8BbnM0d3igZqg9LVDy-LcpH--yXTEss4@z>

This is a follow-up to the series posted at [1]. To make review
a little easier, I'm focusing on just one class of system calls
here, and this is one that is handled differently from all the
others.

In particular, for sys_msgctl, sys_semctl and sys_shmctl, I do
not introduce a completely new set of replacement system calls,
but instead extend the existing ones to return data in the
reserved fields of the normal data structure.

This should be completely transparent to any existing user space,
and only after the 32-bit time_t wraps, it will make a difference
in the returned data.

libc implementations will consequently have to provide their own
data structures when they move to 64-bit time_t, and convert
the structures in user space from the ones returned by the kernel.

There are three cases here:

- little-endian architectures (except powerpc and mips) can use
  the normal layout and just cast the data structure to the
  user space type that contains 64-bit numbers.

- parisc and sparc can do the same thing with big-endian user
  space

- little-endian powerpc and most big-endian architectures have
  to flip the upper and lower 32-bit halves of the time_t value
  in memory, but can otherwise keep using the normal layout

- mips and big-endian xtensa need to be more careful because
  they are not consistent in their definitions, and they
  have to provide custom libc implementations for the system
  calls to use 64-bit time_t.

Please review.

	Arnd

[1] http://lwn.net/Articles/643407/

Arnd Bergmann (8):
  y2038: asm-generic: extend sysvipc data structures
  y2038: mips: extend sysvipc data structures
  y2038: x86: extend sysvipc data structures
  y2038: parisc: extend sysvipc data structures
  y2038: sparc: extend sysvipc data structures
  y2038: powerpc: extend sysvipc data structures
  y2038: xtensa: extend sysvipc data structures
  y2038: ipc: report long times to user space

 arch/arm64/include/asm/compat.h        | 32 +++++++++----------
 arch/mips/include/asm/compat.h         | 38 +++++++++++-----------
 arch/mips/include/uapi/asm/msgbuf.h    | 56 +++++++++++++++++++++-----------
 arch/mips/include/uapi/asm/sembuf.h    | 15 +++++++--
 arch/mips/include/uapi/asm/shmbuf.h    | 23 ++++++++++++--
 arch/parisc/include/asm/compat.h       | 32 +++++++++----------
 arch/parisc/include/uapi/asm/msgbuf.h  | 32 +++++++++----------
 arch/parisc/include/uapi/asm/sembuf.h  | 13 ++++----
 arch/parisc/include/uapi/asm/shmbuf.h  | 18 +++++------
 arch/powerpc/include/asm/compat.h      | 32 +++++++++----------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++++------
 arch/powerpc/include/uapi/asm/sembuf.h | 14 ++++----
 arch/powerpc/include/uapi/asm/shmbuf.h | 18 +++++------
 arch/sparc/include/asm/compat.h        | 32 +++++++++----------
 arch/sparc/include/uapi/asm/msgbuf.h   | 21 ++++++------
 arch/sparc/include/uapi/asm/sembuf.h   | 15 ++++-----
 arch/sparc/include/uapi/asm/shmbuf.h   | 20 ++++++------
 arch/tile/include/asm/compat.h         | 32 +++++++++----------
 arch/x86/include/asm/compat.h          | 32 +++++++++----------
 arch/x86/include/uapi/asm/msgbuf.h     | 41 +++++++++++++++++++++++-
 arch/x86/include/uapi/asm/sembuf.h     | 10 ++++++
 arch/x86/include/uapi/asm/shmbuf.h     | 58 +++++++++++++++++++++++++++++++++-
 arch/xtensa/include/uapi/asm/msgbuf.h  | 24 +++++++-------
 arch/xtensa/include/uapi/asm/sembuf.h  | 16 +++++-----
 arch/xtensa/include/uapi/asm/shmbuf.h  | 36 +++++----------------
 include/linux/msg.h                    |  7 ++--
 include/linux/sem.h                    |  3 +-
 include/linux/shm.h                    |  7 ++--
 include/uapi/asm-generic/msgbuf.h      | 16 +++++-----
 include/uapi/asm-generic/sembuf.h      | 26 +++++++++------
 include/uapi/asm-generic/shmbuf.h      | 16 +++++-----
 ipc/compat.c                           |  8 +++++
 ipc/msg.c                              | 23 ++++++++------
 ipc/sem.c                              | 32 +++++++++++--------
 ipc/shm.c                              | 21 +++++++-----
 35 files changed, 499 insertions(+), 338 deletions(-)

-- 
2.1.0.rc2

