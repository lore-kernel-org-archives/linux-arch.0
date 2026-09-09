Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F04CCDD3
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968252; cv=none; b=fKzHVU5YK5//3jMvzGH77zFm7SI8SyKM9QR+gByPjPiSJVk3nhqLWFP5jRxUGCF2bD96vKWFFYjCcbMxOchNuoYx0hboEnlLTaqcH5melRnXa6ef244eIn4V6iBBb+exvnCSFOW3jpNn2YBxDNvUoVZeovMkVSVYlpT4degptpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968252; c=relaxed/simple;
	bh=tlXMq73KJhLbqOa3sBQb6U+eAptv38yQqOaGm+TCraA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaqGc0x5jM5Aob3eDi48GHu8Cb8MwaMtvBs0SiupDlH2RJ5gNGzNyMWVPuvOBZ2z9SQ1KHvo56BdoUWv1qHkeYhYsiLdCZ8Lf5WWiG6q4MAwNwjw4OCb30uhoKDSujLpo4cgVGwryTBg8YPJjh8OKT7tM29QWB+ZztJ2YrW64Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MqvaKTZQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MqvaKTZQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so1920482a12.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788968248; x=1789573048; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7MDRo1IEz0/ztB5k2AgA6IiU/moC5VF/pQ54TqLA70=;
        b=MqvaKTZQ8jWTLjEaYtIw3pD39fHkAjH3DbeArNucFFXEnIxZgB05AeC6+kOToLaVEV
         bnGeiSBBGAVhHxhvOWWi0jtedu6uk4PQjCt47uMzUCoWdzFq+rQB5TY7MIYPIDJiK5MN
         Sw5urVZ9l78mUIxx8fi90kv9vwChqfDDztyZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968248; x=1789573048;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B7MDRo1IEz0/ztB5k2AgA6IiU/moC5VF/pQ54TqLA70=;
        b=m7tmx0vlGZuBxnLlOwk0Do2MfSm3VRP83uL3H0u5vlnfE5xhl0SV4yYzaLbqsDHLnQ
         aLUCJeGpuz5H2sUZ4JoAbRSib9YGirLkT01YmNzMgmSg9DXRX1KJ9PYlftmPz2RzKzvh
         ODAhxt1IGgdyMc72RqgEsZLQabkGTKnmw0A5fVkqe/KTcHyn4CAT2NWZc3hulbDQcTlJ
         ivihG+ZFpSV1K2E+ctWKIsEZUJsS2JFTuClLQLiCwCzu3BuDRhSGD8VPjp6dkvRXCk9r
         Rw/tIwX3msheJRyoYmv1dQnALM/3nu4FoIWT5XlGHBX7odnzwwM5JKQSQfR4vY0wVM2W
         aTEQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4HsJHmWwf//XwO384Pch0YYwRaav3jdMJEMRurRfg5cYAQl1kwRjQKmT3qIR89z/DeYDfTvFFsLMj@vger.kernel.org
X-Gm-Message-State: AFuF++n23dzWP1RWGmsucA/GIt/tv6YTW8AD8v0Kkwp71lXzCdujIf2a
	lIsSpy9Aj7WMtv3P6htsTCk80hgRkh9lAUtg7+vd6X2R6GLhZZEp986ILnoZn9OQTCA+gxyCYkB
	TiCIWIF2foLmb
X-Gm-Gg: AYBFou1I3RedysdiR3jnFewm9aNG+h4c/Bod5oSl0oRPcdMI7HyP3GYvTAFp7Im+1gU
	jVgqg+UF2IDpm9pwea/YllHJx3eQRodZg430C6odyhZUsuTloCHAoRzhBw1dKibbDM38VX4o2dA
	w1BKfI74g3R4gEgfC2JMPtkvCYKvzwcGEa1LDKDknMSH5v3uCcjWn1zO3SWjJekt0yV5hG3vgtk
	CNnlzDCCQNx+aSt77QJsryRFpa1GKvi8GIHaU/rT6HRmLnyJSbD+3Fmusewq5ezdOnuqkYDcCp+
	hQ947ool6ObXP19B1i1M0Fd9a5mRGJrUTCyJ0Xqd31uYFLKxOiGGsbMZN4/tE4+EDtO+McwBHBw
	nSA7DX8o3tIhzfneZx7FEoxbEj/KFUCiPguXHHCkq5yzvVIwOQnPgPmSaaaK2vhK/4cDPin0twG
	my6l8Acl8NHt72n+f8qHoZfg64BPcuBxcUnGFTqR6Uycp2hIZjKhk8bKLeH59TVQDGR3TBsYeep
	asd6aWclc0TLNvw93gtJodIwcYk0g==
X-Received: by 2002:a05:6402:3206:b0:6a6:1a05:8b30 with SMTP id 4fb4d7f45d1cf-6a98df9e490mr5458594a12.6.1788968247998;
        Wed, 09 Sep 2026 08:37:27 -0700 (PDT)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com. [2a00:1450:4864:33::10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a88b7c04edsm2227098a12.15.2026.09.09.08.37.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:37:27 -0700 (PDT)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae45so2040001a12.2
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByj3IzmAd3uC3DAZorgi8ZC5dAvtx40HmMzTt65bAoeeceXoT9WA9YR8OS4/6cGvJO2Nj5nbit9Vsji@vger.kernel.org
X-Received: by 2002:a05:6402:3817:b0:6a6:58e:f84b with SMTP id
 4fb4d7f45d1cf-6a98dfd77b1mr5256449a12.9.1788968246832; Wed, 09 Sep 2026
 08:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Sep 2026 08:37:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieaheq8rXSps3xRZpNNMQMEj9BH5gU+Dh4q_ZgokO51Q@mail.gmail.com>
X-Gm-Features: AcwNN1XKEJS_S8eITIntw19v_mcHyut1QfPlZfjowWaI1qZq5Mivgkqwhzm7f_s
Message-ID: <CAHk-=wieaheq8rXSps3xRZpNNMQMEj9BH5gU+Dh4q_ZgokO51Q@mail.gmail.com>
Subject: Re: [PATCH 00/23] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Sept 2026 at 13:55, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> A typical kernel build consists of a frustratingly large amount of time

.. you're preaching to the choir.

>                 == allmodconfig FULL build ==
>
>                         before    after     delta
>                       ----------------------------------
> Threadripper, gcc       345.3s   275.2s    -70.1s (-20%)

Well, that's certainly very encouraging. We should do this. I sent out
some emails as just reactions to individual patches, but I have no
numbers to back any of those emails up, and I never actually applied
this series to my tree - they were all based on reading the patches
themselves.

That said:

> An LLM was used to first determine where the bottlenecks were then to
> figure out how to improve them.
>
> It generated a lot of code, much of it hideous.

This made me scared to look at the patches originally, and I held off
in fear that the patches would be horrible and this build time
improvement would be hugely controversial garbage code.

But:

> I extensively audited and rewrote a lot of it, and heavily edited commit
> messages, the cover letter and comments.

None of the patches look at all horrible to me. You clearly excised
the hideous parts. All of my reactions were of the type "this could
probably be taken _further_" rather than me throwing my hands up in
disgust.

So the Rust parallelism thing clearly isn't ready based on feedback
from that quarter, but the rest looked safe and innocuous. I'm all for
merging this, although it should obviously go in through the right
channels. Mostly the kbuild tree, although some of it clearly would be
other cases - the objtool change in particular is fairly substantial
and needsobjtool people to approve. It didn't look all that
contentious, but still..

Anyway, I'd love for this all to go in. Build times are a pet peeve of mine.

              Linus
