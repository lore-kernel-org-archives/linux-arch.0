From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] asm-generic updates for 2.6.37
Date: Sat,  9 Oct 2010 21:57:46 +0200
Message-ID: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62491 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760528Ab0JIT6J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Oct 2010 15:58:09 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <akinobu.mita@gmail.com>, Andrea Gelmini <andrea.gelmini@gelma.net>, Andrew Morton <akpm@linux-foundation.org>, Chris Metcalf <cmetcalf@tilera.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Lucian Adrian Grijincu <lucian.grijincu@gmail.com>, Mathieu Lacage <mathieu.lacage@inria.fr>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

These are the patches that I have queued up for asm-generic
for the next merge window and that should now show up
in linux-next.

Please tell me if there is something else that should be there
or if one of them should not be. Otherwise I'll submit them
for inclusion in 2.6.37-rc1.

	Arnd
---

Akinobu Mita (2):
  bitops: make asm-generic/bitops/find.h more generic
  bitops: remove duplicated extern declarations

Andrea Gelmini (1):
  asm-generic: kdebug.h: Checkpatch cleanup

Lucian Adrian Grijincu (1):
  asm-generic: fcntl: make exported headers use strict posix types

Mathieu Lacage (2):
  asm-generic: make atomic_add_unless a function
  asm-generic: cmpxchg does not handle non-long arguments

 arch/tile/include/asm/bitops.h    |    1 +
 arch/x86/include/asm/bitops.h     |    2 +
 include/asm-generic/atomic.h      |   34 ++++++++++++++--------------
 include/asm-generic/bitops/find.h |   39 ++++++++++++++++++++++++++++++-
 include/asm-generic/fcntl.h       |    2 +-
 include/asm-generic/kdebug.h      |    2 +-
 include/asm-generic/system.h      |   20 +---------------
 include/linux/bitops.h            |   45 -------------------------------------
 8 files changed, 60 insertions(+), 85 deletions(-)

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
Cc: Mathieu Lacage <mathieu.lacage@inria.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
