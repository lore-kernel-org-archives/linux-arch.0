From: zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: memfill
Date: Tue, 7 Feb 2017 10:47:51 +0800
Message-ID: <069b76a3-fe60-5cb1-46dd-fac977d7daf9@huawei.com>
References: <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <20170206144902.GH2267@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:52000 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBGCsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2017 21:48:39 -0500
In-Reply-To: <20170206144902.GH2267@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com



On 2017/2/6 22:49, Matthew Wilcox wrote:
>
> [adding linux-arch to see if anyone there wants to do an optimised
> version of memfill for their CPU]
>
> On Mon, Feb 06, 2017 at 12:16:44AM +0900, Minchan Kim wrote:
>> +static inline void zram_fill_page(char *ptr, unsigned long len,
>> +					unsigned long value)
>> +{
>> +	int i;
>> +	unsigned long *page = (unsigned long *)ptr;
>> +
>> +	WARN_ON_ONCE(!IS_ALIGNED(len, sizeof(unsigned long)));
>> +
>> +	if (likely(value == 0)) {
>> +		memset(ptr, 0, len);
>> +	} else {
>> +		for (i = 0; i < len / sizeof(*page); i++)
>> +			page[i] = value;
>> +	}
>> +}
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
>

good idea, i hope kernel could support family functions like memfill/memset_long
in lib. but this is beyond zram scope.
>
> .
>
