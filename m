From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 16/39] UAPI: Fix sigset_t ordering problem
Date: Fri, 08 Jul 2011 15:25:33 +0100
Message-ID: <20110708142533.31344.92735.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab1GHO0O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:14 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

There's an ordering problem around the definition of sigset_t: the definition
in the kernel-specific header is referred to in the user-specific header data
structures, at least for x86.  When compiling userspace, the user-specific
header provides an alternate version of sigset_t.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/signal.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 598457c..40ef827 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -40,6 +40,8 @@ typedef unsigned long sigset_t;
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 #define SIGHUP		 1
 #define SIGINT		 2
 #define SIGQUIT		 3
