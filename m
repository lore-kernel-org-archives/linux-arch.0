Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59941 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbbFCLLO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:11:14 -0400
Date: Wed, 3 Jun 2015 04:10:40 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-cc436a080ad45a0d98c5a37a4fd9c896ea6bcd8a@git.kernel.org>
Reply-To: josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	  akpm@linux-foundation.org, linux-arch@vger.kernel.org,
	  hpa@zytor.com, peterz@infradead.org, linux-api@vger.kernel.org,
	  torvalds@linux-foundation.org, mingo@kernel.org, corbet@lwn.net,
	  tglx@linutronix.de
Subject: [tip:core/documentation] Documentation/features/vm:
  Add feature description and arch support status file for 'THP'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: tglx@linutronix.de, corbet@lwn.net, torvalds@linux-foundation.org, mingo@kernel.org, linux-api@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, josh@joshtriplett.org
Message-ID: <20150603111040.sBKzG3kC8mm29iODDO1tJtdPiAf0f2NMky1NJA7E-AY@z>

Commit-ID:  cc436a080ad45a0d98c5a37a4fd9c896ea6bcd8a
Gitweb:     http://git.kernel.org/tip/cc436a080ad45a0d98c5a37a4fd9c896ea6bcd8a
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:09 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:35 +0200

Documentation/features/vm: Add feature description and arch support status file for 'THP'

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
 .../vm/{numa-memblock => THP}/arch-support.txt     | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
similarity index 62%
copy from Documentation/features/vm/numa-memblock/arch-support.txt
copy to Documentation/features/vm/THP/arch-support.txt
index e7c252a..972d02c 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -1,15 +1,15 @@
 #
-# Feature name:          numa-memblock
-#         Kconfig:       HAVE_MEMBLOCK_NODE_MAP
-#         description:   arch supports NUMA aware memblocks
+# Feature name:          THP
+#         Kconfig:       HAVE_ARCH_TRANSPARENT_HUGEPAGE
+#         description:   arch supports transparent hugepages
 #
     -----------------------
     |         arch |status|
     -----------------------
     |       alpha: | TODO |
     |         arc: |  ..  |
-    |         arm: |  ..  |
-    |       arm64: |  ..  |
+    |         arm: |  ok  |
+    |       arm64: |  ok  |
     |       avr32: |  ..  |
     |    blackfin: |  ..  |
     |         c6x: |  ..  |
@@ -17,20 +17,20 @@
     |         frv: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
-    |        ia64: |  ok  |
-    |        m32r: | TODO |
+    |        ia64: | TODO |
+    |        m32r: |  ..  |
     |        m68k: |  ..  |
-    |       metag: |  ok  |
-    |  microblaze: |  ok  |
+    |       metag: |  ..  |
+    |  microblaze: |  ..  |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
+    |     mn10300: |  ..  |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
-    |      parisc: |  ..  |
+    |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ok  |
-    |          sh: |  ok  |
+    |       score: |  ..  |
+    |          sh: |  ..  |
     |       sparc: |  ok  |
     |        tile: | TODO |
     |          um: |  ..  |
