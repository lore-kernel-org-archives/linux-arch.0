Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C74399FE
	for <linux-arch@vger.kernel.org>; Wed,  5 Aug 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927925; cv=none; b=nO/5AjCa5g4hUF9YDZRGamEqy0tRhT9f+gSPcylNuIGyZAp8flxAnVpjVX6gi4RVJ/j2g4+kgw27/Jb3YhW3rgovGIy7xpAa3NupnLLe33/fxFbjOiZiyttp+3kWZP96y2Aiq7J2wo2aZo6xT41nvGhAk4/IyUEbyG2nrloS7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927925; c=relaxed/simple;
	bh=YOkkqKX4+u8mPyIVjenBy8RUOP83bzF999F4R+vmBPU=;
	h=Message-Id:References:Cc:In-Reply-To:Mime-Version:Content-Type:To:
	 From:Subject:Date; b=O6A7C1XqfUlTew9NPBPL0d1oBLLFJGkAgd7iLK07JWxn+5fsf32A8nz7oGTc+FEfCJbEZAoJZKJNcSB9f7SjCS3rBrQxTY8Y9pDY0hnmC+WqkDwWJ7N9HF2gpMJH8VvyBO+wzgryBZEHLiqmHPHtwQgEz3UYtDkknA9Rha+8uFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bD+JxAel; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bD+JxAel"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785927918; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=o4866Y3ff9b3uwVCiml3jDWbGReoFxp6nuoKOcd5mp8=;
 b=bD+JxAelPaBAqKsaAkHvcjwYA4gQ/Io3NVhLtBV/VZ8382OogBThLvqDU6LWtbiEGj9ZyY
 Q/DXuQgD2TriUtpQ2bSghV7NOIdtqpxIVhpKFsQnUV8Jr83Q2CCnfP08Ywh+8WAVIcZbLT
 rJD1jBz8Re6xhcNw1Urw4HFzNyjoGlowHPKOs/yerEXr6tTt+If38LTiTBW2qNfljRRnwM
 dv1E3fqwRsslV43t3tXMVu0dVEwcA61bdgHSuYVkW/2W7YeaA+2zQs3Zkd0poZ/0AhBGy1
 vA5ZPEKIeM9eBCvwnHuO/UFnr6nPSiE9fG4CXBKilzTOyH/5x9GF98ij0ojsbA==
Message-Id: <94d6172a-b7a5-4eac-96b3-15cc83d424b3@bytedance.com>
References: <20260803070929.86075-1-lizhe.67@bytedance.com> <20260803070929.86075-9-lizhe.67@bytedance.com> <20260804203508.GEanJM_LGXmItYhFKZ@fat_crate.local>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
In-Reply-To: <20260804203508.GEanJM_LGXmItYhFKZ@fat_crate.local>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a7318ec+6d8bd8+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Borislav Petkov" <bp@alien8.de>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v9 8/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Date: Wed, 5 Aug 2026 19:04:55 +0800

On 8/5/26 4:35 AM, Borislav Petkov wrote:
> On Mon, Aug 03, 2026 at 03:09:29PM +0800, Li Zhe wrote:
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>> server.
>>
>> Test procedure:
>> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
>> initialization time from the pr_debug() output of
>> memmap_init_zone_device().
>>
>> With memcpy_nontemporal() used by the ZONE_DEVICE template-copy path:
>>    Average of rebinds for nd_pmem driver: 150.83 ms
>>    Average of rebinds for dax_pmem driver: 153.55 ms
>>
>> With this x86 fixed-size fastpath patch applied:
>>    Average of rebinds for nd_pmem driver: 96.79 ms
>>    Average of rebinds for dax_pmem driver: 119.04 ms
>>
>> This further reduces the average memmap initialization time measured
>> during rebind by about 35.8% for nd_pmem and 22.5% for dax_pmem.
> Testing methodology doesn't usually belong in the commit message but under the
> "---" lines below but this is important enough to keep it here.
>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>>   arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
> A quick and untested cleanup ontop with the potential for a bunch more
> unification. But later.
>
> Note that you're inconsistent about the "memory" clobber. The current code
> doesn't have it, you're adding it to movnti_8(). I've added it now everywhere
> to be on the safe side - it would be interesting to know whether you see any
> perf difference with and without it in your use case.
>
> Thx.


Thanks, I will fold the cleaned-up version into v10.

I also tested the memcpy_flushcache() fixed-size path with and without
the "memory" clobber. In this build, the generated assembly for this
path is the same in both cases.

I also ran the ZONE_DEVICE rebind test with both variants. The difference
was below 1% for both nd_pmem and dax_pmem, with no stable direction, so
I do not see a measurable performance difference from the "memory"
clobber in this use case.

Given that, I will keep the clobber for consistency and safety.

Thanks,
Zhe

>
> ---
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index bc6a9f34b346..3a1e1f17431b 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -83,6 +83,14 @@ int strcmp(const char *cs, const char *ct);
>   #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
>   void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
>   
> +static __always_inline void movnti_4(void *dst, const void *src)
> +{
> +	asm volatile("movntil %1, %0"
> +		     : "=m"(*(u32 *)dst)
> +		     : "r"(*(u32 *)src)
> +		     : "memory");
> +}
> +
>   static __always_inline void movnti_8(void *dst, const void *src)
>   {
>   	asm volatile("movntiq %1, %0"
> @@ -112,47 +120,26 @@ static __always_inline void movnti_64(void *dst, const void *src)
>   static __always_inline void memcpy_flushcache(void *dst, const void *src,
>   					      size_t cnt)
>   {
> -	if (__builtin_constant_p(cnt)) {
> -		switch (cnt) {
> -			case 4:
> -				asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
> -				return;
> -			case 8:
> -				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
> -				return;
> -			case 16:
> -				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
> -				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
> -				return;
> -			/*
> -			 * The relevant fixed-size copies here are the
> -			 * x86_64 struct page sizes: 64, 80, and 96 bytes.
> -			 * Keep 32-byte and 48-byte copies inline as well
> -			 * instead of sending those nearby fixed-size
> -			 * cases back to __memcpy_flushcache().
> -			 */
> -			case 32:
> -				movnti_32(dst, src);
> -				return;
> -			case 48:
> -				movnti_32(dst, src);
> -				movnti_16(dst + 32, src + 32);
> -				return;
> -			case 64:
> -				movnti_64(dst, src);
> -				return;
> -			case 80:
> -				movnti_64(dst, src);
> -				movnti_16(dst + 64, src + 64);
> -				return;
> -			case 96:
> -				movnti_64(dst, src);
> -				movnti_32(dst + 64, src + 64);
> -				return;
> -		}
> +	if (!__builtin_constant_p(cnt))
> +		return __memcpy_flushcache(dst, src, cnt);
> +
> +	/*
> +	 * The relevant fixed-size copies here are the x86_64 struct page sizes:
> +	 * 64, 80, and 96 bytes. Keep 32-byte and 48-byte copies inline as well
> +	 * instead of sending those nearby fixed-size cases back to
> +	 * __memcpy_flushcache().
> +	 */
> +	switch (cnt) {
> +	case 4:  movnti_4(dst, src); break;
> +	case 8:	 movnti_8(dst, src); break;
> +	case 16: movnti_16(dst, src); break;
> +	case 32: movnti_32(dst, src); break;
> +	case 48: movnti_32(dst, src); movnti_16(dst + 32, src + 32); break;
> +	case 64: movnti_64(dst, src); break;
> +	case 80: movnti_64(dst, src); movnti_16(dst + 64, src + 64); break;
> +	case 96: movnti_64(dst, src); movnti_32(dst + 64, src + 64); break;
> +	default: __memcpy_flushcache(dst, src, cnt); break;
>   	}
> -
> -	__memcpy_flushcache(dst, src, cnt);
>   }
>   
>   #define memcpy_nontemporal memcpy_nontemporal
