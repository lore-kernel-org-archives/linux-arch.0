From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: memfill
Date: Tue, 07 Feb 2017 11:07:34 -0800
Message-ID: <1486494454.2488.60.camel@HansenPartnership.com>
References: <1486307804-27903-1-git-send-email-minchan@kernel.org>
         <20170206144902.GH2267@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58000 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754502AbdBGTIA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2017 14:08:00 -0500
In-Reply-To: <20170206144902.GH2267@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com

On Mon, 2017-02-06 at 06:49 -0800, Matthew Wilcox wrote:
> [adding linux-arch to see if anyone there wants to do an optimised
> version of memfill for their CPU]
> 
> On Mon, Feb 06, 2017 at 12:16:44AM +0900, Minchan Kim wrote:
> > +static inline void zram_fill_page(char *ptr, unsigned long len,
> > +					unsigned long value)
> > +{
> > +	int i;
> > +	unsigned long *page = (unsigned long *)ptr;
> > +
> > +	WARN_ON_ONCE(!IS_ALIGNED(len, sizeof(unsigned long)));
> > +
> > +	if (likely(value == 0)) {
> > +		memset(ptr, 0, len);
> > +	} else {
> > +		for (i = 0; i < len / sizeof(*page); i++)
> > +			page[i] = value;
> > +	}
> > +}
> 
> I would suggest:
> 
> #ifndef __HAVE_ARCH_MEMFILL
> /** 
>  * memfill - Fill a region of memory with the given value
>  * @s: Pointer to the start of the region.
>  * @v: The word to fill the region with.
>  * @n: The size of the region.
>  * 
>  * Differs from memset() in that it fills with an unsigned long
> instead of 
>  * a byte.  The pointer and the size must be aligned to unsigned
> long.
>  */
> void memfill(unsigned long *s, unsigned long v, size_t n)

If we're going to do this, are you sure we wouldn't be wanting a string
fill instead of a memfill (because filling either by byte or long looks
a bit restrictive) assuming static strings that we can tell the compile
time size of, it would be easy for generic code to optimise.

James
