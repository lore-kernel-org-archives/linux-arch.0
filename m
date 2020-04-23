From: Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v2] io: correct documentation mismatches for io memcpy
Date: Wed, 22 Apr 2020 17:09:45 -0700
Message-ID: <20200423000945.118231-1-wenhu.wang@vivo.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:10449 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWAKM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 20:10:12 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rdunlap@infradead.org, kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>

Minor mismatches exist between funtion documentations and parameter
definitions. Also a dash '-' is needed between a function name and
its description.

Function definitions are as following:
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)
static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * Dashes added between the function names and their descriptions.

 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..b6a9131ec4d4 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
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
