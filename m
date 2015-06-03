Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60133 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbFCLPX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:15:23 -0400
Date: Wed, 3 Jun 2015 04:14:48 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-28dfffd6d14f9cb2277e9bead011e8d510e2c4fa@git.kernel.org>
Reply-To: josh@joshtriplett.org, linux-api@vger.kernel.org,
	  akpm@linux-foundation.org, torvalds@linux-foundation.org,
	  corbet@lwn.net, hpa@zytor.com, mingo@kernel.org,
	  tglx@linutronix.de, linux-kernel@vger.kernel.org,
	  linux-arch@vger.kernel.org, peterz@infradead.org
Subject: [tip:core/documentation] Documentation/features/time:
  Add feature description and arch support status file for 'clockevents'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org, linux-arch@vger.kernel.org, hpa@zytor.com, mingo@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-api@vger.kernel.org, josh@joshtriplett.org
Message-ID: <20150603111448.4rK3O_bUssTfWBrMKVXpannC33nsfbo6olnyHh0aynY@z>

Commit-ID:  28dfffd6d14f9cb2277e9bead011e8d510e2c4fa
Gitweb:     http://git.kernel.org/tip/28dfffd6d14f9cb2277e9bead011e8d510e2c4fa
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:39 +0200

Documentation/features/time: Add feature description and arch support status file for 'clockevents'

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
 .../arch-support.txt                                 | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
similarity index 68%
copy from Documentation/features/time/modern-timekeeping/arch-support.txt
copy to Documentation/features/time/clockevents/arch-support.txt
index 17f68a0..ff670b2 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -1,32 +1,32 @@
 #
-# Feature name:          modern-timekeeping
-#         Kconfig:       !ARCH_USES_GETTIMEOFFSET
-#         description:   arch does not use arch_gettimeoffset() anymore
+# Feature name:          clockevents
+#         Kconfig:       GENERIC_CLOCKEVENTS
+#         description:   arch support generic clock events
 #
     -----------------------
     |         arch |status|
     -----------------------
     |       alpha: |  ok  |
     |         arc: |  ok  |
-    |         arm: | TODO |
+    |         arm: |  ok  |
     |       arm64: |  ok  |
     |       avr32: |  ok  |
-    |    blackfin: | TODO |
+    |    blackfin: |  ok  |
     |         c6x: |  ok  |
-    |        cris: | TODO |
-    |         frv: |  ok  |
+    |        cris: |  ok  |
+    |         frv: | TODO |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: |  ok  |
+    |        ia64: | TODO |
     |        m32r: | TODO |
-    |        m68k: | TODO |
+    |        m68k: |  ok  |
     |       metag: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: |  ok  |
+    |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
     |       score: |  ok  |
