Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60270 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbbFCLSQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:18:16 -0400
Date: Wed, 3 Jun 2015 04:17:45 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-8fa369c0485c843f93045974e2a93cdc09828db1@git.kernel.org>
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
	  corbet@lwn.net, hpa@zytor.com, josh@joshtriplett.org,
	  tglx@linutronix.de, linux-api@vger.kernel.org,
	  linux-arch@vger.kernel.org, mingo@kernel.org,
	  akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [tip:core/documentation] Documentation/features/core:
  Add feature description and arch support status file for '
 generic-idle-thread'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: tglx@linutronix.de, linux-api@vger.kernel.org, hpa@zytor.com, josh@joshtriplett.org, torvalds@linux-foundation.org, peterz@infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150603111745.SYSS8FDp5VHlVdHuBLz3C__8IY4KrEttcgDc7K3vV28@z>

Commit-ID:  8fa369c0485c843f93045974e2a93cdc09828db1
Gitweb:     http://git.kernel.org/tip/8fa369c0485c843f93045974e2a93cdc09828db1
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:34 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:41 +0200

Documentation/features/core: Add feature description and arch support status file for 'generic-idle-thread'

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
 .../generic-idle-thread}/arch-support.txt            | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
similarity index 68%
copy from Documentation/features/time/virt-cpuacct/arch-support.txt
copy to Documentation/features/core/generic-idle-thread/arch-support.txt
index cf3c3e3..6d930fc 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -1,26 +1,26 @@
 #
-# Feature name:          virt-cpuacct
-#         Kconfig:       HAVE_VIRT_CPU_ACCOUNTING
-#         description:   arch supports precise virtual CPU time accounting
+# Feature name:          generic-idle-thread
+#         Kconfig:       GENERIC_SMP_IDLE_THREAD
+#         description:   arch makes use of the generic SMP idle thread facility
 #
     -----------------------
     |         arch |status|
     -----------------------
     |       alpha: |  ok  |
-    |         arc: | TODO |
+    |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |       avr32: | TODO |
-    |    blackfin: | TODO |
+    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
     |       h8300: | TODO |
-    |     hexagon: | TODO |
+    |     hexagon: |  ok  |
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
+    |       metag: |  ok  |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
@@ -30,11 +30,11 @@
     |     powerpc: |  ok  |
     |        s390: |  ok  |
     |       score: | TODO |
-    |          sh: | TODO |
+    |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
+    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
