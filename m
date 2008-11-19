From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: + unaligned-introduce-common-header.patch added to -mm tree
Date: Wed, 19 Nov 2008 10:59:23 -0800
Message-ID: <1227121163.13182.18.camel@brick>
References: <200811190614.mAJ6EsXA007330@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:19508 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYKSS72 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 13:59:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so55996yxm.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2008 10:59:27 -0800 (PST)
In-Reply-To: <200811190614.mAJ6EsXA007330@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, benh@kernel.crashing.org, bryan.wu@analog.com, davem@davemloft.net, dhowells@redhat.com, geert@linux-m68k.org, gerg@uclinux.org, grundler@parisc-linux.org, heiko.carstens@de.ibm.com, hskinnemoen@atmel.com, ink@jurassic.park.msu.ru, kyle@mcmartin.ca, lethal@linux-sh.org, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, ralf@linux-mips.org, rmk@arm.linux.org.uk, rth@twiddle.net, schwidefsky@de.ibm.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, ysato@users.sourceforge.jp, zankel@tensilica.com, zippel@linux-m68k.org

[PATCH] unaligned: fix return type for get_unaligned_le64/be64

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
With my apologies, compiler didn't warn about the truncation.

 include/asm-generic/unaligned.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index ac23e04..3bef59f 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -120,7 +120,7 @@ static inline u32 get_unaligned_le32(const void *p)
 #endif
 }
 
-static inline u16 get_unaligned_le64(const void *p)
+static inline u64 get_unaligned_le64(const void *p)
 {
 #ifdef __LITTLE_ENDIAN
 	return ((const struct __una_u64 *)p)->x;
@@ -147,7 +147,7 @@ static inline u32 get_unaligned_be32(const void *p)
 #endif
 }
 
-static inline u16 get_unaligned_be64(const void *p)
+static inline u64 get_unaligned_be64(const void *p)
 {
 #ifdef __BIG_ENDIAN
 	return ((const struct __una_u64 *)p)->x;
-- 
1.6.0.4.1013.gc6a01
