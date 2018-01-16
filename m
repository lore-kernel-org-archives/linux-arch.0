Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37847 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAPAkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:40:20 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87373b6ghs.fsf@xmission.com> <87vag6zupo.fsf@xmission.com>
Date: Mon, 15 Jan 2018 18:39:29 -0600
In-Reply-To: <87vag6zupo.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 12 Jan 2018 14:29:55 -0600")
Message-ID: <87k1wimybi.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 00/22] siginfo unification
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org
Message-ID: <20180116003929.UwPW5AoNVQqUiBQPnl76yyUfwoA6W11l_9NLYhQDMX4@z>


The following changes are available at:
    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git  siginfo-testing

This set of changes unifies struct siginfo and struct compat_siginfo so
that there is only one definition of each.  Additionally this ends up
with a single implementation of copy_siginfo_to_user32 and
copy_siginfo_from_user32.

This results in much less code, that might be slightly less readable as
it handles all of the cases it needs to deal with instead of just a few.
Not a single implementation of copy_siginfo_to_user32 or
copy_siginfo_from_user32 handled all of the ways data is encoded in
struct siginfo today.

Hopefully this will result in much more maintainable code.

Al Viro (3):
      signal/mips: switch mips to generic siginfo
      signal: kill __ARCH_SI_UID_T
      signal: unify compat_siginfo_t

Eric W. Biederman (19):
      signal: Document all of the signals that use the _sigfault union member
      signal: Document the strange si_codes used by ptrace event stops
      signal: Document glibc's si_code of SI_ASYNCNL
      signal: Ensure no siginfo union member increases the size of struct siginfo
      signal: Clear si_sys_private before copying siginfo to userspace
      signal: Remove _sys_private and _overrun_incr from struct compat_siginfo
      ia64/signal: switch to generic struct siginfo
      signal/ia64: switch the last arch-specific copy_siginfo_to_user() to generic version
      signal: Remove unnecessary ifdefs now that there is only one struct siginfo
      signal: Move addr_lsb into the _sigfault union for clarity
      signal/powerpc: Remove redefinition of NSIGTRAP on powerpc
      signal/ia64: Move the ia64 specific si_codes to asm-generic/siginfo.h
      signal/frv: Move the frv specific si_codes to asm-generic/siginfo.h
      signal/tile: Move the tile specific si_codes to asm-generic/siginfo.h
      signal/blackfin: Move the blackfin specific si_codes to asm-generic/siginfo.h
      signal/blackfin: Remove pointless UID16_SIGINFO_COMPAT_NEEDED
      signal: Unify and correct copy_siginfo_from_user32
      signal: Remove the code to clear siginfo before calling copy_siginfo_from_user32
      signal: Unify and correct copy_siginfo_to_user32

 arch/arm64/include/asm/compat.h          |  64 ----------
 arch/arm64/kernel/signal32.c             |  80 -------------
 arch/blackfin/include/uapi/asm/siginfo.h |  34 ------
 arch/frv/include/uapi/asm/Kbuild         |   1 +
 arch/frv/include/uapi/asm/siginfo.h      |  13 --
 arch/ia64/include/uapi/asm/siginfo.h     |  96 ---------------
 arch/ia64/kernel/signal.c                |  52 --------
 arch/mips/include/asm/compat.h           |  73 ------------
 arch/mips/include/uapi/asm/siginfo.h     |  86 +-------------
 arch/mips/kernel/signal32.c              |  67 -----------
 arch/parisc/include/asm/compat.h         |  64 ----------
 arch/parisc/kernel/signal32.c            | 106 -----------------
 arch/parisc/kernel/signal32.h            |   3 -
 arch/powerpc/include/asm/compat.h        |  65 ----------
 arch/powerpc/include/uapi/asm/siginfo.h  |   3 -
 arch/powerpc/kernel/signal_32.c          |  66 -----------
 arch/s390/include/asm/compat.h           |  73 ------------
 arch/s390/kernel/compat_signal.c         | 100 ----------------
 arch/sparc/include/asm/compat.h          |  59 ---------
 arch/sparc/kernel/signal32.c             |  69 -----------
 arch/tile/include/asm/compat.h           |  62 ----------
 arch/tile/include/uapi/asm/siginfo.h     |   8 --
 arch/tile/kernel/compat_signal.c         |  73 ------------
 arch/x86/include/asm/compat.h            |  86 +-------------
 arch/x86/include/asm/fpu/signal.h        |   6 -
 arch/x86/kernel/signal_compat.c          | 123 ++-----------------
 include/linux/compat.h                   | 100 +++++++++++++++-
 include/linux/signal.h                   |   2 -
 include/uapi/asm-generic/siginfo.h       | 109 +++++++++++++----
 kernel/ptrace.c                          |   1 -
 kernel/signal.c                          | 197 +++++++++++++++++++++++++++++--
 31 files changed, 382 insertions(+), 1559 deletions(-)

Eric
