Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58824 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161696AbcFIGbp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 02:31:45 -0400
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u596TkDG021828
	for <linux-arch@vger.kernel.org>; Thu, 9 Jun 2016 02:31:44 -0400
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mx9nec-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 02:31:44 -0400
Received: from localhost
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 9 Jun 2016 07:31:43 +0100
Date: Thu, 9 Jun 2016 08:31:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] bitmap: bitmap_equal memcmp optimization
In-Reply-To: <20160608134212.9f868a8dd494b88e402d5d31@linux-foundation.org>
References: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
	<201606070837.u578YJKt047781@mx0a-001b2d01.pphosted.com>
	<20160608134212.9f868a8dd494b88e402d5d31@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20160609083139.665d996b@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20160609063139.Brw-2bjtErDxw6CnU7ABqspfz11jEjUS-kugiy7mLR0@z>

On Wed, 8 Jun 2016 13:42:12 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue,  7 Jun 2016 10:37:41 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > The bitmap_equal function has optimized code for small bitmaps with less
> > than BITS_PER_LONG bits. For larger bitmaps the out-of-line function
> > __bitmap_equal is called.
> > 
> > For a constant number of bits divisible by BITS_PER_LONG the memcmp
> > function can be used. For s390 gcc knows how to optimize this function,
> > memcmp calls with up to 256 bytes / 2048 bits are translated into a
> > single instruction.
> 
> Patch looks simple enough, although it would benefit from a comment
> explaining what's special about s390.

The explanation from the git commit could be transfered into a comment.

> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -267,6 +267,10 @@ static inline int bitmap_equal(const unsigned long *src1,
> >  {
> >  	if (small_const_nbits(nbits))
> >  		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
> > +#ifdef CONFIG_S390
> > +	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
> > +		return !memcmp(src1, src2, nbits / 8);
> > +#endif
> >  	else
> >  		return __bitmap_equal(src1, src2, nbits);
> >  }
> 
> Those elses are a bit daffy.  This:
> 
> --- a/include/linux/bitmap.h~bitmap-bitmap_equal-memcmp-optimization-fix
> +++ a/include/linux/bitmap.h
> @@ -266,13 +266,12 @@ static inline int bitmap_equal(const uns
>  			const unsigned long *src2, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
> -		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
> +		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>  #ifdef CONFIG_S390
> -	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
> +	if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
>  		return !memcmp(src1, src2, nbits / 8);
>  #endif
> -	else
> -		return __bitmap_equal(src1, src2, nbits);
> +	return __bitmap_equal(src1, src2, nbits);
>  }
> 
>  static inline int bitmap_intersects(const unsigned long *src1,
> _
> 

Yeah that looks better. Thanks for picking this up!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

