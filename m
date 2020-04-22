From: Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] io: correct documentation mismatches for io memcpy
Date: Wed, 22 Apr 2020 02:29:05 -0700
Message-ID: <20200422092905.39529-1-wenhu.wang@vivo.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:59276 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVJi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 05:38:56 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>

Minor mismatches exist between funtion documentations and parameter
definitions.

Function definition lines are as following:
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)

static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 include/asm-generic/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..63131ec4857f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1067,9 +1067,9 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #define memcpy_fromio memcpy_fromio
 /**
  * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * @buffer:		The (RAM) destination for the copy
+ * @addr:		The (I/O memory) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -1085,9 +1085,9 @@ static inline void memcpy_fromio(void *buffer,
 #define memcpy_toio memcpy_toio
 /**
  * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * @addr:		The (I/O memory) destination for the copy
+ * @buffer:		The (RAM) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.17.1
