Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59900 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbbFCLKQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:10:16 -0400
Date: Wed, 3 Jun 2015 04:09:40 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-44121b9ed0384088a6899cfb2ca4ede1428d412f@git.kernel.org>
Reply-To: peterz@infradead.org, mingo@kernel.org,
	  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	  corbet@lwn.net, linux-api@vger.kernel.org,
	  torvalds@linux-foundation.org, josh@joshtriplett.org,
	  tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org
Subject: [tip:core/documentation] Documentation/features/time:
  Add feature description and arch support status file for '
 modern-timekeeping'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: josh@joshtriplett.org, tglx@linutronix.de, akpm@linux-foundation.org, hpa@zytor.com, mingo@kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20150603110940.B8fziXdr0enAr1zQcSotXZIuTwU_S1xotRD7jf7IvPA@z>

Commit-ID:  44121b9ed0384088a6899cfb2ca4ede1428d412f
Gitweb:     http://git.kernel.org/tip/44121b9ed0384088a6899cfb2ca4ede1428d412f
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:04 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:34 +0200

Documentation/features/time: Add feature description and arch support status file for 'modern-timekeeping'

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
 .../time/modern-timekeeping/arch-support.txt       | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
new file mode 100644
index 0000000..17f68a0
--- /dev/null
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -0,0 +1,40 @@
+#
+# Feature name:          modern-timekeeping
+#         Kconfig:       !ARCH_USES_GETTIMEOFFSET
+#         description:   arch does not use arch_gettimeoffset() anymore
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: |  ok  |
+    |         arc: |  ok  |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |       avr32: |  ok  |
+    |    blackfin: | TODO |
+    |         c6x: |  ok  |
+    |        cris: | TODO |
+    |         frv: |  ok  |
+    |       h8300: |  ok  |
+    |     hexagon: |  ok  |
+    |        ia64: |  ok  |
+    |        m32r: | TODO |
+    |        m68k: | TODO |
+    |       metag: |  ok  |
+    |  microblaze: |  ok  |
+    |        mips: |  ok  |
+    |     mn10300: |  ok  |
+    |       nios2: |  ok  |
+    |    openrisc: |  ok  |
+    |      parisc: |  ok  |
+    |     powerpc: |  ok  |
+    |        s390: |  ok  |
+    |       score: |  ok  |
+    |          sh: |  ok  |
+    |       sparc: |  ok  |
+    |        tile: |  ok  |
+    |          um: |  ok  |
+    |   unicore32: |  ok  |
+    |         x86: |  ok  |
+    |      xtensa: |  ok  |
+    -----------------------
