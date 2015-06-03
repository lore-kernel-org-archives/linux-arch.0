Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59992 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbFCLM3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:12:29 -0400
Date: Wed, 3 Jun 2015 04:11:55 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-3c1b5142691f094591b6c1d6e7a9fc5599409c28@git.kernel.org>
Reply-To: hpa@zytor.com, linux-arch@vger.kernel.org, corbet@lwn.net,
	  tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
	  josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	  torvalds@linux-foundation.org, akpm@linux-foundation.org,
	  linux-api@vger.kernel.org
Subject: [tip:core/documentation] Documentation/features/io:
  Add feature description and arch support status file for 'dma_map_attrs'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: josh@joshtriplett.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, linux-api@vger.kernel.org, akpm@linux-foundation.org, hpa@zytor.com, corbet@lwn.net, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org
Message-ID: <20150603111155.xYup68FvI4AJseTO9OZCgQDj_oRhNVlpnICRIRMfF7g@z>

Commit-ID:  3c1b5142691f094591b6c1d6e7a9fc5599409c28
Gitweb:     http://git.kernel.org/tip/3c1b5142691f094591b6c1d6e7a9fc5599409c28
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:36 +0200

Documentation/features/io: Add feature description and arch support status file for 'dma_map_attrs'

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
 .../dma_map_attrs}/arch-support.txt                  | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/io/dma_map_attrs/arch-support.txt
similarity index 68%
copy from Documentation/features/time/virt-cpuacct/arch-support.txt
copy to Documentation/features/io/dma_map_attrs/arch-support.txt
index cf3c3e3..51d0f1c 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/io/dma_map_attrs/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          virt-cpuacct
-#         Kconfig:       HAVE_VIRT_CPU_ACCOUNTING
-#         description:   arch supports precise virtual CPU time accounting
+# Feature name:          dma_map_attrs
+#         Kconfig:       HAVE_DMA_ATTRS
+#         description:   arch provides dma_*map*_attrs() APIs
 #
     -----------------------
     |         arch |status|
@@ -15,26 +15,26 @@
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
+    |       h8300: |  ok  |
+    |     hexagon: |  ok  |
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
     |       metag: | TODO |
-    |  microblaze: | TODO |
+    |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: | TODO |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: |  ok  |
+    |    openrisc: |  ok  |
+    |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
     |       score: | TODO |
-    |          sh: | TODO |
+    |          sh: |  ok  |
     |       sparc: |  ok  |
     |        tile: |  ok  |
     |          um: | TODO |
-    |   unicore32: | TODO |
+    |   unicore32: |  ok  |
     |         x86: |  ok  |
     |      xtensa: | TODO |
     -----------------------
