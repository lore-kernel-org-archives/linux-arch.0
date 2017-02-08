From: Matthew Wilcox <willy@infradead.org>
Subject: Re: memfill
Date: Wed, 8 Feb 2017 10:04:47 -0800
Message-ID: <20170208180447.GO2267@bombadil.infradead.org>
References: <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <20170206144902.GH2267@bombadil.infradead.org>
 <1486494454.2488.60.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58549 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdBHU2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2017 15:28:50 -0500
Content-Disposition: inline
In-Reply-To: <1486494454.2488.60.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com, liw@liw.fi

On Tue, Feb 07, 2017 at 11:07:34AM -0800, James Bottomley wrote:
> > /** 
> >  * memfill - Fill a region of memory with the given value
> >  * @s: Pointer to the start of the region.
> >  * @v: The word to fill the region with.
> >  * @n: The size of the region.
> >  * 
> >  * Differs from memset() in that it fills with an unsigned long
> > instead of 
> >  * a byte.  The pointer and the size must be aligned to unsigned
> > long.
> >  */
> > void memfill(unsigned long *s, unsigned long v, size_t n)
> 
> If we're going to do this, are you sure we wouldn't be wanting a string
> fill instead of a memfill (because filling either by byte or long looks
> a bit restrictive) assuming static strings that we can tell the compile
> time size of, it would be easy for generic code to optimise.

When you say 'string fill', do you mean this?

void memfill(void *dst, size_t dsz, void *src, size_t ssz)
{
	if (ssz == 1) {
		memset(dst, *(unsigned char *)src, dsz);
	} else if (ssz == sizeof(short)) {
		memset_s(dst, *(unsigned short *)src, dsz);
	} else if (ssz == sizeof(int)) {
		memset_i(dst, *(unsigned int *)src, dsz);
	} else if (ssz == sizeof(long)) {
		memset_l(dst, *(unsigned long *)src, dsz);
	} else {
		while (dsz >= ssz) {
			memcpy(dst, src, ssz);
			dsz -= ssz;
			dst += ssz;
		}
		if (dsz)
			memcpy(dst. src. dsz);
	}
}

(with memset_[sil] being obvious, I hope).  Possibly some variation on
this to optimise compile-time constant dsz.

I have no objection to that.  Indeed, it would match Lars Wirzenius'
memfill() definition (if not implementation) which makes me quite happy.
