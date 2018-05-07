From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 4/6] Documentation/features/locking: Use '!RWSEM_GENERIC_SPINLOCK' as Kconfig for 'rwsem-optimized'
Date: Mon,  7 May 2018 12:43:41 +0200
Message-ID: <1525689823-3340-5-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Uses '!RWSEM_GENERIC_SPINLOCK' in place of 'Optimized asm/rwsem.h' as
Kconfig for 'rwsem-optimized': the new Kconfig expresses this feature
equivalently, while also enabling the script 'features-refresh.sh' to
operate on the corresponding arch support status file. Also refreshes
the status matrix by using the script 'features-refresh.sh'.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/features/locking/rwsem-optimized/arch-support.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index 8afe24ffa3ab4..e54b1f1a8091d 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -1,6 +1,6 @@
 #
 # Feature name:          rwsem-optimized
-#         Kconfig:       Optimized asm/rwsem.h
+#         Kconfig:       !RWSEM_GENERIC_SPINLOCK
 #         description:   arch provides optimized rwsem APIs
 #
     -----------------------
@@ -8,8 +8,8 @@
     -----------------------
     |       alpha: |  ok  |
     |         arc: | TODO |
-    |         arm: | TODO |
-    |       arm64: | TODO |
+    |         arm: |  ok  |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
@@ -26,7 +26,7 @@
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |          um: | TODO |
+    |          um: |  ok  |
     |   unicore32: | TODO |
     |         x86: |  ok  |
     |      xtensa: |  ok  |
-- 
2.7.4
