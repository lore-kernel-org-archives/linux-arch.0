Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:44242 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 19:28:19 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 25 Sep 2018 19:19:01 +0200
Message-ID: <20180925171906.19683-1-ebiederm@xmission.com>
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
Subject: [REVIEW][PATCH 1/6] signal/sparc: Move EMT_TAGOVF into the generic siginfo.h
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180925171901.mC0FPnsgVPmMSol9uA5YmOnkFKTV7hkFYKs2M_OXYsg@z>

When moving all of the architectures specific si_codes into
siginfo.h, I apparently overlooked EMT_TAGOVF.  Move it now.

Remove the now redundant test in siginfo_layout for SIGEMT
as now NSIGEMT is always defined.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/include/uapi/asm/siginfo.h | 6 ------
 include/uapi/asm-generic/siginfo.h    | 6 ++++++
 kernel/signal.c                       | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index e7049550ac82..6c820ea0813b 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -17,10 +17,4 @@
 
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
-/*
- * SIGEMT si_codes
- */
-#define EMT_TAGOVF	1	/* tag overflow */
-#define NSIGEMT		1
-
 #endif /* _UAPI__SPARC_SIGINFO_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 80e2a7227205..1811b8101937 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -285,6 +285,12 @@ typedef struct siginfo {
 #define SYS_SECCOMP	1	/* seccomp triggered */
 #define NSIGSYS		1
 
+/*
+ * SIGEMT si_codes
+ */
+#define EMT_TAGOVF	1	/* tag overflow */
+#define NSIGEMT		1
+
 /*
  * sigevent definitions
  * 
diff --git a/kernel/signal.c b/kernel/signal.c
index e16278710b36..7b49c31d3fdb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2856,7 +2856,7 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 			[SIGSEGV] = { NSIGSEGV, SIL_FAULT },
 			[SIGBUS]  = { NSIGBUS,  SIL_FAULT },
 			[SIGTRAP] = { NSIGTRAP, SIL_FAULT },
-#if defined(SIGEMT) && defined(NSIGEMT)
+#if defined(SIGEMT)
 			[SIGEMT]  = { NSIGEMT,  SIL_FAULT },
 #endif
 			[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
-- 
2.17.1
