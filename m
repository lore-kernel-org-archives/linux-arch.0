Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60247 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbbFCLRh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:17:37 -0400
Date: Wed, 3 Jun 2015 04:17:06 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-a382c9694c2a8fb0d9525fa3289c1c7eeee73ae8@git.kernel.org>
Reply-To: peterz@infradead.org, corbet@lwn.net, josh@joshtriplett.org,
	  hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
	  torvalds@linux-foundation.org, linux-api@vger.kernel.org,
	  linux-arch@vger.kernel.org, akpm@linux-foundation.org,
	  linux-kernel@vger.kernel.org
Subject: [tip:core/documentation] Documentation/features/debug:
  Add feature description and arch support status file for 'kretprobes'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, josh@joshtriplett.org, corbet@lwn.net, peterz@infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150603111706.2G4uLk96QK3_RZEXgSvD0_U5s911Y6R-6xt-c-Z2GEE@z>

Commit-ID:  a382c9694c2a8fb0d9525fa3289c1c7eeee73ae8
Gitweb:     http://git.kernel.org/tip/a382c9694c2a8fb0d9525fa3289c1c7eeee73ae8
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:32 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:40 +0200

Documentation/features/debug: Add feature description and arch support status file for 'kretprobes'

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
 .../features/debug/{kprobes => kretprobes}/arch-support.txt       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
similarity index 84%
copy from Documentation/features/debug/kprobes/arch-support.txt
copy to Documentation/features/debug/kretprobes/arch-support.txt
index a44bfff..d87c1ce 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          kprobes
-#         Kconfig:       HAVE_KPROBES
-#         description:   arch supports live patched kernel probe
+# Feature name:          kretprobes
+#         Kconfig:       HAVE_KRETPROBES
+#         description:   arch supports kernel function-return probes
 #
     -----------------------
     |         arch |status|
@@ -10,7 +10,7 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |       avr32: |  ok  |
+    |       avr32: | TODO |
     |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
