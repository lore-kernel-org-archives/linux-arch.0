Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E64A3F03
	for <linux-arch@vger.kernel.org>; Thu, 15 Oct 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078981; cv=none; b=Bdm0xen5Pg3+F8h0u6tqjjblw6cRWftfv5WIJM83Jv3REmkKmLlFVegxioC9KRNnokl6DQg7xTfJtkbQIQzJnx6PixD2jeuQ9FS9HCyypW6gSnnfPoEq0mIRvtYMa1/DjsXdjSSD1QIf9t3vxHsY6iE3kZmGVTOiytLXaIkkhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078981; c=relaxed/simple;
	bh=1fUOi+Usxn2LQcFzjoDicMxQvfperVSbtfIS6t3a0mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxPS0T27jlqXg7Wry6b2ITvQdA3PCTvj9kbpasg/8tmsiUPVnXv+L71uOcg7H8S6/oSUhVRPpC4pFwbIJW26sQ6uq7ilDrjl0VJWIiErzQrhZADLn7FWPoRI8/JPF/xOJ2kEs5LzR3JrEekPuM0a2WlMMWvksE+MUnrmKRtvu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0UR9SXf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0UR9SXf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so34013545e9.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Oct 2026 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792078967; x=1792683767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EVUVXTF9B/pmjVEVo0zfJaBGiZoNVg7V5lse2RyO7M=;
        b=R0UR9SXfSdLRKN8vgsjzhyd81oaEz7tHTwslAVD4uu2yocB8iyTzeaX91HJfAF2HSZ
         zfyNFy9tY2rveIy5HSk4kHu6cou98Mmm65Nw/ib9mtV2wnXWSnap0yORcKiRn9+bhNLb
         /HvkgPwk8c21B4vfdeFwnATqt/tKh7V1N6JFjc1GswxG79FMaIisTlhabNQRTkYz/AAi
         A1KK2BSF7pJOfDu8sLbpi305mh4DqIdXIenAOtLPi3roSTwyU1GWiEULVpymwqlkfLkZ
         ApWTy1oTpVVOcfy57kt0RsQYUZoCNCDNc0yb16GC0j95gqwCT6HKnJMFBD1/29NWON5y
         v/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078967; x=1792683767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8EVUVXTF9B/pmjVEVo0zfJaBGiZoNVg7V5lse2RyO7M=;
        b=0+MzHVdJucCwHA8ggGZFChHvyLSsTCMOdxvikw4l+mm9mAPPlbv7ach96Zylcoaeq7
         H8Nf1yDflPgBs3838JWScmwNlacMfF9TCtbg0pE6Y/k9t9h4nAEbXxNz3jQzy30Mj1Sr
         dJP+FiaXnaj46NCUqgrUhORTqIUraOfPh8UBwqmMh929VYcB6KTnGqPCZa+Bc5KkrXHf
         Ka6zaj3utEPMVexbaXI3XBRQZQ8xH2Rdzu3rVrX0maAlIyOFL6yd0RCoccqiA2pDn2hI
         bGpIwDS6NuCqgLWO13ZunDAsbaZ4rmhu5pEynOJxvV0b1Fr7tyhcSoSPS/rFCY9QZOYq
         fYSw==
X-Forwarded-Encrypted: i=1; AKwUvBybj8j5M+9Gpxpot+/a+Q+dR40l30cX8gxMCO4EY14lEjbmniHTTixF1tqPDbDjgO01+KFSbt198IxV@vger.kernel.org
X-Gm-Message-State: AFq9FYJkY8UznqXaQT47kJSRFsj8Evq/jgH2DOj2dgOTsAt9iM4IgDcJ
	l7/9kxG0kDtxYqJeLhRrMcNwwW/AmgVqWXhikghQxctBy9DTW3MZiNftd5RmNIdNj/8=
X-Gm-Gg: AYBFou1r/ZE2DvSYHFJYNZzqa3bUs1nKFo8PxwwRQXWKtVwf90LgJdQG8PzPbK9xb2M
	Y6FxFROmE9BGLJbPwHAZXn/C7B31+D5xOrLXSN8arcugy6+3k3m7z/5KD3rElgthygQMbzlEr9W
	QeT2UcV2eyeASc3kBSzsSKsf36sD1L4sFX6XIDwWeAMfzJAUYwqnKubCAPR2zCJ7zaOi6wN+J7S
	Jof8hH00w34enEQLZmBJ1S02cP7NFgJzComxh/FZNv18Tc9nADYgoDg3Q0+LcG/4k0b0vhAPLfW
	dAJ0MqNWv2PnljcEyMfNQB+/xGWXbgwNEpwVPKXjEVAYrQdATOm6xJjnFH7vw7t+kdPP5TJIij8
	Qo4MgYF3AdZ6QKd2krtNys4GlU57RJYStFehxufzooNPO5M5rk1VXO27umj7ZhmTo9dUJVo7/dH
	gkzFsmkUqc6oSaVYrpVJwpE58kXOWapPRFyw/RYS8KgfQsKmsoaOsaCGGMmbTkx3rXnn7ykE6Bh
	uh6OLd4kE27bU5LPpCckC7uwVb0KxQfs1yZoXc4cq3x7A==
X-Received: by 2002:a05:600c:8b82:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a18e4b887amr354993855e9.27.1792078967287;
        Thu, 15 Oct 2026 08:42:47 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66c5e6sm52172585e9.2.2026.10.15.08.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:42:46 -0700 (PDT)
Message-ID: <d17b00f9-2a6c-425f-9697-6bc8f31f7a7a@suse.com>
Date: Thu, 15 Oct 2026 17:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/22] modpost: cache section relocation mismatch state
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-hardening@vger.kernel.org
References: <20260923-build-speedup-v4-0-73128809a4a4@kernel.org>
 <20260923-build-speedup-v4-13-73128809a4a4@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923-build-speedup-v4-13-73128809a4a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 7:18 PM, Lorenzo Stoakes (ARM) wrote:
> For every relocation modpost invokes check_section_mismatch() to determine
> whether there is any kind of mismatch between the source and destination,
> and if so which classification applies.
> 
> Each time it does this it invokes section_mismatch() which iterates
> through the sectioncheck[] array every time it's called.
> 
> When walked a relocation section the source is fixed and there aren't many
> targets, so the same names are looked up over and over again.
> 
> Therefore cache not only mismatch categorisation but also whether a
> mismatch even exists for a given section and look up the sections in the
> cache.
> 
> Special indices (undefined, absolute, common) take the uncached path as
> before.
> 
> This results in very significant speed ups for allmodconfig incremental
> builds.
> 
> modpost is on the serial tail of every build that links vmlinux.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 defconfig, touch mm/vma.c, gcc        8.5s     8.3s    -0.14s (-2%)
>   x86 defconfig, touch mm/vma.c, clang      7.7s     7.6s    -0.13s (-2%)
>   x86 allmodconfig, touch mm/vma.c, gcc    33.9s    29.4s     -4.5s (-13%)
>   x86 allmodconfig, touch mm/vma.c, clang  31.9s    27.9s     -4.0s (-13%)
> 
> Assisted-by: LLM
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

This looks mostly ok to me. Below are some nits you might want to
consider addressing.

> ---
>  scripts/mod/modpost.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 75374c64b8cc..0fd43c8a89ea 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1155,12 +1155,67 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
>  			 name);
>  }
>  
> +/*
> + * mismatch_cache[section index] ->
> + *   0 - uncached.
> + *  -1 - no mismatch.
> + *  >0 - mismatch index + 1.
> + */
> +static int *mismatch_cache;

It might be cleaner to maintain this cache per elf_info, since it
logically belongs to the processing of an individual ELF file. This
would also be consistent with the existing symsearch cache, which uses
elf::symsearch.

The description could use 'to_secndx' instead of 'section index' to
clarify whether it refers to the source or destination section of
a relocation.

> +
> +static void init_mismatch_cache(unsigned int num_sections)
> +{
> +	mismatch_cache = xcalloc(num_sections, sizeof(*mismatch_cache));
> +}
> +
> +static void reset_mismatch_cache(unsigned int num_sections)
> +{
> +	memset(mismatch_cache, 0, num_sections * sizeof(*mismatch_cache));
> +}
> +
> +static void free_mismatch_cache(void)
> +{
> +	free(mismatch_cache);
> +	mismatch_cache = NULL;
> +}
> +
> +static const struct sectioncheck
> +*cache_mismatch(unsigned int secndx, const struct sectioncheck *mismatch)

Similarly here, s/secndx/to_secndx/.

> +{
> +	if (!mismatch) {
> +		mismatch_cache[secndx] = -1;
> +		return NULL;
> +	}
> +
> +	mismatch_cache[secndx] = (mismatch - sectioncheck) + 1;
> +	return mismatch;
> +}
> +
> +static const struct sectioncheck *get_section_mismatch(const char *fromsec,
> +		const struct elf_info *elf, unsigned int secndx)

s/secndx/to_secndx/, and the fromsec and elf arguments could be swapped
for consistency with the rest of the code.

> +{
> +	int cached;
> +
> +	if (secndx >= elf->num_sections)
> +		return section_mismatch(fromsec, sec_name(elf, secndx));
> +
> +	cached = mismatch_cache[secndx];
> +	if (cached < 0)
> +		return NULL;
> +	if (cached > 0)
> +		return &sectioncheck[cached - 1];
> +
> +	return cache_mismatch(secndx,
> +			      section_mismatch(fromsec, sec_name(elf, secndx)));
> +}
> +
>  static void check_section_mismatch(struct module *mod, struct elf_info *elf,
>  				   Elf_Sym *sym,
>  				   unsigned int fsecndx, const char *fromsec,
>  				   Elf_Addr faddr, Elf_Addr taddr)
>  {
> -	const char *tosec = sec_name(elf, get_secindex(elf, sym));
> +	const unsigned int to_secndx = get_secindex(elf, sym);

The const qualifier can be dropped from the to_secndx definition to
match the usual kernel style.

-- 
Thanks,
Petr
