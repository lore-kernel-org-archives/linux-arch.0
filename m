Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9A2F616A;
	Thu,  2 Jul 2026 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959056; cv=none; b=SzZ4EkwIu0Wnyw5E9lXUIwA0ZOgFBIemTIivv1N9MFNXoP8Tx4uWLQ6xUEvC14SeS+ntHSQUb03JWOiRegrzKikNK+cCp3JaSOvaHXwgmDC5Uu/hz15pKaVW439XYSagufRKd8p/ffg5jnjEUhkxdap5FsW1HHAPZqSq2l1kmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959056; c=relaxed/simple;
	bh=cU34nqVEDRIccnSVupQbuwArcvZyohvPJ5aP1DuloYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FANHXclDAkXPv5mQiQvAgmwiknLFdKPY1bKWx95lXylG4DlCSyx07ah43LY+V4s47+wHmMn3fuh78i+9NCOnZW/hGohvTOmcZYaZwvgoo4Kut1IDidJMXW/RH03shymHxp4eppYi/AXE5bMxEQyl0x5mmMjFZkzf5FAqOnIlMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NFNKISPE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NFNKISPE"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 86EFE40E0140;
	Thu,  2 Jul 2026 02:24:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tneRHNFUh4kK; Thu,  2 Jul 2026 02:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782959040; bh=3hs5J8V4xbxK8pQYu5UpOpwtFXGPKA4FORJJupVnn+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFNKISPE5vj6zIiAPjDdnafh0uWiL83gGF5fQK1EzWPxu6bDVedcKGU7pFAwPsw7K
	 eT9OQsGNq7baK8SdKzca3nPsK+H3AnIEcpUlFXewxIqrghmG9tdUvvpwOU0Zt07gxc
	 F+Rb0olcWGPOMic7fwJm3TbyuqA1Ny9nmfV+LUpdWfxF4t4adBiC3HiaIbxp9zHJq6
	 GKYNo2LdK9euipTcqtkLRfN2X64UsDkeb2VmKuRXsAt7dUtY0OSWWSC8Mf5Z3shsph
	 9k8E1DZ9PuiVboCLyuR1NVzfVfvsk/aa6p1PuqFmCvT4/Hwe2qiD5XeihcdrcQbcBa
	 NhFYmmx8yhCXODyj9mavlz3HZSYU9r8W1oKybjqMXObWsLqfO/yJu3Pqv37XU0k8yP
	 JaUAViR+3xUGKR24W1FwhbIDuStgcq/tJEg+f4pqHz/96RChaslvISE5Xk96RugX4o
	 y4xu0PTXAWm/niPItGTdejenUvZ1yTbrFyL+eAa3iE3YpNSGGiKVwWbuImUYd9iGSH
	 vW6+MgSCozdtTB/KCSM5EkHG9BxQ/vOry/CYTTI2WAzjB67vnOGNG6DcKFIzWNAwjR
	 PcO6Em6FK7awgAlBBXyBNTEJ3I0jcdkTssG4M6fYJpp+WHXTCgWjnaK6PNGdjkGz0g
	 9vsmLGUJgOsVt23gZC1WadgQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4544740E00C0;
	Thu,  2 Jul 2026 02:23:45 +0000 (UTC)
Date: Wed, 1 Jul 2026 19:23:42 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	mingo@redhat.com, rppt@kernel.org, tglx@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size
 fastpaths
Message-ID: <20260702022342.GFakXLrl7ryd-g7gTu@fat_crate.local>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
 <20260701090553.62691-8-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701090553.62691-8-lizhe.67@bytedance.com>

On Wed, Jul 01, 2026 at 05:05:52PM +0800, Li Zhe wrote:
> The new x86 memcpy_nt() helper in this series maps to
> memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
> for constant-sized struct page template copies.
> 
> memcpy_flushcache() currently inlines only the 4, 8, and 16-byte
> cases. Larger constant-sized copies fall back to __memcpy_flushcache()
> even when the destination is naturally aligned. Extend the inline
> movnti coverage to 32, 48, 64, 80, and 96 bytes so the struct

Why exactly those sizes and not bigger?

Any numbers to back this up?

> page-sized copies used by that path can stay on the inline
> non-temporal store path instead of dropping into the out-of-line
> helper.
> 
> Factor the store sequences into 8/16/32/64-byte helpers, keep the
> existing 4/8/16-byte cases handled directly in memcpy_flushcache(),
> issue the stores in ascending address order, and leave all other sizes
> on __memcpy_flushcache().
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  arch/x86/include/asm/string_64.h | 80 +++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 6f36abedc56a..95ef2d481418 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -4,6 +4,7 @@
>  
>  #ifdef __KERNEL__
>  #include <linux/jump_label.h>
> +#include <linux/align.h>
>  
>  /* Written 2002 by Andi Kleen */
>  
> @@ -82,8 +83,81 @@ int strcmp(const char *cs, const char *ct);
>  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
>  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
>  void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
> -static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> +
> +static __always_inline void memcpy_flushcache_8(void *dst, const void *src)

If this is calling MOVNTI, you might as well call it that way. Only leave the
externally exposed wrapper called "flushcache".

> +{
> +	asm volatile("movntiq %1, %0"
> +		     : "=m"(*(u64 *)dst)
> +		     : "r"(*(const u64 *)src)
> +		     : "memory");
> +}
> +
> +static __always_inline void memcpy_flushcache_16(void *dst,
> +						 const void *src)
> +{
> +	memcpy_flushcache_8(dst, src);
> +	memcpy_flushcache_8(dst + 8, src + 8);
> +}
> +
> +static __always_inline void memcpy_flushcache_32(void *dst,
> +						 const void *src)
> +{
> +	memcpy_flushcache_16(dst, src);
> +	memcpy_flushcache_16(dst + 16, src + 16);
> +}
> +
> +static __always_inline void memcpy_flushcache_64(void *dst,
> +						 const void *src)
>  {
> +	memcpy_flushcache_32(dst, src);
> +	memcpy_flushcache_32(dst + 32, src + 32);
> +}
> +
> +/*
> + * Keep the additional aligned fixed-size cases on the inline movnti path.
> + * Leave the existing 4/8/16-byte cases handled directly in
> + * memcpy_flushcache() so their code generation stays unchanged.
> + */
> +static __always_inline int memcpy_flushcache_large(void *dst,
> +						   const void *src,
> +						   size_t cnt)
> +{
> +	char *dptr = dst;
> +	const char *sptr = src;
> +
> +	if (!IS_ALIGNED((unsigned long)dst, 8))
> +		return 0;
> +
> +	switch (cnt) {
> +	case 32:
> +		memcpy_flushcache_32(dptr, sptr);
> +		return 1;
> +	case 48:
> +		memcpy_flushcache_32(dptr, sptr);
> +		memcpy_flushcache_16(dptr + 32, sptr + 32);
> +		return 1;
> +	case 64:
> +		memcpy_flushcache_64(dptr, sptr);
> +		return 1;
> +	case 80:
> +		memcpy_flushcache_64(dptr, sptr);
> +		memcpy_flushcache_16(dptr + 64, sptr + 64);
> +		return 1;
> +	case 96:
> +		memcpy_flushcache_64(dptr, sptr);
> +		memcpy_flushcache_32(dptr + 64, sptr + 64);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static __always_inline void memcpy_flushcache(void *dst, const void *src,
> +					      size_t cnt)
> +{
> +	if (!cnt)
> +		return;
> +
>  	if (__builtin_constant_p(cnt)) {
>  		switch (cnt) {
>  			case 4:
> @@ -97,7 +171,11 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
>  				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
>  				return;
>  		}
> +
> +		if (memcpy_flushcache_large(dst, src, cnt))

Why is this a separate function and not extending the switch-case?

I betcha it has to do with the alignment check but nothing explains to me why.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
