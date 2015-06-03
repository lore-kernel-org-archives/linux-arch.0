Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59860 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbbFCLJe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:09:34 -0400
Date: Wed, 3 Jun 2015 04:09:03 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-61e06e71ccbba66c652ab741d43a9c9d0fd6a5a9@git.kernel.org>
Reply-To: linux-arch@vger.kernel.org, peterz@infradead.org,
	  torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	  hpa@zytor.com, josh@joshtriplett.org, linux-api@vger.kernel.org,
	  mingo@kernel.org, corbet@lwn.net, tglx@linutronix.de,
	  akpm@linux-foundation.org
Subject: [tip:core/documentation] Documentation/features/vm:
  Add feature description and arch support status file for '
 pmdp_splitting_flush'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: tglx@linutronix.de, corbet@lwn.net, mingo@kernel.org, linux-api@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, peterz@infradead.org, josh@joshtriplett.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Message-ID: <20150603110903.PqjdSOfHAwvo7nUqmaPfOhB4Tbi0XLf8n6b2nYNbQ6o@z>

Commit-ID:  61e06e71ccbba66c652ab741d43a9c9d0fd6a5a9
Gitweb:     http://git.kernel.org/tip/61e06e71ccbba66c652ab741d43a9c9d0fd6a5a9
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:02 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:34 +0200

Documentation/features/vm: Add feature description and arch support status file for 'pmdp_splitting_flush'

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
 .../sg-chain => vm/pmdp_splitting_flush}/arch-support.txt    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/vm/pmdp_splitting_flush/arch-support.txt
similarity index 77%
copy from Documentation/features/io/sg-chain/arch-support.txt
copy to Documentation/features/vm/pmdp_splitting_flush/arch-support.txt
index b9b6755..26f74b4 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/vm/pmdp_splitting_flush/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          sg-chain
-#         Kconfig:       ARCH_HAS_SG_CHAIN
-#         description:   arch supports chained scatter-gather lists
+# Feature name:          pmdp_splitting_flush
+#         Kconfig:       __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+#         description:   arch supports the pmdp_splitting_flush() VM API
 #
     -----------------------
     |         arch |status|
@@ -17,12 +17,12 @@
     |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
+    |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
     |       metag: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
     |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
@@ -31,7 +31,7 @@
     |        s390: |  ok  |
     |       score: | TODO |
     |          sh: | TODO |
-    |       sparc: |  ok  |
+    |       sparc: | TODO |
     |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
