Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C342D97B7
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401649; cv=none; b=heS9z5c+41Nuv4fPQGALyolsBvVIsjHchA6oA1xWGq3TWw/4/96QtDpnRgFBtDmHdUfYXgRPBKUl0HhUv2JxuNkJ1fgLO0I6g8DddC4TmmRFRuG01Sbwie+lg7Hc+oXKeQ3V86oikIs1Aym/McIm2cQZOn2wvL5TK4KdSFVfSd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401649; c=relaxed/simple;
	bh=xMRNGFwT5MG/tN2Z4rVlgZAaGoxD3wGYA7E+SDFQua8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlDhcTapIQ2HBhPVjIjMHQh2yp8i09l1yAfvqpPC7EgepMX8WTQ1+ShzYqnoCSuAusoQ1O9FF7Q6761IbLG8yd2Zifz3wCGvbpsDUeefOLSkDcD45Xd9oPG4apgPIUCk6egDmhv7XHVZuiz+e6FHNItgy/aqYFub1XRnh0kpR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q8KevVrG; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q8KevVrG"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1fso373009266b.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789401645; x=1790006445; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW3GLwaZtw2SQDM2dpduYrEemaWK0EaPlBH9/B8yf6k=;
        b=Q8KevVrGTaYZhxC1WFEuP1Hqi5aZN+3Poe/3plWi7CjH/oZGVhvTNsOTJee43w3LUO
         mmxORcSAoAGJZJQ7wnsyhPRW+BmkA9CZF9M1mkvwNt8cDMDfHWF3gm8RtQIovA0cZICu
         hvJrTmSa81s2U9zqdv0Q4ClnWAEg4tKgsPLVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401645; x=1790006445;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lW3GLwaZtw2SQDM2dpduYrEemaWK0EaPlBH9/B8yf6k=;
        b=h68nFSQV/JZBt7KeoIzbApPuJfrmubNkdm0ISICAV4iT/y+UcLmVBcNWPSlP62dnyf
         A56FfMqZEK3+35wI/zf1xQ50i0rG5cYVmxizwfZolf15NFz52XiDVD5iXalaEEKx+XO2
         cxCA/3EEZRet3i7+G1OnpnotqplGOrKtjaau9xObDDqiPy05FOdcYBrWkSM7pVaAJuft
         I9TIstLMMKrFaE/zGKJy1dGYq1Kwp8uskueyBli49H1mwrXzcM/cc1eW5FUDmqhFgRmY
         WSHwMsTpmKchJaX6NMPzekfIaBMxvMCk5mWl5N2Nmm98bHR6KmxmVW3T2oANpRYbYzBX
         cVpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJqRJZWh/V3da3R/cHS4Xk9VLYMnJCH6TBUNd1kImGyL9R6hQNEWNlqTaz3HdSizeaOrrMGA4xQq2z@vger.kernel.org
X-Gm-Message-State: AFuF++niPCloLKtTyxQtegRBvvjG24sZ596lhLfY6ljlKvBFX3lmwiTf
	uTIc+CLfaGRzM44/d1lcCZEz3ZlKEJNEoFcveryp8vL5H4EpQeDfleAhwsrTjuAgl7UIwH/clfg
	3SwjAnUE=
X-Gm-Gg: AYBFou1wWlQEy2fb3aLXRJX/VZ46xy4joycmIDAMIXmG5Xa4ql4SqlQizb3Z57on6DC
	lD2g6Gr/6SSXh2ry3ji/5A09mApo3hoLj9yxl0V5Oq3wz4ZjtYnrd+aSdDG3axaplHgNx/mpR80
	mPyMs/96uM9fBQhvnfmnfccnN11tuHmAOuJwm7SIyH+qm/Cz43L1q1JmMkKQLFM3e9Xe1DlE5a8
	XOJx16rJwLbNFm0uhst8nb+Twa27S4NU2xpxqEOB1FP77WsmYJ3CfOCIczQxuCIRNBBDb7BaILa
	gfegjlNmc46gRPjbml3RBpN/U9hsBIgsZOqMMydhv4ZicJ3aD+pcuxD/s3WhwuovMEsCwAfGfNv
	RTxPMl7wQJuSLywSDwA8KciHMTJrww9PNf1m43zUkbJqhB4G0PwByL/d7hEONvj/HBEAknuPEGb
	VS+LrlJFZ7WP/9rIMRwL9Vw3q/erbDbr37YSnV0wJVYVnd9rF5yNTtTTjxRc5o8iyxBUhRDMniZ
	FubnfKWKA8npsIRwggU+VHTXLu23IcoAf/CRX852F4ZLE9AbW/JZgEwIVLK
X-Received: by 2002:a17:907:3c94:b0:c25:c979:e76a with SMTP id a640c23a62f3a-c29b8767641mr399686466b.22.1789401645434;
        Mon, 14 Sep 2026 09:00:45 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234dcsm462878066b.21.2026.09.14.09.00.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:00:44 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso395313166b.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 09:00:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7g+sI3wGtCnyHeirdrOUbqnRwfzTKYal0nb8Mf+A1w/zfNuGKrB8Mqur0z73w6nCe/E/Jg9NqkrGB@vger.kernel.org
X-Received: by 2002:a17:907:3f9f:b0:c29:444c:8f28 with SMTP id
 a640c23a62f3a-c29b84c2597mr415053566b.5.1789401247404; Mon, 14 Sep 2026
 08:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org> <202609140833.88C0E16E50@keescook>
In-Reply-To: <202609140833.88C0E16E50@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 08:53:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB0X28MNAg71it=1SfFyV7rB+PK3qajpRyWoxXHW81fw@mail.gmail.com>
X-Gm-Features: AcwNN1VyLYI7E7T_24gtwZZHDPdmXi1EUi9s9xthPRH35xQepEwWHVnUZ8r6fdo
Message-ID: <CAHk-=whB0X28MNAg71it=1SfFyV7rB+PK3qajpRyWoxXHW81fw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] kbuild: significantly speed up kernel builds
To: Kees Cook <kees@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
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
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 08:41, Kees Cook <kees@kernel.org> wrote:
>
> One area I think might solved via an LLM is the 3-pass kallsyms stuff.
> If we could get a deterministic kallsyms build in 1 pass, that would be
> very nice. A lot of people have tried, but it has eluded upstreaming.

Even the three-pass one hasn't apparently always been entirely
deterministic. We've had random reports over the years of it failing
in some circumstances.

Maybe we've fixed it all, or maybe the failures just go imperceptibly
rare. Regardless, it has definitely been fragile.

               Linus
