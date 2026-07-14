Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AB43B493
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021087; cv=none; b=Yih4cBlhq2fsZSGpvbFGAzrpDIlOIBg2chnK+FGnkRXseY+fmXRDfNydKNOnZH4q/m3gjnGmpKHkxKwzyyxfdqnrkJ9Eig7+lSFiy7G/OuPhI7F5zVdUny3kwEb4EdLfl8lrldZnnHYvsp01ivTcEgMP26RtJhS3yB8rLYMaXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021087; c=relaxed/simple;
	bh=JvKuPu1h+fmU1DlLyv/btl9euwDWmRlPzGe2LygsLuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCzxD707vx0stBu53vkDCqCQ2E+wrV10+2RnIoXkOj/kdlbhw2jBWs7GzE3yZiXk5KJtBKakBXXzkDgF0PfnUhTEH7GzqchUuCmHG9ZLaOGYFTdXz6U+GBgoNyTBFiVrXPBheFEFS0xFZ1Fp2PJbmNI1Ph4UY0rsyfXLWPcW098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1vqSLt7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1vqSLt7"
Message-ID: <7bfb13a0-8f4a-4f4b-9df4-da842169f8f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784021072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5hVbWmSdqOj3dZyKgFalHXz2yWT1XoIB2Yzua6Nbdg=;
	b=c1vqSLt7YpRFDe2umMN3RExEnZnsJ+Y62WB5Cqnqs4LFBiYnVCK1S7k4r+DG46NqwyT+jo
	rXth3VEv29BtauCCiBfDvRWZ4gxMd1r2Irwis0JtMD2c3IhnXOrtyT6uofDsp8Wy5HUCHI
	T7FTDTnEjCFXCWSd1OgEjrANW97a/2s=
Date: Tue, 14 Jul 2026 17:24:23 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 6/8] string: introduce memcpy_nt() helpers
To: Li Zhe <lizhe.67@bytedance.com>
Cc: linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org,
 tglx@kernel.org
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-7-lizhe.67@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-7-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/9 19:25, Li Zhe wrote:
> Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
> that want a named non-temporal copy primitive plus an explicit drain
> step.
>
> On x86_64, override both helpers in arch/x86/include/asm/string_64.h
> using the usual self-macro pattern, next to the existing
> memcpy_flushcache() backend that memcpy_nt() wraps. The x86_64
> implementation maps memcpy_nt() to memcpy_flushcache() and uses wmb()
> for memcpy_nt_drain(), because that backend issues MOVNTI stores and
> callers need an ordering point before later normal stores that depend
> on those writes becoming visible.
>
> include/linux/string.h provides the generic fallback under
> memcpy_nt() as plain memcpy() and leaves memcpy_nt_drain() empty, so
> architectures that do not override memcpy_nt() do not pay an
> unconditional barrier. Architectures that later grow a specialized
> memcpy_nt() backend can override memcpy_nt_drain() with whatever
> drain primitive their memory-ordering rules require.
>
> The immediate user is the ZONE_DEVICE template-copy path. It populates
> struct page descriptors in a write-once pattern, so a regular cached
> memcpy() can incur avoidable write-allocate traffic and cache
> pollution for data with little near-term reuse.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>   arch/x86/include/asm/string_64.h | 22 ++++++++++++++++++++++
>   include/linux/string.h           | 23 +++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 4635616863f5..6cb9e0ac7fa0 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -4,6 +4,7 @@
>
>   #ifdef __KERNEL__
>   #include <linux/jump_label.h>
> +#include <asm/barrier.h>
>
>   /* Written 2002 by Andi Kleen */
>
> @@ -100,6 +101,27 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
>   	}
>   	__memcpy_flushcache(dst, src, cnt);
>   }
> +
> +#define memcpy_nt memcpy_nt
> +/*
> + * Reuse the existing x86 flushcache backend as the nt copy primitive.
> + * Callers pair it with memcpy_nt_drain() when later stores must be
> + * ordered after the copy.
> + */
> +static __always_inline void memcpy_nt(void *dst, const void *src, size_t cnt)
> +{
> +	memcpy_flushcache(dst, src, cnt);

Why not use memcpy_flushcache() directly in device dax path? I don't
understand the necessity of introducing memcpy_nt here.

> +}
> +
> +#define memcpy_nt_drain memcpy_nt_drain
> +static __always_inline void memcpy_nt_drain(void)
> +{
> +	/*
> +	 * Order the prior MOVNTI stores issued by memcpy_flushcache()
> +	 * before later normal stores.
> +	 */

I also have a question here: why are we using wmb to guarantee visibility
at this stage?

Since we are still in the very early phases of memory initialization 
(specifically,
struct page initialization), since we are still in an intermediate 
initialization
state, this shouldn't be visible to other CPUs anyway.

Thanks.

> +	wmb();
> +}
>   #endif
>
>   #endif /* __KERNEL__ */
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 5702daca4326..a109b2f86ca6 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -278,6 +278,29 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>   }
>   #endif
>
> +#ifndef memcpy_nt
> +/*
> + * memcpy_nt() requests a non-temporal copy when the architecture has a
> + * suitable backend. Architectures that do not override it fall back to
> + * memcpy().
> + */
> +static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
> +{
> +	memcpy(dst, src, cnt);
> +}
> +#endif
> +
> +#ifndef memcpy_nt_drain
> +/*
> + * Callers use memcpy_nt_drain() before later normal stores that need to
> + * be ordered after memcpy_nt(). Architectures without a specialized
> + * backend can leave it empty.
> + */
> +static inline void memcpy_nt_drain(void)
> +{
> +}
> +#endif
> +
>   void *memchr_inv(const void *s, int c, size_t n);
>   char *strreplace(char *str, char old, char new);
>
> --
> 2.20.1
>

