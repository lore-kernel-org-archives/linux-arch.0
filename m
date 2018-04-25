Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:35241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755687AbeDYQE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2018 12:04:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/17] asm-generic: Remove empty asm/unistd.h
Date: Wed, 25 Apr 2018 18:02:59 +0200
Message-ID: <20180425160311.2718314-6-arnd@arndb.de>
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com, viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Message-ID: <20180425160259.sTYx60depSG6CnnZHosa4tj6KzJ6lCWJt4mDLea-vQk@z>

Nothing is left in asm/unistd.h except for the redirect to
uapi/asm/unistd.h, so removing the file simply leads to that one being
used directly.  The linux/export.h inclusion is a leftover from commit
e1b5bb6d1236 ("consolidate cond_syscall and SYSCALL_ALIAS declarations")
and should not be used anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/unistd.h | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 include/asm-generic/unistd.h

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
deleted file mode 100644
index 71d2fcf9dbcd..000000000000
--- a/include/asm-generic/unistd.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <uapi/asm-generic/unistd.h>
-#include <linux/export.h>
-- 
2.9.0
