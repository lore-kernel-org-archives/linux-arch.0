Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59831 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbFCLI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:08:56 -0400
Date: Wed, 3 Jun 2015 04:08:21 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-bebcfbb0ceb5228f5931f6869a72b6e92ea10592@git.kernel.org>
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org,
	  linux-kernel@vger.kernel.org, josh@joshtriplett.org,
	  corbet@lwn.net, peterz@infradead.org, linux-arch@vger.kernel.org,
	  linux-api@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
	  torvalds@linux-foundation.org
Subject: [tip:core/documentation] Documentation/features/vm:
  Add feature description and arch support status file for 'huge-vmap'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, linux-api@vger.kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org, corbet@lwn.net, josh@joshtriplett.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, tglx@linutronix.de
Message-ID: <20150603110821.PSZ8w78LeOGZ32LUF2wAQWtOBmLTGA53JNnAXIwQV3w@z>

Commit-ID:  bebcfbb0ceb5228f5931f6869a72b6e92ea10592
Gitweb:     http://git.kernel.org/tip/bebcfbb0ceb5228f5931f6869a72b6e92ea10592
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:33 +0200

Documentation/features/vm: Add feature description and arch support status file for 'huge-vmap'

Cc: <linux-api@vger.kernel.org>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../features/{lib/strncasecmp => vm/huge-vmap}/arch-support.txt   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
similarity index 82%
copy from Documentation/features/lib/strncasecmp/arch-support.txt
copy to Documentation/features/vm/huge-vmap/arch-support.txt
index 12b1c93..af6816b 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          strncasecmp
-#         Kconfig:       __HAVE_ARCH_STRNCASECMP
-#         description:   arch provides an optimized strncasecmp() function
+# Feature name:          huge-vmap
+#         Kconfig:       HAVE_ARCH_HUGE_VMAP
+#         description:   arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
 #
     -----------------------
     |         arch |status|
@@ -35,6 +35,6 @@
     |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
-    |         x86: | TODO |
+    |         x86: |  ok  |
     |      xtensa: | TODO |
     -----------------------
