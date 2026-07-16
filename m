Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08841D640
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202876; cv=none; b=Cm5tHvBhtElVXwXmCmNTryiCPe54sq40Mjpvq3tomRtXBi42zDejxuegNnSCC/0vDQlWfeQrE4ynIR34ZII7+FQchPFx4noJkLaUkz8Uqy5RTcLvld63UaYvSNluARUoY0j71a/eybq9ebApkegYnY8dgWmEQO/RQiwtywxpIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202876; c=relaxed/simple;
	bh=lO107y5Q5Kp0EODI6wCrcSBNpLSLIXIBgVySKLMvYyc=;
	h=In-Reply-To:From:Date:Message-Id:Content-Type:References:To:Cc:
	 Subject:Mime-Version; b=dKSETijND7lKyyuOGzdU20NxyAXy4w5mVBdYYPuWkhoWsOnKeWphS8c5c5ybl3tXOReO059b+AkXuwg7iPBp6QM0uGWyjihpG7BCxlK37yNwvFcNykmaHEhsyFipII9sR9vkvKfVsq2XgK8vGqFl9eAHVzAk3YhBleITCTI1a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MJTWhNQe; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MJTWhNQe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784202868; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Zb47wRi4sOHO/8LTR4EG3esNvOTJsaH8noXff1aeIwg=;
 b=MJTWhNQew6v0eZvRbbfNeS+Vp8cKNtK1qj+MRg5zVU2UWui8OZ2/RLCTrziOi9i3k90KNG
 NP/yOlVKqVw+39ymBCgo2aLs9AhG+OAf7goiBaImNUm2ne4HQqk5MVuDPnpM3SJP1RkK5m
 Ys2DQNtsHrjrxCcSjraHu1SeEABHatb08cml5TFKmLwwWMrKMNycFh3oTe5x7MzQ22jkSG
 4oXA6w43Lorz0Xg/AI2qqj/8PSrMsF1DL/BVc/Mn+j3dh7XqbCSkGI6t9ceQEObXHXgpmq
 jNYnHlTtlTxPG4gM+TQl5Ju9wKjY7wNtjCLRVg8MWbOKIodqH45riJ8H11AfvA==
In-Reply-To: <80A0AAC8-DC3C-4FB7-8CE3-EF2EC96EB47F@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 16 Jul 2026 19:54:05 +0800
Message-Id: <fb1795f0-7dd0-4518-9760-2f14cc3107f8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-7-lizhe.67@bytedance.com> <7bfb13a0-8f4a-4f4b-9df4-da842169f8f1@linux.dev> <abd1f6da-a6f4-40ed-923f-94201bba4690@bytedance.com> <80A0AAC8-DC3C-4FB7-8CE3-EF2EC96EB47F@linux.dev>
Content-Transfer-Encoding: 7bit
To: "Muchun Song" <muchun.song@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Subject: Re: [PATCH v6 6/8] string: introduce memcpy_nt() helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a58c672+fb92ac+vger.kernel.org+lizhe.67@bytedance.com>

On 7/15/26 5:33 PM, Muchun Song wrote:
>
>> On Jul 15, 2026, at 14:18, Li Zhe <lizhe.67@bytedance.com> wrote:
>>
>> On 7/14/26 5:24 PM, Muchun Song wrote:
>>>
>>> On 2026/7/9 19:25, Li Zhe wrote:
>>>> Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
>>>> that want a named non-temporal copy primitive plus an explicit drain
>>>> step.
>>>>
>>>> On x86_64, override both helpers in arch/x86/include/asm/string_64.h
>>>> using the usual self-macro pattern, next to the existing
>>>> memcpy_flushcache() backend that memcpy_nt() wraps. The x86_64
>>>> implementation maps memcpy_nt() to memcpy_flushcache() and uses wmb()
>>>> for memcpy_nt_drain(), because that backend issues MOVNTI stores and
>>>> callers need an ordering point before later normal stores that depend
>>>> on those writes becoming visible.
>>>>
>>>> include/linux/string.h provides the generic fallback under
>>>> memcpy_nt() as plain memcpy() and leaves memcpy_nt_drain() empty, so
>>>> architectures that do not override memcpy_nt() do not pay an
>>>> unconditional barrier. Architectures that later grow a specialized
>>>> memcpy_nt() backend can override memcpy_nt_drain() with whatever
>>>> drain primitive their memory-ordering rules require.
>>>>
>>>> The immediate user is the ZONE_DEVICE template-copy path. It populates
>>>> struct page descriptors in a write-once pattern, so a regular cached
>>>> memcpy() can incur avoidable write-allocate traffic and cache
>>>> pollution for data with little near-term reuse.
>>>>
>>>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>>> ---
>>>>    arch/x86/include/asm/string_64.h | 22 ++++++++++++++++++++++
>>>>    include/linux/string.h           | 23 +++++++++++++++++++++++
>>>>    2 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/string_64.h
>>>> b/arch/x86/include/asm/string_64.h
>>>> index 4635616863f5..6cb9e0ac7fa0 100644
>>>> --- a/arch/x86/include/asm/string_64.h
>>>> +++ b/arch/x86/include/asm/string_64.h
>>>> @@ -4,6 +4,7 @@
>>>>
>>>>    #ifdef __KERNEL__
>>>>    #include <linux/jump_label.h>
>>>> +#include <asm/barrier.h>
>>>>
>>>>    /* Written 2002 by Andi Kleen */
>>>>
>>>> @@ -100,6 +101,27 @@ static __always_inline void
>>>> memcpy_flushcache(void *dst, const void *src, size_t
>>>>        }
>>>>        __memcpy_flushcache(dst, src, cnt);
>>>>    }
>>>> +
>>>> +#define memcpy_nt memcpy_nt
>>>> +/*
>>>> + * Reuse the existing x86 flushcache backend as the nt copy primitive.
>>>> + * Callers pair it with memcpy_nt_drain() when later stores must be
>>>> + * ordered after the copy.
>>>> + */
>>>> +static __always_inline void memcpy_nt(void *dst, const void *src,
>>>> size_t cnt)
>>>> +{
>>>> +    memcpy_flushcache(dst, src, cnt);
>>> Why not use memcpy_flushcache() directly in device dax path? I don't
>>> understand the necessity of introducing memcpy_nt here.
>>>
>> The reason for introducing memcpy_nt() is to give generic MM code a
>> named non-temporal copy primitive, instead of hardwiring the x86
>> memcpy_flushcache() backend into a generic caller.
>>
>> On x86, memcpy_nt() maps to memcpy_flushcache() today. On other
>> architectures, memcpy_flushcache() may have different semantics, and we
>> also do not know whether its implementation would provide the same
>> optimization opportunity as on x86. Using memcpy_nt() lets the generic
>> caller express the intent while leaving the backend choice to each
>> architecture.
> Got it. But the 'nt' suffix is overly abbreviated and not direct enough.
> Therefore, I suggest avoiding uncommon abbreviations and instead keeping
> things as explicit as the 'flushcache' suffix in memcpy_flushcache.


Thanks, that makes sense. The abbreviated "nt" name came from Boris'
earlier suggestion to keep the naming focused on non-temporal stores and
to abbreviate that as "nt":

https://lore.kernel.org/all/20260607190804.GAaiXBlGO2eRcfs1oB@fat_crate.local/

But I agree that, for a generic string helper, spelling this out is
clearer. I will rename the helper to memcpy_nontemporal() in the next
version.

>>>> +}
>>>> +
>>>> +#define memcpy_nt_drain memcpy_nt_drain
>>>> +static __always_inline void memcpy_nt_drain(void)
>>>> +{
>>>> +    /*
>>>> +     * Order the prior MOVNTI stores issued by memcpy_flushcache()
>>>> +     * before later normal stores.
>>>> +     */
>>> I also have a question here: why are we using wmb to guarantee visibility
>>> at this stage?
>>>
>>> Since we are still in the very early phases of memory initialization
>>> (specifically,
>>> struct page initialization), since we are still in an intermediate
>>> initialization
>>> state, this shouldn't be visible to other CPUs anyway.
>>>
>>> Thanks.
>> The drain is not about exposing the intermediate initialization state to
>> other CPUs.
>>
>> It is there to order the earlier non-temporal stores before the later
>> normal stores on the same control path, for example before
>> memmap_init_compound() / prep_compound_head() update overlapping
>> compound metadata.
> For a single core, out-of-order execution is invisible to developers.
> Therefore, I'm curious about your reasons for preserving the order? What
> would be the consequences of not maintaining it?
>
> Thanks.
You are right. My previous explanation overstated the need for this
ordering point.

For the intended ZONE_DEVICE callers added later in the series,
memcpy_nontemporal() is used while the struct page metadata is still
being initialized and before that memmap is published for normal use.
The later ordinary stores to the compound metadata are also part of the
same initialization sequence. So those callers do not need a generic
drain helper just to order the non-temporal copy against later local
initialization stores.

I will drop memcpy_nt_drain() from the generic interface and remove the
drain calls from the ZONE_DEVICE user.

Thanks,
Zhe


>
>> On x86, memcpy_nt() maps to MOVNTI-based memcpy_flushcache(), so
>> memcpy_nt_drain() uses wmb(), which maps to the required sfence there.
>>
>> Thanks,
>> Zhe
>>
>>>> +    wmb();
>>>> +}
>>>>    #endif
>>>>
>>>>    #endif /* __KERNEL__ */
>>>> diff --git a/include/linux/string.h b/include/linux/string.h
>>>> index 5702daca4326..a109b2f86ca6 100644
>>>> --- a/include/linux/string.h
>>>> +++ b/include/linux/string.h
>>>> @@ -278,6 +278,29 @@ static inline void memcpy_flushcache(void *dst,
>>>> const void *src, size_t cnt)
>>>>    }
>>>>    #endif
>>>>
>>>> +#ifndef memcpy_nt
>>>> +/*
>>>> + * memcpy_nt() requests a non-temporal copy when the architecture has a
>>>> + * suitable backend. Architectures that do not override it fall back to
>>>> + * memcpy().
>>>> + */
>>>> +static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
>>>> +{
>>>> +    memcpy(dst, src, cnt);
>>>> +}
>>>> +#endif
>>>> +
>>>> +#ifndef memcpy_nt_drain
>>>> +/*
>>>> + * Callers use memcpy_nt_drain() before later normal stores that
>>>> need to
>>>> + * be ordered after memcpy_nt(). Architectures without a specialized
>>>> + * backend can leave it empty.
>>>> + */
>>>> +static inline void memcpy_nt_drain(void)
>>>> +{
>>>> +}
>>>> +#endif
>>>> +
>>>>    void *memchr_inv(const void *s, int c, size_t n);
>>>>    char *strreplace(char *str, char old, char new);
>>>>
>>>> -- 
>>>> 2.20.1
