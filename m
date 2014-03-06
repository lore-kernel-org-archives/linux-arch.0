From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 00/16] compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:07 +0100
Message-ID: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:54601 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbaCFPva (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:30 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:29 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B790117D8041
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:52:03 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpEXq49610798
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:14 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpPrO017307
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:26 -0700
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Hi all,

this patch series converts all common code compat syscalls to use the new
COMPAT_SYSCALL_DEFINE macros introduced by Al Viro.
My main motivation is to get rid of the 1400+ line s390 specific assembler
file which contains code for each and every compat system call to perform
proper sign, zero and pointer conversion.

Eventually the conversion is pretty trivial, except that for a couple of
compat syscalls argument types needed to be changed from e.g. 'long' to
'compat_long_t' so that the COMPAT_SYSCALL_DEFINE macro can perform
proper sign extension from the 32 bit compat system call argument like
it was orginally passed in from user space.

The patch series keeps the "noop" conversions (5-10) and those with type
changes (11-15) separate.

Patches 1-4 are just additional cleanup patches.

Especially I'd like to know from somebody familiar with the x32 ABI if
any of the type changes break x32?
I intentionally did not touch the preadv64 and pwritev64 compat system
calls since they have been explicitly added to allow x32 pass 64 bit
arguments.
However it's not obvious to me if any of my other compat system call
changes break x32 or not.

FWIW, this patch series omits the whole s390 patches, since I assume
they are not very interesting to non-s390 people ;)

The complete series (including the s390 only patches) is available at

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git compat

If nobody objects I'd like to have the branch integrated into linux-next
to get some additional testing.

So, please let me know if I screwed up something! :)

Thanks,
Heiko

Heiko Carstens (16):
      compat: let architectures define __ARCH_WANT_COMPAT_SYS_GETDENTS64
      compat: add COMPAT_SYSCALL_DEFINE0 macro
      ipc/compat_sys_msgrcv: change msgtyp type from long to compat_long_t
      fs/compat: optional preadv64/pwrite64 compat system calls
      kernel/compat: convert to COMPAT_SYSCALL_DEFINE
      net/compat: convert to COMPAT_SYSCALL_DEFINE
      mm/compat: convert to COMPAT_SYSCALL_DEFINE
      security/compat: convert to COMPAT_SYSCALL_DEFINE
      fs/compat: convert to COMPAT_SYSCALL_DEFINE
      ipc/compat: convert to COMPAT_SYSCALL_DEFINE
      fs/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
      ipc/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
      net/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
      kexec/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
      mm/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
      s390/compat: build error for large compat syscall args

(diffstat below includes the s390 only patches)

 arch/arm64/include/asm/unistd.h   |    1 +
 arch/mips/include/asm/unistd.h    |    1 -
 arch/s390/include/asm/compat.h    |    6 +-
 arch/s390/kernel/compat_linux.c   |  116 +--
 arch/s390/kernel/compat_linux.h   |   81 +--
 arch/s390/kernel/compat_signal.c  |    4 +-
 arch/s390/kernel/compat_wrapper.S | 1425 -------------------------------------
 arch/s390/kernel/compat_wrapper.c |  209 ++++++
 arch/s390/kernel/entry.h          |    6 +-
 arch/s390/kernel/syscalls.S       |  504 ++++++-------
 arch/x86/include/asm/unistd.h     |    3 +
 fs/compat.c                       |  121 ++--
 fs/compat_ioctl.c                 |    5 +-
 fs/exec.c                         |    6 +-
 fs/read_write.c                   |   36 +-
 include/linux/compat.h            |   62 +-
 include/linux/kexec.h             |    6 -
 include/linux/syscalls.h          |    2 +
 include/uapi/asm-generic/unistd.h |    1 +
 ipc/compat.c                      |   13 +-
 ipc/compat_mq.c                   |   32 +-
 kernel/compat.c                   |  100 +--
 kernel/kexec.c                    |    8 +-
 kernel/ptrace.c                   |    4 +-
 mm/mempolicy.c                    |   18 +-
 mm/process_vm_access.c            |   26 +-
 net/compat.c                      |   32 +-
 security/keys/compat.c            |    4 +-
 28 files changed, 828 insertions(+), 2004 deletions(-)

-- 
1.8.4.5
