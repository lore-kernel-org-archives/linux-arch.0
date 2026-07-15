Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11C43302D
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108054; cv=none; b=pxZP/mFXiC77jQ8qgLxpw04LZzfF3zsPN10EVqlVr+uRu4Gl+Ioadief/93zpWvWFtFYdJcH8NKgWiQbPcJMQhMMRusGQJfM8h0oM55SL0Yc/NV9LV6RLgfBBX1aA52IvHfYy+ipisZew2dPG6LfPKCkfUME07b/USAY8+6GZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108054; c=relaxed/simple;
	bh=3awXuump5UvqnDy3qde52dqw5qWrD3T9YG0fYi5Lkek=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dIF5a6/lQZZIIgDmzY1CJ0L177C8fhrteIxKAc4HgcXTHF3Vfw3RtT5Spv2qHxXhYvC8uAYlCFPFfdwmT7sQK88JoucJuHAfSpwBB69Hj2TebnvbzzfKXSZrSLk+X2dZqbWI7t9Lk4uGpgk6E+kM0whrK0Y93VMDfq2G74uPE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oV2WHMYL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oV2WHMYL"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784108034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF3YK+5K8ha0tN8sHxJR+k2ivBzzY2bSpI1XmJ8lbwQ=;
	b=oV2WHMYLzQrj/FC0XxU5Bg9xXz4idugxo/OKh71BZIVBG86rtJiCwmFwGmJIjzy1d6AS8k
	NAIM7CS+ilWXPpi4vtRsWA9zDKTGHWvDmrqYaD/uj3jK1H++xIDx4nDVNik0TpJprQKjIA
	AeEtthAUvoyCOg6fX/hEwxAFZN4Wsyc=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v6 6/8] string: introduce memcpy_nt() helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <abd1f6da-a6f4-40ed-923f-94201bba4690@bytedance.com>
Date: Wed, 15 Jul 2026 17:33:15 +0800
Cc: linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 x86@kernel.org,
 akpm@linux-foundation.org,
 apopple@nvidia.com,
 arnd@arndb.de,
 balbirs@nvidia.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 david@kernel.org,
 kees@kernel.org,
 mingo@redhat.com,
 rppt@kernel.org,
 tglx@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <80A0AAC8-DC3C-4FB7-8CE3-EF2EC96EB47F@linux.dev>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-7-lizhe.67@bytedance.com>
 <7bfb13a0-8f4a-4f4b-9df4-da842169f8f1@linux.dev>
 <abd1f6da-a6f4-40ed-923f-94201bba4690@bytedance.com>
To: Li Zhe <lizhe.67@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 15, 2026, at 14:18, Li Zhe <lizhe.67@bytedance.com> wrote:
> 
> On 7/14/26 5:24 PM, Muchun Song wrote:
>> 
>> 
>> On 2026/7/9 19:25, Li Zhe wrote:
>>> Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
>>> that want a named non-temporal copy primitive plus an explicit drain
>>> step.
>>> 
>>> On x86_64, override both helpers in arch/x86/include/asm/string_64.h
>>> using the usual self-macro pattern, next to the existing
>>> memcpy_flushcache() backend that memcpy_nt() wraps. The x86_64
>>> implementation maps memcpy_nt() to memcpy_flushcache() and uses wmb()
>>> for memcpy_nt_drain(), because that backend issues MOVNTI stores and
>>> callers need an ordering point before later normal stores that depend
>>> on those writes becoming visible.
>>> 
>>> include/linux/string.h provides the generic fallback under
>>> memcpy_nt() as plain memcpy() and leaves memcpy_nt_drain() empty, so
>>> architectures that do not override memcpy_nt() do not pay an
>>> unconditional barrier. Architectures that later grow a specialized
>>> memcpy_nt() backend can override memcpy_nt_drain() with whatever
>>> drain primitive their memory-ordering rules require.
>>> 
>>> The immediate user is the ZONE_DEVICE template-copy path. It populates
>>> struct page descriptors in a write-once pattern, so a regular cached
>>> memcpy() can incur avoidable write-allocate traffic and cache
>>> pollution for data with little near-term reuse.
>>> 
>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>> ---
>>>   arch/x86/include/asm/string_64.h | 22 ++++++++++++++++++++++
>>>   include/linux/string.h           | 23 +++++++++++++++++++++++
>>>   2 files changed, 45 insertions(+)
>>> 
>>> diff --git a/arch/x86/include/asm/string_64.h 
>>> b/arch/x86/include/asm/string_64.h
>>> index 4635616863f5..6cb9e0ac7fa0 100644
>>> --- a/arch/x86/include/asm/string_64.h
>>> +++ b/arch/x86/include/asm/string_64.h
>>> @@ -4,6 +4,7 @@
>>> 
>>>   #ifdef __KERNEL__
>>>   #include <linux/jump_label.h>
>>> +#include <asm/barrier.h>
>>> 
>>>   /* Written 2002 by Andi Kleen */
>>> 
>>> @@ -100,6 +101,27 @@ static __always_inline void 
>>> memcpy_flushcache(void *dst, const void *src, size_t
>>>       }
>>>       __memcpy_flushcache(dst, src, cnt);
>>>   }
>>> +
>>> +#define memcpy_nt memcpy_nt
>>> +/*
>>> + * Reuse the existing x86 flushcache backend as the nt copy primitive.
>>> + * Callers pair it with memcpy_nt_drain() when later stores must be
>>> + * ordered after the copy.
>>> + */
>>> +static __always_inline void memcpy_nt(void *dst, const void *src, 
>>> size_t cnt)
>>> +{
>>> +    memcpy_flushcache(dst, src, cnt);
>> 
>> Why not use memcpy_flushcache() directly in device dax path? I don't
>> understand the necessity of introducing memcpy_nt here.
>> 
> 
> The reason for introducing memcpy_nt() is to give generic MM code a
> named non-temporal copy primitive, instead of hardwiring the x86
> memcpy_flushcache() backend into a generic caller.
> 
> On x86, memcpy_nt() maps to memcpy_flushcache() today. On other
> architectures, memcpy_flushcache() may have different semantics, and we
> also do not know whether its implementation would provide the same
> optimization opportunity as on x86. Using memcpy_nt() lets the generic
> caller express the intent while leaving the backend choice to each
> architecture.

Got it. But the 'nt' suffix is overly abbreviated and not direct enough.
Therefore, I suggest avoiding uncommon abbreviations and instead keeping
things as explicit as the 'flushcache' suffix in memcpy_flushcache.

> 
>>> +}
>>> +
>>> +#define memcpy_nt_drain memcpy_nt_drain
>>> +static __always_inline void memcpy_nt_drain(void)
>>> +{
>>> +    /*
>>> +     * Order the prior MOVNTI stores issued by memcpy_flushcache()
>>> +     * before later normal stores.
>>> +     */
>> 
>> I also have a question here: why are we using wmb to guarantee visibility
>> at this stage?
>> 
>> Since we are still in the very early phases of memory initialization 
>> (specifically,
>> struct page initialization), since we are still in an intermediate 
>> initialization
>> state, this shouldn't be visible to other CPUs anyway.
>> 
>> Thanks.
> 
> The drain is not about exposing the intermediate initialization state to
> other CPUs.
> 
> It is there to order the earlier non-temporal stores before the later
> normal stores on the same control path, for example before
> memmap_init_compound() / prep_compound_head() update overlapping
> compound metadata.

For a single core, out-of-order execution is invisible to developers.
Therefore, I'm curious about your reasons for preserving the order? What
would be the consequences of not maintaining it?

Thanks.

> 
> On x86, memcpy_nt() maps to MOVNTI-based memcpy_flushcache(), so
> memcpy_nt_drain() uses wmb(), which maps to the required sfence there.
> 
> Thanks,
> Zhe
> 
>> 
>>> +    wmb();
>>> +}
>>>   #endif
>>> 
>>>   #endif /* __KERNEL__ */
>>> diff --git a/include/linux/string.h b/include/linux/string.h
>>> index 5702daca4326..a109b2f86ca6 100644
>>> --- a/include/linux/string.h
>>> +++ b/include/linux/string.h
>>> @@ -278,6 +278,29 @@ static inline void memcpy_flushcache(void *dst, 
>>> const void *src, size_t cnt)
>>>   }
>>>   #endif
>>> 
>>> +#ifndef memcpy_nt
>>> +/*
>>> + * memcpy_nt() requests a non-temporal copy when the architecture has a
>>> + * suitable backend. Architectures that do not override it fall back to
>>> + * memcpy().
>>> + */
>>> +static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
>>> +{
>>> +    memcpy(dst, src, cnt);
>>> +}
>>> +#endif
>>> +
>>> +#ifndef memcpy_nt_drain
>>> +/*
>>> + * Callers use memcpy_nt_drain() before later normal stores that 
>>> need to
>>> + * be ordered after memcpy_nt(). Architectures without a specialized
>>> + * backend can leave it empty.
>>> + */
>>> +static inline void memcpy_nt_drain(void)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>   void *memchr_inv(const void *s, int c, size_t n);
>>>   char *strreplace(char *str, char old, char new);
>>> 
>>> -- 
>>> 2.20.1


