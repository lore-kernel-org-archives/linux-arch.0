Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9E2EAB6F;
	Sun,  7 Jun 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780859326; cv=none; b=jxuiTfXtP7154HR0ZUOFVtREI4HqVdbxxJquC3cUAYqhJlWcKqXB10icX4zyOY/5h/3vvRBwRf3qUi0xppRmrirleBulduubwZ4+J6alG0IAp0/97roSiI+VEQBj4QTrsAkBxXgQtRVpNtlcfKDHYE2vbW1IGmlJPfmHE0g6g9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780859326; c=relaxed/simple;
	bh=KSHR9qcrfCr8Ul9JRUnIOS0ajfBpdMO9FGKQirQthoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to2B4ZJitPaeYRmxPxMWqxgiXthabzjLb/Y9u+HquIj+A7UgBJ+wn3DpIfwPSLaWcaiwVM3JqLA1lmN3FHk1oeLt2H09307K/4Qd8M3r0z1gh2qmOuP4PKtVP2vtYM8XgMzhoWpPAUTUQlC5O9D972FHNejltii1MqeJbuCwKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hIB2Juxo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hIB2Juxo"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C062540E015D;
	Sun,  7 Jun 2026 19:08:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QAl3fNcanhlf; Sun,  7 Jun 2026 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1780859304; bh=okDVFSTv4fCBjivazCm7I0myKhLAMvL8UQn0109STco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIB2Juxoi41C2nak1bGnPQhU7XE0vXEQwAAdlVdQl6oQC2nQpTxiq41pc/H3MEudq
	 QYYtfBSnXLtHzb/dHDTUOKEg7iGTimpxsLk1xXo+kwOg32DpNY/FT061/sNBoPBVBL
	 cjKZBA7wT1A1Tml9E7znkNjiw77/0TN3nDQORozxFEZtU485QGNTJXSGp4MfSPCahi
	 fg86YTgH44T3eMOPorP/J/ozHp2iU0lPrVqxWGldTSu3iIUyur7ygGd3twJrSf0ji5
	 LDNWYI0LLHyHdi0aXerenDTEIlWbIaFImylW4HpA4dZdpPHmHP0ij1NSIbkQxA1Pdr
	 xjcfWpTc/mMuZ/wbYs8KtHM5FiT7s5bgK5vqyl6ST5orNLZi4ayT5gahAMViGlEQ//
	 7r3iiYFMKGQNOhbgfzYwFp1qbsRrVrQeiW6wYbJvB3iCSZM4tzrJOBcVjsoPP0LPrH
	 Nawz8/Aj3W2Z36cIfYNasDgBLnq5b2T7cBPPev3Lmd6U7/whVUMoKdwzTJjUIz1vvp
	 b1rJQw21Q1syJVlgPuEdFRQYaGoxYlM7pvWtL94i8JWxHHzRGhXmwrnN1bh1RPRBsh
	 v5trxIa/WyUaoUuAHOsoZmHIXpAUe0+MFryTvGDyRq5/kS96++KAsilyB4y1eYze2e
	 vhRusUz3/6YDNd6PjNAxM2Ns=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5307B40E0031;
	Sun,  7 Jun 2026 19:08:08 +0000 (UTC)
Date: Sun, 7 Jun 2026 12:08:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	mingo@redhat.com, rppt@kernel.org, tglx@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 6/8] string: introduce memcpy_streaming() helpers
Message-ID: <20260607190804.GAaiXBlGO2eRcfs1oB@fat_crate.local>
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
 <20260603080152.64728-7-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603080152.64728-7-lizhe.67@bytedance.com>

On Wed, Jun 03, 2026 at 04:01:50PM +0800, Li Zhe wrote:
> Introduce a generic memcpy_streaming() interface for write-once copy
> sites that can fall back to memcpy() when no architecture-specific
> optimization is available, or when an architecture-specific backend
> cannot safely handle a given transfer.
> 
> Add memcpy_streaming_drain() alongside it so callers can separate the
> copy primitive from any required ordering point. On x86, use
> memcpy_flushcache() and sfence only for aligned transfers that can stay
> entirely on the non-temporal store path; otherwise fall back to memcpy()

So you throwing "streaming", "non-temporal" and "flush-cache" wildly around
here and this is adding unnecessary confusion where it shouldn't. I'd suggest
you stick to "non-temporal" which you can abbreviate short'n'sweet to "nt" and
that's it. Keep it simple.

> so the generic API does not expose flushcache semantics on cached
> head/tail fragments.
> 
> Callers are responsible for invoking memcpy_streaming_drain() before
> later normal stores that must be ordered after the streaming copy.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  arch/x86/include/asm/string_64.h | 32 ++++++++++++++++++++++++++++++++
>  include/linux/string.h           | 20 ++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 4635616863f5..aee63108577f 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h

There's arch/x86/include/asm/string.h. Why are those here, in the _64 variant?

> @@ -4,6 +4,7 @@
>  
>  #ifdef __KERNEL__
>  #include <linux/jump_label.h>
> +#include <linux/align.h>
>  
>  /* Written 2002 by Andi Kleen */
>  
> @@ -100,6 +101,37 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
>  	}
>  	__memcpy_flushcache(dst, src, cnt);
>  }
> +
> +/*
> + * Only map memcpy_streaming() to memcpy_flushcache() when the destination
> + * is already 8-byte aligned and the size can be handled without cached
> + * head/tail fragments in __memcpy_flushcache().
> + */
> +static __always_inline bool memcpy_flushcache_nt_safe(const void *dst,
> +						      size_t cnt)

This is checking alignment. Then call it that.

> +{
> +	unsigned long d = (unsigned long)dst;

Useless.

> +
> +	return cnt && IS_ALIGNED(d, 8) && IS_ALIGNED(cnt, 4);
> +}

AFAICT, this helper is used only once. Zap it completely.

> +
> +#define __HAVE_ARCH_MEMCPY_STREAMING 1
> +static __always_inline void memcpy_streaming(void *dst, const void *src,

memcpy_nt()

> +					     size_t cnt)
> +{
> +	if (!cnt)
> +		return;
> +
> +	if (memcpy_flushcache_nt_safe(dst, cnt))

That branch can cost. Why is that alignment checking so necessary? Why can't
you simply DTRT by handling the misaligned parts like __memcpy_flushcache().

What does this bring you? None of that is explained in the commit message so
why do I want this patch at all?

The commit message is basically telling me what the patch does but I can kinda
read that from the diff itself. What it is not telling me is *why* it exists.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
