Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2018 13:00:47 -0400
Date: Tue, 21 Aug 2018 16:40:30 +0300
From: Alexander Pateenok <pateenoc@gmail.com>
Subject: [PATCH] percpu: cleanup PER_CPU_DEF_ATTRIBUTES macro
Message-ID: <20180821134030.lycgq7l7czetdngs@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Dennis Zhou <dennisszhou@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180821134030.fYi4NTcNrsuCAcVBRg1496x2x85vxn3DcLtRS5DjBCI@z>

The macro is not used:

  $ grep -r PER_CPU_DEF_ATTRIBUTES
  include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak		\
  include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES		\
  include/asm-generic/percpu.h:#ifndef PER_CPU_DEF_ATTRIBUTES
  include/asm-generic/percpu.h:#define PER_CPU_DEF_ATTRIBUTES

It was added with b01e8dc34379 ("alpha: fix percpu build breakage") and
removed in 2009 with b01e8dc34379..6088464cf1ae.

Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>
---
 include/asm-generic/percpu.h | 4 ----
 include/linux/percpu-defs.h  | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 1817a8415a5e..c2de013b2cf4 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -62,10 +62,6 @@ extern void setup_per_cpu_areas(void);
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
index 2d2096ba1cfe..1ce8e264a269 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -91,8 +91,7 @@
 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
 	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
-	__typeof__(type) name
+	__PCPU_ATTRS(sec) __weak __typeof__(type) name
 #else
 /*
  * Normal declaration and definition macros.
@@ -101,8 +100,7 @@
 	extern __PCPU_ATTRS(sec) __typeof__(type) name
 
 #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES			\
-	__typeof__(type) name
+	__PCPU_ATTRS(sec) __typeof__(type) name
 #endif
 
 /*
-- 
2.17.1
