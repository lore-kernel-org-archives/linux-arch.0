Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfDWQiq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:38:46 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] asm-generic: optimize generic uaccess for 8-byte loads and stores
Date: Tue, 23 Apr 2019 18:38:09 +0200
Message-Id: <20190423163809.9962-5-hch@lst.de>
In-Reply-To: <20190423163809.9962-1-hch@lst.de>
References: <20190423163809.9962-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 64-bit architectures we can also use the direct load/store trick for
8-byte values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 3dcabfceb21e..e935318804f8 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -24,6 +24,11 @@ raw_copy_from_user(void *to, const void __user * from, unsigned long n)
 		case 4:
 			*(u32 *)to = *(u32 __force *)from;
 			return 0;
+#ifdef CONFIG_64BIT
+		case 8:
+			*(u64 *)to = *(u64 __force *)from;
+			return 0;
+#endif
 		}
 	}
 
@@ -45,6 +50,11 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 		case 4:
 			*(u32 __force *)to = *(u32 *)from;
 			return 0;
+#ifdef CONFIG_64BIT
+		case 8:
+			*(u64 __force *)to = *(u64 *)from;
+			return 0;
+#endif
 		default:
 			break;
 		}
-- 
2.20.1
