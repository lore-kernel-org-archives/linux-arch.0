From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] signal bug fix for v4.14-rc8
Date: Wed, 01 Nov 2017 17:22:25 -0500
Message-ID: <87o9olfxlq.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:38870 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbdKAWWj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2017 18:22:39 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, linux-arch@vger.kernel.org

Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: c3aff086ea11f17f5c0bec77bdbf4365ba6b41fc signal: Fix name of SIGEMT in #if defined() check

When making the generic support for SIGEMT conditional on the presence
of SIGEMT I made a typo that causes it to fail to activate.  It was
noticed comparatively quickly but the bug report just made it to me
today.

From: Andrew Clayton <andrew@digital-domain.net>
Date: Wed, 1 Nov 2017 15:49:59 +0000
Subject: [PATCH] signal: Fix name of SIGEMT in #if defined() check

Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
added a check for SIGMET and NSIGEMT being defined. That SIGMET should
in fact be SIGEMT, with SIGEMT being defined in
arch/{alpha,mips,sparc}/include/uapi/asm/signal.h

This was actually pointed out by BenHutchings in a lwn.net comment
here https://lwn.net/Comments/734608/

Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Signed-off-by: Andrew Clayton <andrew@digital-domain.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 800a18f77732..8dcd8825b2de 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2698,7 +2698,7 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			[SIGSEGV] = { NSIGSEGV, SIL_FAULT },
 			[SIGBUS]  = { NSIGBUS,  SIL_FAULT },
 			[SIGTRAP] = { NSIGTRAP, SIL_FAULT },
-#if defined(SIGMET) && defined(NSIGEMT)
+#if defined(SIGEMT) && defined(NSIGEMT)
 			[SIGEMT]  = { NSIGEMT,  SIL_FAULT },
 #endif
 			[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
-- 
2.14.1
