Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59910 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbFCLKg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:10:36 -0400
Date: Wed, 3 Jun 2015 04:09:58 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-4e3cd4571904933300620f5464872c4e10d3bd4a@git.kernel.org>
Reply-To: torvalds@linux-foundation.org, linux-arch@vger.kernel.org,
	  josh@joshtriplett.org, linux-api@vger.kernel.org,
	  linux-kernel@vger.kernel.org, mingo@kernel.org,
	  tglx@linutronix.de, akpm@linux-foundation.org, corbet@lwn.net,
	  peterz@infradead.org, hpa@zytor.com
Subject: [tip:core/documentation] Documentation/features/time:
  Add feature description and arch support status file for 'virt-cpuacct'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-arch@vger.kernel.org, josh@joshtriplett.org, torvalds@linux-foundation.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, corbet@lwn.net, tglx@linutronix.de, akpm@linux-foundation.org, peterz@infradead.org, hpa@zytor.com
Message-ID: <20150603110958.RBw7E-LQZy9i6Hgm1lkoNjaYlZfuVMAkXW35z3aNRBo@z>

Commit-ID:  4e3cd4571904933300620f5464872c4e10d3bd4a
Gitweb:     http://git.kernel.org/tip/4e3cd4571904933300620f5464872c4e10d3bd4a
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:05 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:34 +0200

Documentation/features/time: Add feature description and arch support status file for 'virt-cpuacct'

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
 .../{io/sg-chain => time/virt-cpuacct}/arch-support.txt    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
similarity index 76%
copy from Documentation/features/io/sg-chain/arch-support.txt
copy to Documentation/features/time/virt-cpuacct/arch-support.txt
index b9b6755..cf3c3e3 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -1,12 +1,12 @@
 #
-# Feature name:          sg-chain
-#         Kconfig:       ARCH_HAS_SG_CHAIN
-#         description:   arch supports chained scatter-gather lists
+# Feature name:          virt-cpuacct
+#         Kconfig:       HAVE_VIRT_CPU_ACCOUNTING
+#         description:   arch supports precise virtual CPU time accounting
 #
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: | TODO |
+    |       alpha: |  ok  |
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
@@ -22,17 +22,17 @@
     |        m68k: | TODO |
     |       metag: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
     |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
     |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: | TODO |
+    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
