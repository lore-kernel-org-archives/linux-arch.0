From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] bitmap: bitmap_equal memcmp optimization
Date: Tue,  7 Jun 2016 10:37:41 +0200
Message-ID: <201606070837.u578YDwS003982@mx0a-001b2d01.pphosted.com>
References: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5045 "EHLO
	mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754300AbcFGIhy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2016 04:37:54 -0400
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u578YDwS003982
	for <linux-arch@vger.kernel.org>; Tue, 7 Jun 2016 04:37:53 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23dp7cmkm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 07 Jun 2016 04:37:53 -0400
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Tue, 7 Jun 2016 09:37:51 +0100
In-Reply-To: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

The bitmap_equal function has optimized code for small bitmaps with less
than BITS_PER_LONG bits. For larger bitmaps the out-of-line function
__bitmap_equal is called.

For a constant number of bits divisible by BITS_PER_LONG the memcmp
function can be used. For s390 gcc knows how to optimize this function,
memcmp calls with up to 256 bytes / 2048 bits are translated into a
single instruction.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/bitmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index e9b0b9a..27bfc0b 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -267,6 +267,10 @@ static inline int bitmap_equal(const unsigned long *src1,
 {
 	if (small_const_nbits(nbits))
 		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+#ifdef CONFIG_S390
+	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
+		return !memcmp(src1, src2, nbits / 8);
+#endif
 	else
 		return __bitmap_equal(src1, src2, nbits);
 }
-- 
2.6.6
