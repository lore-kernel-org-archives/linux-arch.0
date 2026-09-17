Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB13B1ED7
	for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665350; cv=none; b=FhVDs5TTkxUz6KCqaaaHQgdh0uoZfRti6bganPBYvOZZqVWjwSCfedRkCWfFPevYfKRi3B1LKAcnBuxV+2P0Esx34kDljVigqFcrH7wSYoKYb9I1R+J/gDjnlI5RCi/4NwdRgpJAoLyTJlpUJ3uns0cr6oxQMsgbdoAEu5EaSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665350; c=relaxed/simple;
	bh=biPMv+ofFeAlNkpuoiheHfcM5OSqeT3TWtGH022bAOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7Qp8nYtu3u9JXwr8qFfxnMKs97s+JNgFTDCYjtZZascV9rum6Hx16llDH8UStwUPldhY0oHBj9Ljlk6oP0SU/TphAxVbNY8NRkoeQcKJzrGaTu5qrxjzgQBSjMlN2Y85XWXc/JK6Jy0YXLgiBfYT+C+LZ+RaH8GnWkYLRmJXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RL5BQQli; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RL5BQQli"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so1642355a12.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2026 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789665346; x=1790270146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCKe0geuwZYO+S2TeH6s+a22CWM7gde8UuWVtmH3l0g=;
        b=RL5BQQliIF6y6stZxfuICTk/2cwlMYOcZ2XemZH/TQgbMBM/j/cQzYwfNARVtRNm7A
         m3zwGomz09QEL4X+FrQoEim3Do5DM7Vl+s4vfdLwgdA/3Drin4ygrLBLEW1R+WoBbGnq
         lO6XZsCOdTwi4tpezU8ZFfTq5CWxfa3QpmhwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665346; x=1790270146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCKe0geuwZYO+S2TeH6s+a22CWM7gde8UuWVtmH3l0g=;
        b=nxNj1NAFH+ke97L5WKZZKcxlzfX3ugCv1QPQu+SQ0HI0Ybca6bukYUEzK576HQdnq8
         KwOrZfvN8QeFYdEyAmjGZaNUtNWvYkhS94D8gAMPx6BkLogml8HY1C98IYjYNMzHAaka
         dg6Ksd2lAh+EdRQaqvTr/L0Zq//l/PQ/C4QE86fXnT6riDyhwkFH0WvpN5kd84458d2T
         uByd86gSMdW6O7PLXObq3vH15//e1/b4avKtncdSzklSdbLD0lvb+PemcP7D5t+mQOF1
         rVbAE6ExHJvhfI64tRmpCG1vv63yuLa9UeG5yMkTXU61UVaoaZpFYPt06TCrCrgGrSXJ
         diXA==
X-Forwarded-Encrypted: i=1; AKwUvByOTV7YKkbY04KZdMU4+DhOkgVg/9BfTCejKkVvAgNG5cusGrXp3bysy1L9NRyQzmHNP9iB7Wd7ljgg@vger.kernel.org
X-Gm-Message-State: AFuF++lvUfnXAG7jwhisypYionK7AY/hTGqXOHhgNzXNEmiTFnCOhqaB
	BDb3xq1l6ktMrp6wE7zrCz6MWIip+zu2SFYimiHLHYU7PBgTJ4i2drZuH9LSuj9wI4sUIW3mWrU
	LhT6t09g=
X-Gm-Gg: AYBFou3NoiFOu9e/A+RpjXLamuMR8VtHSzULA7XbKOGN1xrif6CWG+LKV4SLPEH9GcZ
	u2ta69bVccYEa3nmhXnbommjCeRhiDpmPaXp7mGRXIU+nqEe+fop9YfVCTle7KBRuDRgidg7nGV
	3WIB7jeg6DDrhUqhzKYm658QMPTYcTFF0wg3it7dCoe8RSR/+8X95j/3vJD/VisfHA5ceuX2uLL
	opQeJ64tgWCFlnrasFxuO7l9xnkFLsEdALaGqREWfjIrdxYPjnvyZ8pA+SOIzT4Hxa8kHJ6L3ap
	VD7xvjjYimFed/OlYhdFYuvHi/if3HaPUFUfKlceQX1QU76A9SaVtH8z4v2k7BSwc8OTnCeUpbf
	3MlesRo4U1b7OX3AEcq03M18J/zhIaisR+QtEwzFpCJeIK0RxDc3dQPQgY8ngurGAEbDbuRPLZB
	Z5dz/abMO6iIqojKFqmpxyljNONZVp79GSrBb7ISu1jYFntWlQDz3gD/t7JLdO6qwqZDHRnYTJS
	sw9iD9uk65b+zW4k96r+54e7S/aFc9xQx6pvLR1sizFoXXG7A==
X-Received: by 2002:a17:907:9341:b0:c29:45ad:7afa with SMTP id a640c23a62f3a-c29e4edabe8mr504293866b.0.1789665345942;
        Thu, 17 Sep 2026 10:15:45 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de68fdbcsm309180266b.59.2026.09.17.10.15.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:15:44 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d33431c8so163343966b.2
        for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2026 10:15:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxC1W/dA5CRKlJa4tFTQbDLJ/nE4AleqChEBPbgeyLaaM7tcvAcJ4h21X+edJ7FvQeuNFSSIYkvs8yX@vger.kernel.org
X-Received: by 2002:a17:907:c1f:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c29e5237e9amr501417166b.19.1789665344119; Thu, 17 Sep 2026
 10:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
In-Reply-To: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Sep 2026 10:15:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
X-Gm-Features: AcwNN1VkAmOFPymjE_dcKSWc6Q8Z4LvlbW-9yRGSGQmATfVxYq3jdlUQ82g4gXM
Message-ID: <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] kbuild: significantly speed up kernel builds
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
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 09:06, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
>                 == defconfig FULL build ==
>
>                         before    after     delta
>                       ----------------------------------
> Threadripper, gcc        32.5s    26.3s     -6.1s (-19%)
> Threadripper, clang      34.5s    27.2s     -7.3s (-21%)
> EPYC, gcc                28.7s    20.6s     -8.1s (-28%)
> EPYC, clang              39.8s    32.2s     -7.6s (-19%)
> M2, gcc                 519.3s   512.4s     -6.9s (-1%)
> M2, clang               634.5s   569.4s    -65.1s (-10%)

There's something odd going on with that M2 gcc build. Why is it such
an odd duck?

             Linus
