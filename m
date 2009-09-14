From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 11/11] Use unreachable() in asm-generic/bug.h for !CONFIG_BUG case.
Date: Mon, 14 Sep 2009 14:55:40 -0700
Message-ID: <1252965340-31735-11-git-send-email-ddaney@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932346AbZINV5M@vger.kernel.org>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-arch.vger.kernel.org

The subject says it all (most).  The only drawback here is that for a
pre-GCC-5.4 compiler, instead of expanding to nothing we now expand
BUG() to an endless loop.  Before the patch when configured with
!CONFIG_BUG() you might get some warnings, but the code would be
small.  After the patch there are no warnings, but there is an endless
loop at each BUG() site.

Of course for the GCC-4.5 case we get the best of both worlds.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Ingo Molnar <mingo@elte.hu>
CC: Ingo Molnar <mingo@elte.hu>
---
 include/asm-generic/bug.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 4b67559..e952242 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -89,11 +89,11 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() unreachable()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) unreachable(); } while (0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
1.6.2.5
