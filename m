Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59767 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbFCLHo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:07:44 -0400
Date: Wed, 3 Jun 2015 04:07:03 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-403e27dc1f90ce9ac4833c6d56cb08023b74e804@git.kernel.org>
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-api@vger.kernel.org,
	  linux-arch@vger.kernel.org, hpa@zytor.com, josh@joshtriplett.org,
	  akpm@linux-foundation.org, corbet@lwn.net, peterz@infradead.org,
	  linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [tip:core/documentation] Documentation/features/vm:
  Add feature description and arch support status file for 'numa-memblock'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, corbet@lwn.net, peterz@infradead.org, hpa@zytor.com, josh@joshtriplett.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, linux-api@vger.kernel.org
Message-ID: <20150603110703.c7UbHD_K-jeAV5lSC2coc_Vf_A5GHIfx9NRKp4A-7N0@z>

Commit-ID:  403e27dc1f90ce9ac4833c6d56cb08023b74e804
Gitweb:     http://git.kernel.org/tip/403e27dc1f90ce9ac4833c6d56cb08023b74e804
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:36:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:32 +0200

Documentation/features/vm: Add feature description and arch support status file for 'numa-memblock'

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
 .../features/vm/numa-memblock/arch-support.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
new file mode 100644
index 0000000..e7c252a
--- /dev/null
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -0,0 +1,40 @@
+#
+# Feature name:          numa-memblock
+#         Kconfig:       HAVE_MEMBLOCK_NODE_MAP
+#         description:   arch supports NUMA aware memblocks
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: |  ..  |
+    |         arm: |  ..  |
+    |       arm64: |  ..  |
+    |       avr32: |  ..  |
+    |    blackfin: |  ..  |
+    |         c6x: |  ..  |
+    |        cris: |  ..  |
+    |         frv: |  ..  |
+    |       h8300: |  ..  |
+    |     hexagon: |  ..  |
+    |        ia64: |  ok  |
+    |        m32r: | TODO |
+    |        m68k: |  ..  |
+    |       metag: |  ok  |
+    |  microblaze: |  ok  |
+    |        mips: |  ok  |
+    |     mn10300: | TODO |
+    |       nios2: |  ..  |
+    |    openrisc: |  ..  |
+    |      parisc: |  ..  |
+    |     powerpc: |  ok  |
+    |        s390: |  ok  |
+    |       score: |  ok  |
+    |          sh: |  ok  |
+    |       sparc: |  ok  |
+    |        tile: | TODO |
+    |          um: |  ..  |
+    |   unicore32: |  ..  |
+    |         x86: |  ok  |
+    |      xtensa: |  ..  |
+    -----------------------
