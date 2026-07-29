Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4523ABBE;
	Wed, 29 Jul 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368961; cv=none; b=aCWR9hiDBzPnuCldVRxCYrt8U6LkIABa7l7trlb2hYYENa9v9VbekV+MGIlwAzcQ2oE+dBVrolfW33FYqzfT2h7UEfDwbROkNiuvPJVNXo1ScLeY3viuEkoId2komI/XoMvr0gb3x9u87ppYf4mN2K2QPeDuObX8sy1tws0VSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368961; c=relaxed/simple;
	bh=m4eai55ihkHg5mb2tP46fzBPiw578VfReG2MVgcZMkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoWoR3yzWlt7RWLCDJx3InjTHpE1kMjqJStRlBTxp2/4EZmFB5ivKlVFmxUoQtkjq/ciCF1fQRp2PkV/05G4Jl2GP2rALMsVq0X9ucn9rNhIEsXDGks8kieTIvJi33PFm6hSwwoYWJSSPw5f22XquHxibB1Y2dVpU/WIEWCirfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IGOIE2H/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IGOIE2H/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68FE640E014C;
	Wed, 29 Jul 2026 23:49:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 52_uhmkqnzvn; Wed, 29 Jul 2026 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785368944; bh=qXrfSofmj6bTld7YiDEE7BLXD3xXP7iHfJcsgH4Yw4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGOIE2H/sEeS+6u3224/vW0vSFH/k6NkgQ0qLWQ1lB9h/zmr9VghR9S+Hm8sa3WNB
	 1QF3Au2c7RGwDpUMcBCbNhzQ3eqpciRIalHE8HdFdMKlajw/Mtx29W/kjO2iTOyEqE
	 IyQN4iJqSXTuDLg/VVSKr+4S34N7WpXqYh9e04RRA6Ad4Z5u7KBcAvfmj0QQ+1zyqa
	 Uk61i0OCSH9c90yQeBXUwaXgdoJERW2J+L6ynUeKXo7n2d8aaar3XVTJAMzFOnPHIX
	 T+gVGj0ytatglOBnx5IiMTDQw9wdhdZj679IEb+/qAIWgh7i7C96c4SxuyrI5IAgWV
	 vU2Sx5MXG8ba4ZZPcuyn1veDWuI2MzogEEjBQyapmZmW+3A7tw6ytRH4Sm4+0mY+EB
	 xkG8UTQmyMTbhhkmM1Q5wnXVu+N0T2/hhQluyaiwK66BtOllD6y10GA85Z6k5QYTln
	 VKRcW/4zyulaPymTmuQxLQ9eIUmpqPWENv44iE/PNEi7K0sxVBL1LwPGcf3Je8ui1l
	 FkEn2F4Jq3PS+IwmBtWtFDCsTmAnnn4Q2bK2/c3ynrPbAADzPSlk3BWtdJcMikPHDb
	 9IRvYleAs+lqUgmJDIwiSmhn22PMh3IVaINWq2UKs3u7SRlSHMUgFP7Vj9mGnZ4p0B
	 LjlVQFijomNRDgfEaVhDaKZo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C59940E00C4;
	Wed, 29 Jul 2026 23:48:46 +0000 (UTC)
Date: Wed, 29 Jul 2026 16:48:42 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, dave.hansen@linux.intel.com, david@kernel.org,
	kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev,
	rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v8 7/9] x86/string: extend memcpy_flushcache() fixed-size
 fastpaths
Message-ID: <20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
 <20260727123429.5673-8-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727123429.5673-8-lizhe.67@bytedance.com>

On Mon, Jul 27, 2026 at 08:34:27PM +0800, Li Zhe wrote:
> The new x86 memcpy_nontemporal() helper in this series maps to

s/in this series//

That's implicit.

> memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
> for constant-sized struct page template copies.
> 
> The immediately relevant x86_64 sizeof(struct page) values here are 64,
> 80, and 96 bytes. memcpy_flushcache() currently inlines only the 4, 8,
> and 16-byte cases, so even those constant-sized struct page copies fall
> through to __memcpy_flushcache().
> 
> Add 32, 48, 64, 80, and 96-byte MOVNTI sequences to the main fixed-size
> switch so those constant-sized copies can stay on the inline path.
> Factor the larger sequences into movnti_8()/16()/32()/64() helpers so
> the switch can reuse them without duplicating the inline assembly.
> While the ZONE_DEVICE template-copy path only needs 64/80/96-byte
> copies, keep 32-byte and 48-byte copies inline as well rather than
> sending those nearby fixed-size cases back to __memcpy_flushcache().

Do not explain the code - explain *why* those sizes. I already asked a bunch
of times.

> 
> These new fixed-size cases follow the existing memcpy_flushcache()
> fixed-size MOVNTI cases. The existing 4/8/16-byte cases already use
> MOVNTI without a separate destination alignment check.
> 
> The movnti_8()/16()/32()/64() helpers keep the "memory" clobber
> intentionally. The destination memory operand describes the MOVNTI
> destination, but it does not express the broader compiler-scheduling
> constraint that this path wants: keep the fixed-size copy as a compact
> sequence of streaming stores and avoid moving unrelated memory accesses
> into the middle of that sequence.

A lot of bla for its own sake.

> A microbenchmark compared two memcpy_flushcache()-style helpers that
> shared the same generic body and differed only in whether
> 32/48/64/80/96-byte copies stayed in the fixed-size switch or were
> redirected to __memcpy_flushcache() when the destination was not 8-byte
> aligned. The timed interval covered the copy loop only; wmb() was used
> only to separate rounds.

So we're doing this only for a microbenchmark's sake?

> In pseudo-code, the two variants were:
> 
> variant A:
> 	switch (len) {
> 		case 32:
> 		case 48:
> 		case 64:
> 		case 80:
> 		case 96:
> 			do fixed-size MOVNTI stores;
> 			return;
> 		default:
> 			generic __memcpy_flushcache()-style body;
> 	}
> 
> variant B:
> 	switch (len) {
> 		case 32:
> 		case 48:
> 		case 64:
> 		case 80:
> 		case 96:
> 			if (!IS_ALIGNED(dst, 8))
> 				goto generic_path;
> 			do fixed-size MOVNTI stores;
> 			return;
> 		default:
> 	generic_path:
> 			generic __memcpy_flushcache()-style body;
> 	}
> 
> For offsets 1..7 averaged, keeping those sizes in the fixed-size
> switch took about 0.410/0.411/0.426/0.426/0.428 us per
> 32/48/64/80/96-byte copy, while redirecting the same cases to
> __memcpy_flushcache() took about 0.962/0.956/0.923/0.998/1.001 us.
> 
> The correctness rationale for not adding a separate destination
> alignment check is that these cases follow the existing 4/8/16-byte
> memcpy_flushcache() MOVNTI cases, and I did not find Intel SDM text
> requiring an 8-byte aligned destination for MOVNTI.
> 
> The microbenchmark is only the performance motivation for keeping
> these small constant-size copies in the inline path.

So in the end of the commit message, I still don't know why we need this code.

I mean, it should be pretty trivial to explain: I'm adding those additional
sizes because it brings this and that. Srsly.

If you cannot justify that, why are you even doing it?

So from going over this again, the reason why you're adding those other sizes
are because struct page can be that big. Yes?

How do you know? What's the proof?

I'd expect a justification along the lines of: in a somewhat normal Linux
installation, struct size can be of size <bla>. Adding MOVNTI helpers of size
<bla> brings so and so performance uplift.

How hard it is to write it this way?

> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)

...

at least the code is making a lot more sense now.

The fact that you had to axe off so much cruft off of it tells me that you
haven't really measured it right.

So why do I really want your patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
