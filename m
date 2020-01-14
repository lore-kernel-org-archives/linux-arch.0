Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgANUI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 0/4] Switching ARC to optimized generic strncpy_from_user
Date: Tue, 14 Jan 2020 12:08:42 -0800
Message-ID: <20200114200846.29434-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20200114200842.5_O8AQN6P2cak6HxjZMP_mZlgOmYJKaAyZ2plqyTwDE@z>

Hi,

This came up when trying to move ARC over to generic word-at-a-time
interface.

 - 1/4 is a trivial fix (and needed for ARC switch)
 - 2/4 is mucking with internals hence the RFC. I could very likely be
   overlooking some possible DoS / exploit issues and apologies in advance
   if thats the case but I felt like sharing it anyways to see what
   others think.
 - 3/4, 4/4 are ARC changes to remove the existing ARC version and
   switch to generic (needs 1/4).

Thx,
-Vineet

Vineet Gupta (4):
  asm-generic/uaccess: don't define inline functions if noinline lib/*
    in use
  lib/strncpy_from_user: Remove redundant user space pointer range check
  ARC: uaccess: remove noinline variants of __strncpy_from_user() and
    friends
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user

 arch/arc/Kconfig                      |  2 +
 arch/arc/include/asm/Kbuild           |  1 -
 arch/arc/include/asm/uaccess.h        | 87 ++-------------------------
 arch/arc/include/asm/word-at-a-time.h | 49 +++++++++++++++
 arch/arc/mm/extable.c                 | 23 -------
 include/asm-generic/uaccess.h         |  4 ++
 lib/strncpy_from_user.c               | 36 ++++-------
 lib/strnlen_user.c                    | 28 +++------
 8 files changed, 79 insertions(+), 151 deletions(-)
 create mode 100644 arch/arc/include/asm/word-at-a-time.h

-- 
2.20.1
