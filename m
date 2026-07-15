Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C921CC71
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096360; cv=none; b=nBInylPxZkt8t87UbNM/qOnRx/4hwtLRGXHzddC+0ttkD5hN4+SamaExjFGMXn0jcEVF2tnFwxOQOxVMGdn49bj0xmbeCeHzqvrNSK8Nz7UH7QE1kwzQJ3CJFfO5Z1vf0RtmrPc6fRRbi6pPeHQZdc//paTETnqdDhdzra1rngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096360; c=relaxed/simple;
	bh=/uoPEMWHBxJqjD+lvYlYW7fv8YA0LyJzXoEQxvPEpvM=;
	h=Message-Id:References:From:Subject:Mime-Version:Content-Type:Cc:
	 Date:In-Reply-To:To; b=W/WgO6lY0JbcgSRDhTZJWUOhaTgID5bOqqCAJZMoqYcV0WCWCUS5u+jnqmLA/Rmyn0f2S89K1P9diJIV8dFQ31kwM3EKWR98r9UHAxuWNdi2wIkIClr2he/9Vr/B7J+Y+Tk+vzKSdjJ5JsySAssEO1UB/DuPSUXaB0bIQlIxK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZAuN3Q+5; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZAuN3Q+5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784096353; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/uoPEMWHBxJqjD+lvYlYW7fv8YA0LyJzXoEQxvPEpvM=;
 b=ZAuN3Q+5oshtTOCeRZItTV/Y4DRqsV3g7mGWJSnW6IM2FDaij/whhqjh5cb5/f8OpMNJD+
 JSCR2WNGlQNyBXIkaxc3R5NTHb40bzsWnEU7zvigRmgQbNsM9slqLWBgGKJ9Yl43PRS3UL
 QMP5ytZxjK2uMxJJfy6yHkTfdNgvQ+TJH4cX25/TPp6uWl575rwyFQBgS6k58cPaEGZoiW
 w8j5qrGdHxFE9Y6mPjWE+DVSfX4PRJvtKDp/PHbQQ6Ge3ZxSAZ23p2771tymjojntVfxMD
 2CvPtARoPwIPfxFZzgG3Ks+Ojgb0evSXMRQQLtWVzxA/5TWO9YX/Yo7ZeEGe1w==
Message-Id: <abd1f6da-a6f4-40ed-923f-94201bba4690@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <20260709112520.24857-7-lizhe.67@bytedance.com> <7bfb13a0-8f4a-4f4b-9df4-da842169f8f1@linux.dev>
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v6 6/8] string: introduce memcpy_nt() helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a57265f+811200+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Date: Wed, 15 Jul 2026 14:18:50 +0800
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7bfb13a0-8f4a-4f4b-9df4-da842169f8f1@linux.dev>
To: "Muchun Song" <muchun.song@linux.dev>

On 7/14/26 5:24 PM, Muchun Song wrote:
>
>
> On 2026/7/9 19:25, Li Zhe wrote:
>> Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
>> that want a named non-temporal copy primitive plus an explicit drain
>> step.
>>
>> On x86_64, override both helpers in arch/x86/include/asm/string_64.h
>> using the usual self-macro pattern, next to the existing
>> memcpy_flushcache() backend that memcpy_nt() wraps. The x86_64
>> implementation maps memcpy_nt() to memcpy_flushcache() and uses wmb()
>> for memcpy_nt_drain(), because that backend issues MOVNTI stores and
>> callers need an ordering point before later normal stores that depend
>> on those writes becoming visible.
>>
>> include/linux/string.h provides the generic fallback under
>> memcpy_nt() as plain memcpy() and leaves memcpy_nt_drain() empty, so
>> architectures that do not override memcpy_nt() do not pay an
>> unconditional barrier. Architectures that later grow a specialized
>> memcpy_nt() backend can override memcpy_nt_drain() with whatever
>> drain primitive their memory-ordering rules require.
>>
>> The immediate user is the ZONE_DEVICE template-copy path. It populates
>> struct page descriptors in a write-once pattern, so a regular cached
>> memcpy() can incur avoidable write-allocate traffic and cache
>> pollution for data with little near-term reuse.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>> =C2=A0 arch/x86/include/asm/string_64.h | 22 ++++++++++++++++++++++
>> =C2=A0 include/linux/string.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 23 +++++++++++++++++++++++
>> =C2=A0 2 files changed, 45 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/string_64.h=20
>> b/arch/x86/include/asm/string_64.h
>> index 4635616863f5..6cb9e0ac7fa0 100644
>> --- a/arch/x86/include/asm/string_64.h
>> +++ b/arch/x86/include/asm/string_64.h
>> @@ -4,6 +4,7 @@
>>
>> =C2=A0 #ifdef __KERNEL__
>> =C2=A0 #include <linux/jump_label.h>
>> +#include <asm/barrier.h>
>>
>> =C2=A0 /* Written 2002 by Andi Kleen */
>>
>> @@ -100,6 +101,27 @@ static __always_inline void=20
>> memcpy_flushcache(void *dst, const void *src, size_t
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __memcpy_flushcache(dst, src, cnt);
>> =C2=A0 }
>> +
>> +#define memcpy_nt memcpy_nt
>> +/*
>> + * Reuse the existing x86 flushcache backend as the nt copy primitive.
>> + * Callers pair it with memcpy_nt_drain() when later stores must be
>> + * ordered after the copy.
>> + */
>> +static __always_inline void memcpy_nt(void *dst, const void *src,=20
>> size_t cnt)
>> +{
>> +=C2=A0=C2=A0=C2=A0 memcpy_flushcache(dst, src, cnt);
>
> Why not use memcpy_flushcache() directly in device dax path? I don't
> understand the necessity of introducing memcpy_nt here.
>

The reason for introducing memcpy_nt() is to give generic MM code a
named non-temporal copy primitive, instead of hardwiring the x86
memcpy_flushcache() backend into a generic caller.

On x86, memcpy_nt() maps to memcpy_flushcache() today. On other
architectures, memcpy_flushcache() may have different semantics, and we
also do not know whether its implementation would provide the same
optimization opportunity as on x86. Using memcpy_nt() lets the generic
caller express the intent while leaving the backend choice to each
architecture.

>> +}
>> +
>> +#define memcpy_nt_drain memcpy_nt_drain
>> +static __always_inline void memcpy_nt_drain(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Order the prior MOVNTI stores issued by memc=
py_flushcache()
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * before later normal stores.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>
> I also have a question here: why are we using wmb to guarantee visibility
> at this stage?
>
> Since we are still in the very early phases of memory initialization=20
> (specifically,
> struct page initialization), since we are still in an intermediate=20
> initialization
> state, this shouldn't be visible to other CPUs anyway.
>
> Thanks.

The drain is not about exposing the intermediate initialization state to
other CPUs.

It is there to order the earlier non-temporal stores before the later
normal stores on the same control path, for example before
memmap_init_compound() / prep_compound_head() update overlapping
compound metadata.

On x86, memcpy_nt() maps to MOVNTI-based memcpy_flushcache(), so
memcpy_nt_drain() uses wmb(), which maps to the required sfence there.

Thanks,
Zhe

>
>> +=C2=A0=C2=A0=C2=A0 wmb();
>> +}
>> =C2=A0 #endif
>>
>> =C2=A0 #endif /* __KERNEL__ */
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 5702daca4326..a109b2f86ca6 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -278,6 +278,29 @@ static inline void memcpy_flushcache(void *dst,=20
>> const void *src, size_t cnt)
>> =C2=A0 }
>> =C2=A0 #endif
>>
>> +#ifndef memcpy_nt
>> +/*
>> + * memcpy_nt() requests a non-temporal copy when the architecture has a
>> + * suitable backend. Architectures that do not override it fall back to
>> + * memcpy().
>> + */
>> +static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
>> +{
>> +=C2=A0=C2=A0=C2=A0 memcpy(dst, src, cnt);
>> +}
>> +#endif
>> +
>> +#ifndef memcpy_nt_drain
>> +/*
>> + * Callers use memcpy_nt_drain() before later normal stores that=20
>> need to
>> + * be ordered after memcpy_nt(). Architectures without a specialized
>> + * backend can leave it empty.
>> + */
>> +static inline void memcpy_nt_drain(void)
>> +{
>> +}
>> +#endif
>> +
>> =C2=A0 void *memchr_inv(const void *s, int c, size_t n);
>> =C2=A0 char *strreplace(char *str, char old, char new);
>>
>> --=20
>> 2.20.1
>>
>
