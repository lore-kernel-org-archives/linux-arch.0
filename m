Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.179]:37005 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbYDITqD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Apr 2008 15:46:03 -0400
Received: by el-out-1112.google.com with SMTP id v27so1951820ele.17
        for <linux-arch@vger.kernel.org>; Wed, 09 Apr 2008 12:46:02 -0700 (PDT)
Subject: [PATCH] unaligned access, fix some includes
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <1207765322.16220.8.camel@brick>
References: <1207765322.16220.8.camel@brick>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 12:46:20 -0700
Message-ID: <1207770380.16220.19.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20080409194620.HbYBPILaWY2xpSAwyZcQRz_trP6lL_SoleNvreQc4bk@z>

Missed a few includes when moving some files around, this makes it
actually compile.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Applies on top of the unaligned access revamp, missed when moving files
around.

 include/linux/unaligned/generic_be.h        |    2 +-
 include/linux/unaligned/generic_le.h        |    2 +-
 include/linux/unaligned/no_builtin_memcpy.h |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/unaligned/generic_be.h b/include/linux/unaligned/generic_be.h
index ce42487..dd7e323 100644
--- a/include/linux/unaligned/generic_be.h
+++ b/include/linux/unaligned/generic_be.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_UNALIGNED_GENERIC_BE_H_
 #define _LINUX_UNALIGNED_GENERIC_BE_H_
 
-#include <linux/unaligned/generic.h>
+#include <linux/unaligned/cpu_endian.h>
 #include <linux/unaligned/little_endian.h>
 
 #define get_unaligned	__get_unaligned_cpu
diff --git a/include/linux/unaligned/generic_le.h b/include/linux/unaligned/generic_le.h
index b57c818..7b7de52 100644
--- a/include/linux/unaligned/generic_le.h
+++ b/include/linux/unaligned/generic_le.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_UNALIGNED_GENERIC_LE_H_
 #define _LINUX_UNALIGNED_GENERIC_LE_H_
 
-#include <linux/unaligned/generic.h>
+#include <linux/unaligned/cpu_endian.h>
 #include <linux/unaligned/big_endian.h>
 
 #define get_unaligned	__get_unaligned_cpu
diff --git a/include/linux/unaligned/no_builtin_memcpy.h b/include/linux/unaligned/no_builtin_memcpy.h
index 17a6e21..c117e78 100644
--- a/include/linux/unaligned/no_builtin_memcpy.h
+++ b/include/linux/unaligned/no_builtin_memcpy.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
 #define _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
 
+#include <linux/kernel.h>
 #include <asm/byteorder.h>
 #include <asm/string.h>
 
-- 
1.5.5.144.g3e42



