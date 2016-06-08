From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] bitmap: bitmap_equal memcmp optimization
Date: Wed, 8 Jun 2016 13:42:12 -0700
Message-ID: <20160608134212.9f868a8dd494b88e402d5d31@linux-foundation.org>
References: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
	<201606070837.u578YJKt047781@mx0a-001b2d01.pphosted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35975 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbcFHUmO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2016 16:42:14 -0400
In-Reply-To: <201606070837.u578YJKt047781@mx0a-001b2d01.pphosted.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>

On Tue,  7 Jun 2016 10:37:41 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> The bitmap_equal function has optimized code for small bitmaps with less
> than BITS_PER_LONG bits. For larger bitmaps the out-of-line function
> __bitmap_equal is called.
> 
> For a constant number of bits divisible by BITS_PER_LONG the memcmp
> function can be used. For s390 gcc knows how to optimize this function,
> memcmp calls with up to 256 bytes / 2048 bits are translated into a
> single instruction.

Patch looks simple enough, although it would benefit from a comment
explaining what's special about s390.

> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -267,6 +267,10 @@ static inline int bitmap_equal(const unsigned long *src1,
>  {
>  	if (small_const_nbits(nbits))
>  		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
> +#ifdef CONFIG_S390
> +	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
> +		return !memcmp(src1, src2, nbits / 8);
> +#endif
>  	else
>  		return __bitmap_equal(src1, src2, nbits);
>  }

Those elses are a bit daffy.  This:

--- a/include/linux/bitmap.h~bitmap-bitmap_equal-memcmp-optimization-fix
+++ a/include/linux/bitmap.h
@@ -266,13 +266,12 @@ static inline int bitmap_equal(const uns
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
 #ifdef CONFIG_S390
-	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
+	if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
 		return !memcmp(src1, src2, nbits / 8);
 #endif
-	else
-		return __bitmap_equal(src1, src2, nbits);
+	return __bitmap_equal(src1, src2, nbits);
 }
 
 static inline int bitmap_intersects(const unsigned long *src1,
_
