Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60348 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbbFCLTz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2015 07:19:55 -0400
Date: Wed, 3 Jun 2015 04:19:21 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-98008be7e87ffc825551bdafad706de10a61f5bc@git.kernel.org>
Reply-To: peterz@infradead.org, akpm@linux-foundation.org, hpa@zytor.com,
	  linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
	  mingo@kernel.org, linux-api@vger.kernel.org, corbet@lwn.net,
	  josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	  tglx@linutronix.de
Subject: [tip:core/documentation] Documentation/features/locking:
  Add feature description and arch support status file for 'cmpxchg-local'
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: corbet@lwn.net, linux-api@vger.kernel.org, josh@joshtriplett.org, mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20150603111921.z_Ky--V1gBARgYZ4b-gE8sGeOVcHeN4cz3av26SIVm4@z>

Commit-ID:  98008be7e87ffc825551bdafad706de10a61f5bc
Gitweb:     http://git.kernel.org/tip/98008be7e87ffc825551bdafad706de10a61f5bc
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 3 Jun 2015 12:37:39 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Jun 2015 12:51:42 +0200

Documentation/features/locking: Add feature description and arch support status file for 'cmpxchg-local'

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
 .../{debug/KASAN => locking/cmpxchg-local}/arch-support.txt       | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
similarity index 84%
copy from Documentation/features/debug/KASAN/arch-support.txt
copy to Documentation/features/locking/cmpxchg-local/arch-support.txt
index 14531da..d9c3108 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          KASAN
-#         Kconfig:       HAVE_ARCH_KASAN
-#         description:   arch supports the KASAN runtime memory checker
+# Feature name:          cmpxchg-local
+#         Kconfig:       HAVE_CMPXCHG_LOCAL
+#         description:   arch supports the this_cpu_cmpxchg() API
 #
     -----------------------
     |         arch |status|
@@ -28,7 +28,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
-    |        s390: | TODO |
+    |        s390: |  ok  |
     |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
