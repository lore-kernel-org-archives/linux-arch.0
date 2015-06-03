Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60082 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbbFCLOn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:14:43 -0400
Date: Wed, 3 Jun 2015 04:14:10 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-9df43ac1858ecddd8d380e08263302490232d7ea@git.kernel.org>
Reply-To: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
	  josh@joshtriplett.org, linux-api@vger.kernel.org, corbet@lwn.net,
	  mingo@kernel.org, linux-arch@vger.kernel.org,
	  linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	  torvalds@linux-foundation.org
Subject: [tip:core/documentation] Documentation/features/time:
  Add feature description and arch support status file for '
 context-tracking'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: corbet@lwn.net, josh@joshtriplett.org, linux-api@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Message-ID: <20150603111410.gQJDTum86MIwgtq6hVAdMPIsJz4O1vqvqHDpNqaV2dg@z>

Commit-ID:  9df43ac1858ecddd8d380e08263302490232d7ea
Gitweb:     http://git.kernel.org/tip/9df43ac1858ecddd8d380e08263302490232d7ea
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:38 +0200

Documentation/features/time: Add feature description and arch support status file for 'context-tracking'

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
 .../jump-labels => time/context-tracking}/arch-support.txt     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
similarity index 81%
copy from Documentation/features/core/jump-labels/arch-support.txt
copy to Documentation/features/time/context-tracking/arch-support.txt
index 136868b..a1e3eea 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          jump-labels
-#         Kconfig:       HAVE_ARCH_JUMP_LABEL
-#         description:   arch supports live patched, high efficiency branches
+# Feature name:          context-tracking
+#         Kconfig:       HAVE_CONTEXT_TRACKING
+#         description:   arch supports context tracking for NO_HZ_FULL
 #
     -----------------------
     |         arch |status|
@@ -28,11 +28,11 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |        s390: |  ok  |
+    |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: | TODO |
+    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
