From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH] percpu: drop useless macro PER_CPU_DEF_ATTRIBUTES
Date: Tue, 28 Mar 2017 16:35:07 +0800
Message-ID: <1490690107-30009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:48383 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754722AbdC1I0X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 04:26:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tj@kernel.org, cl@linux.com

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 include/asm-generic/percpu.h | 4 ----
 include/linux/percpu-defs.h  | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 0504ef8..be90c3d 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -61,10 +61,6 @@ extern void setup_per_cpu_areas(void);
 #define PER_CPU_ATTRIBUTES
 #endif
 
-#ifndef PER_CPU_DEF_ATTRIBUTES
-#define PER_CPU_DEF_ATTRIBUTES
-#endif
-
 #define raw_cpu_generic_read(pcp)					\
 ({									\
 	*raw_cpu_ptr(&(pcp));						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8f16299..c05cc4d 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -91,7 +91,7 @@
 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
 	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
+	__PCPU_ATTRS(sec) __weak					\
 	__typeof__(type) name
 #else
 /*
@@ -101,7 +101,7 @@
 	extern __PCPU_ATTRS(sec) __typeof__(type) name
 
 #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES			\
+	__PCPU_ATTRS(sec)						\
 	__typeof__(type) name
 #endif
 
-- 
2.1.0
