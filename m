From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH] trivial: typofix in vmlinux.lds.h
Date: Wed, 31 Jan 2018 16:11:49 +0800
Message-ID: <20180131081149.9183-1-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, trivial@kernel.org
List-Id: linux-arch.vger.kernel.org

aling --> aligned

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ee8b707d9fa9..470c41d2e272 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -468,7 +468,7 @@
 	MEM_KEEP(exit.text)						\
 
 
-/* sched.text is aling to function alignment to secure we have same
+/* sched.text is aligned to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
@@ -476,7 +476,7 @@
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
 
-/* spinlock.text is aling to function alignment to secure we have same
+/* spinlock.text is aligned to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
-- 
2.14.3
