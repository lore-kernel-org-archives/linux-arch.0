Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLOgE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 10:36:04 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Date: Fri, 12 Apr 2019 16:35:38 +0200
Message-ID: <20190412143538.11780-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, mick@ics.forth.gr, linux-kernel@vger.kernel.org
Message-ID: <20190412143538.UApZCOrKjMdnxxnsuo03v3RYsU4zI8ftoO8WyEeed7Q@z>

When removing some dead big endian checks in the RISC-V code Nick
suggested that we should have some generic sanity checks.  I don't think
we should have thos inside the RISC-V code, but maybe it might make
sense to have these in the generic byteorder headers.  Note that these
are UAPI headers and some compilers might not actually define
__BYTE_ORDER__, so we first check that it actually exists.

Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/byteorder/big_endian.h    | 4 ++++
 include/uapi/linux/byteorder/little_endian.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
index 2199adc6a6c2..34a5864526d2 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
 #define _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
 
+#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__
+#error "Unsupported endianess, check your toolchain"
+#endif
+
 #ifndef __BIG_ENDIAN
 #define __BIG_ENDIAN 4321
 #endif
diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
index 601c904fd5cd..0cdf3583e19f 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
 #define _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
 
+#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=  __ORDER_LITTLE_ENDIAN__
+#error "Unsupported endianess, check your toolchain"
+#endif
+
 #ifndef __LITTLE_ENDIAN
 #define __LITTLE_ENDIAN 1234
 #endif
-- 
2.20.1
