Return-Path: <SRS0=iE4N=6I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:10025 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXCJB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Apr 2020 22:09:01 -0400
From: Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v3] io: correct doc-mismatches for io mem ops
Date: Thu, 23 Apr 2020 19:08:31 -0700
Message-ID: <20200424020831.30494-1-wenhu.wang@vivo.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rdunlap@infradead.org, kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Message-ID: <20200424020831.l3xf5xmPqKeDvga2dJr3E3pBUjZQqWmE6a5JXIgSi-A@z>

Minor mismatches exist between funtion documentations and parameter
definitions. Also a dash '-' is needed between a function name and
its description.

Function definitions are as following:
static inline void memset_io(volatile void __iomem *addr, int value,
			     size_t size)
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)
static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 include/asm-generic/io.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..83ac47bfa33a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1049,10 +1049,10 @@ static inline void *bus_to_virt(unsigned long address)
 #ifndef memset_io
 #define memset_io memset_io
 /**
- * memset_io	Set a range of I/O memory to a constant value
+ * memset_io -	Set a range of I/O memory to a constant value
  * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
+ * @value:	The value to set the memory to
+ * @size:	The number of bytes to set
  *
  * Set a range of I/O memory to a given value.
  */
@@ -1066,10 +1066,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #ifndef memcpy_fromio
 #define memcpy_fromio memcpy_fromio
 /**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_fromio -	Copy a block of data from I/O memory
+ * @buffer:		The (RAM) destination for the copy
+ * @addr:		The (I/O memory) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -1084,10 +1084,10 @@ static inline void memcpy_fromio(void *buffer,
 #ifndef memcpy_toio
 #define memcpy_toio memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_toio -	Copy a block of data into I/O memory
+ * @addr:		The (I/O memory) destination for the copy
+ * @buffer:		The (RAM) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.17.1
