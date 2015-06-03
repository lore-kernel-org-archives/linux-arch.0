Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59920 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbbFCLKt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:10:49 -0400
Date: Wed, 3 Jun 2015 04:10:18 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-1aebadbca627c8840adcf78e68a9ab81c6490307@git.kernel.org>
Reply-To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	  linux-arch@vger.kernel.org, corbet@lwn.net,
	  linux-api@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
	  torvalds@linux-foundation.org, hpa@zytor.com,
	  peterz@infradead.org, josh@joshtriplett.org
Subject: [tip:core/documentation] Documentation/features/time:
  Add feature description and arch support status file for 'irq-time-acct'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, linux-arch@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org, linux-api@vger.kernel.org, josh@joshtriplett.org
Message-ID: <20150603111018.GfDn4CilrsGoZqFsJZA1jdB1K8K-biSye2VhMEPbEiA@z>

Commit-ID:  1aebadbca627c8840adcf78e68a9ab81c6490307
Gitweb:     http://git.kernel.org/tip/1aebadbca627c8840adcf78e68a9ab81c6490307
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:07 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:35 +0200

Documentation/features/time: Add feature description and arch support status file for 'irq-time-acct'

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
 .../arch-support.txt                               | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
similarity index 63%
copy from Documentation/features/time/virt-cpuacct/arch-support.txt
copy to Documentation/features/time/irq-time-acct/arch-support.txt
index cf3c3e3..e633162 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -1,15 +1,15 @@
 #
-# Feature name:          virt-cpuacct
-#         Kconfig:       HAVE_VIRT_CPU_ACCOUNTING
-#         description:   arch supports precise virtual CPU time accounting
+# Feature name:          irq-time-acct
+#         Kconfig:       HAVE_IRQ_TIME_ACCOUNTING
+#         description:   arch supports precise IRQ time accounting
 #
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: |  ok  |
+    |       alpha: |  ..  |
     |         arc: | TODO |
     |         arm: |  ok  |
-    |       arm64: |  ok  |
+    |       arm64: |  ..  |
     |       avr32: | TODO |
     |    blackfin: | TODO |
     |         c6x: | TODO |
@@ -17,7 +17,7 @@
     |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
+    |        ia64: |  ..  |
     |        m32r: | TODO |
     |        m68k: | TODO |
     |       metag: | TODO |
@@ -26,15 +26,15 @@
     |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: |  ok  |
-    |     powerpc: |  ok  |
-    |        s390: |  ok  |
+    |      parisc: |  ..  |
+    |     powerpc: |  ..  |
+    |        s390: |  ..  |
     |       score: | TODO |
     |          sh: | TODO |
-    |       sparc: |  ok  |
-    |        tile: |  ok  |
+    |       sparc: |  ..  |
+    |        tile: |  ..  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
