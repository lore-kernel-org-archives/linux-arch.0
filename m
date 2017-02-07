From: Minchan Kim <minchan@kernel.org>
Subject: Re: memfill
Date: Tue, 7 Feb 2017 13:59:48 +0900
Message-ID: <20170207045948.GB2215@bbox>
References: <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <20170206144902.GH2267@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:52875 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdBGFAF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2017 00:00:05 -0500
In-Reply-To: <20170206144902.GH2267@bombadil.infradead.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com

Hi Matthew,

On Mon, Feb 06, 2017 at 06:49:02AM -0800, Matthew Wilcox wrote:
> 
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
>  * Differs from memset() in that it fills with an unsigned long instead of 
>  * a byte.  The pointer and the size must be aligned to unsigned long.
>  */
> void memfill(unsigned long *s, unsigned long v, size_t n)
> {
> 	WARN_ON_ONCE(!IS_ALIGNED(n, sizeof(v)));
> 
> 	if (likely(v == 0)) {
> 		memset(s, 0, n);
> 	} else {
> 		while (n) {
> 			*s++ = v;
> 			n -= sizeof(v);
> 		}
> 	}
> }
> EXPORT_SYMBOL(memfill);
> #endif
> 
> (I would also suggest this move to lib/string.c and architectures be
> given the opportunity to provide an optimised version of memfill).

Thanks for suggestion, Matthew!

However, I want to mention zram's performance wouldn't be sensitive
for that function because non-zero memfill would be rare.
