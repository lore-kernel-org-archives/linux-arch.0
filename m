Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60229 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbFCLRW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:17:22 -0400
Date: Wed, 3 Jun 2015 04:16:48 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-138943ea3aa2b69960250c218637468bb157f49c@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	  corbet@lwn.net, hpa@zytor.com, linux-arch@vger.kernel.org,
	  mingo@kernel.org, torvalds@linux-foundation.org,
	  tglx@linutronix.de, peterz@infradead.org,
	  akpm@linux-foundation.org, josh@joshtriplett.org
Subject: [tip:core/documentation] Documentation/features/debug:
  Add feature description and arch support status file for 'uprobes'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: akpm@linux-foundation.org, josh@joshtriplett.org, corbet@lwn.net, linux-api@vger.kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org
Message-ID: <20150603111648.sJDyJrQvWgdp_CHxvxi6M_SK78tvWt_z-v99mZDzLTU@z>

Commit-ID:  138943ea3aa2b69960250c218637468bb157f49c
Gitweb:     http://git.kernel.org/tip/138943ea3aa2b69960250c218637468bb157f49c
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:31 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:40 +0200

Documentation/features/debug: Add feature description and arch support status file for 'uprobes'

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
 .../features/{vm/ELF-ASLR => debug/uprobes}/arch-support.txt   | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
similarity index 80%
copy from Documentation/features/vm/ELF-ASLR/arch-support.txt
copy to Documentation/features/debug/uprobes/arch-support.txt
index ec4dd28..4efe36c 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          ELF-ASLR
-#         Kconfig:       ARCH_HAS_ELF_RANDOMIZE
-#         description:   arch randomizes the stack, heap and binary images of ELF binaries
+# Feature name:          uprobes
+#         Kconfig:       ARCH_SUPPORTS_UPROBES
+#         description:   arch supports live patched user probes
 #
     -----------------------
     |         arch |status|
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: |  ok  |
-    |       arm64: |  ok  |
+    |       arm64: | TODO |
     |       avr32: | TODO |
     |    blackfin: | TODO |
     |         c6x: | TODO |
@@ -22,7 +22,7 @@
     |        m68k: | TODO |
     |       metag: | TODO |
     |  microblaze: | TODO |
-    |        mips: |  ok  |
+    |        mips: | TODO |
     |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
