Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CB56852B
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964539; cv=none; b=nGCV+w8SgufNZbOjjMhFt3n22YMm+VZB4N8CfVy8tYsAHuek8RjVQBJqKnW7R5ewZZ1CRnxuWoqHx6Z7z2uCbgRBHrF07x+I4C09Xe2Q49QQClTgEEmIl4ymTeAjDCd37AyP3YRI8R3pUj3Shruc6/ikZpYoPXqf0X1/OmcoRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964539; c=relaxed/simple;
	bh=C8wlVunptoThlz2K9sFX5JRkjNXNpZt+isVUJZEm52E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI1sf4TpCqN6nzG8E6icGeQzSu7RWpzU1EVvt+D8lYzzzs8LpT3Rdq6ku1M8vDJqRLoGwosxohvv1IjC63wSnPbC1Gc5UBnzNzCELkHCKf//tzaBX2D4qBCLHxItE9z9NMfcwdEPD1CGO56lrZuramMNnyaHIgNxzGXdyOq2kHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UNmRTIL6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UNmRTIL6"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2940d16190so56385066b.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788964536; x=1789569336; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tG9J5Co/VVYH+Cridb4B9lUnRMf0qj5TUZQIt0oEj84=;
        b=UNmRTIL6mZKPkaFrR5tBY96hQrHbkjAEPvpUDTOaqISVDpbPjzl4fHcEF5CNzZc2tm
         lrRybIEeqoqmCa9wiFa2evcGsby7e4fxrvtr+Uv4e8/BGjOj4/1MJKkLzMFv5N7wdRZ9
         /txoOJVL51XNYVhqP7qU5OgyH2OpK0gTecXIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964536; x=1789569336;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tG9J5Co/VVYH+Cridb4B9lUnRMf0qj5TUZQIt0oEj84=;
        b=Sscqe4x5SSUCIisojuiHHocbtwu+MrJD/5UfShSM8PYcjhfnOBGP2VsW3UI7tobH8s
         q0EaszHAmKzf0IAaUtAc9XlFcHy3V27Odh4U4tzGyLLDk1PLzU1gaJJZq3zbTw5nx6vK
         55i/q8KrDf1ggjMFy+XAF0fD4jKHUVfylMQZnkZ/EGuYbAxftjXS1V3nz0MTuFxGeKGi
         +ecuxv04ugty3xyae6SkUSX1UOr4PdBLLlkSWDC347YbfdtoIN22ZFyMK7KZ4XTHma70
         oMHY9kjVWxL4apgPdUKG5cnsYOcQon9iFEaxuymNcUefW0dyH1pXCYbhSHxC4YYJmKba
         dkTg==
X-Forwarded-Encrypted: i=1; AKwUvBwLMZvrPxDWrle7gvhDrJ1ajYWQC40c4GoF1A/YMHsQ45GJiIs6so3KzESvSJmDaOo8YlqGVVF/ZvrU@vger.kernel.org
X-Gm-Message-State: AFuF++lZMAe9GOLD58OEo3sqm6aE/0iEhg+1zxrMi0niK7sXACLcPAPC
	5DyBmbbQsgj5bEUMpcqGR/cQFMUzAeJcvsi2l1oM5ZgP/dZ+L3r9Z7w+Ld2ZTECZ9E70/4Jxprs
	WnlXnDXQ=
X-Gm-Gg: AYBFou3A7IXvgPUaAjnPxVmLdGqtuFhS6PTHJugNvYJNJu8pi5ahHR1mYopLkBPBRJs
	hUQ64QVenbvTA2vsalRAhaUQk75eOQ1DuQp30v30spR2+DNgRlh5JYz+J/fakIZhqGE9qd7LPst
	X4Zcmnm+i2276KGKlv/KN3K3GN+/cnjG48j/bhBm8oX7hwtEU6pXhEDrbRdY6HqbWXU1+uX6Wyc
	2VzYfs1QviB0VdldcNGsm0ZTmIcm7y91nR8IzTG3YfMnjRzgFeYL8OZEfrnDQS79EEA8pYsHXFw
	RLhC5risQ7EqqEtePIj02CjEb5fnUIMqAArAvz1ZYFaLv1jc26xT7uq2B/Soz+DLBr6MpDDtX5d
	gu+VZaaSq836spfJaM5aqRq8ZKqjBLDHojRvjV96QSKkBq5omyc4teF1arnGdsM4tKyDQHqwRGT
	Csg5ewxUfyqg4T99VHG/UAo+hVAay9R+nWE+C2ztAzXBPou6V9efnnUkDpm8yIVrysfZ6EapKRE
	hYTiLVD8xxsYUQAIVrwW0ZIiSqnOluqjavT5TEBp2k6bQPgJA==
X-Received: by 2002:a17:907:c017:b0:c25:8fdf:5d with SMTP id a640c23a62f3a-c260c99299emr1407259066b.13.1788964536135;
        Wed, 09 Sep 2026 07:35:36 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b7dsm782417366b.21.2026.09.09.07.35.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 07:35:34 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso8688057a12.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 07:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy49bi6gObAfvrtnK60dDWzbMoD7cIM/N1qnnqzlWqKSeWojr6jhduU4YFk+F/A5TyhXx0fKjUWBBHd@vger.kernel.org
X-Received: by 2002:a05:6402:208a:b0:6a7:ee56:615d with SMTP id
 4fb4d7f45d1cf-6a7ee5662fbmr12667373a12.31.1788964533277; Wed, 09 Sep 2026
 07:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org> <20260908-build-speedup-v1-4-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-4-5dc1ac01672d@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Sep 2026 07:35:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgryL8XqjFcO=EQwKdqNn51BANiv16QiqYKCUdXxDQBmg@mail.gmail.com>
X-Gm-Features: AcwNN1VOdEagBQA5D63IF5vfBaLV4II6ehpTsThafIib6q5kHaeURBrIxknkBpc
Message-ID: <CAHk-=wgryL8XqjFcO=EQwKdqNn51BANiv16QiqYKCUdXxDQBmg@mail.gmail.com>
Subject: Re: [PATCH 04/23] kallsyms: output binary data to speed output and
 kallsyms assembly
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

I'm finally going through this series, because I do care about build
speed, so I love the concept.

However, I haven't actually applied it and tried it, I'm just reading
the patches.

And this one triggered something:

On Tue, 8 Sept 2026 at 13:56, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> kallsyms generates an assembly file that consists mostly of .byte entries
> containing compressed names, token strings and name-sorted sequence
> numbers.
>
> For an x86-64 build with 158k symbols that is a 37 MiB .S file which takes
> 0.57s to assemble each of the two to three times it is built over a kernel
> build.

It strikes me that this is clearly a bit faster, but it still seems to
be not really fixing the underlying silliness of that code.

Wouldn't it be much better to actually create an object file directly?
Afaik, the *only* think we ever do with that kallsyms-generated file
is to immediately assemble it into an object file, because the actual
asm file is useless to anybody.

And we already require libelf as part of the build, and we already
kind of do things like that with gendwarfksyms.

Don't get my wrong: I think going through an asm file was very much
the right thing originally: not every architecture used ELF in the
first place, and when scripting things like this the current situation
makes 100% sense.

And no sane human wants to deal with this kind of grotty detail and
spend the effort on writing an ELF file writer.

But when there's a LLM that was used to find these things and help fix
them up, and it's something this mechanical and the result really
isn't ever human-readable and never has been, I feel like the obvious
step would be to just ask the little helper bot to switch the whole
kallsyms to using libelf-devel and writing an object file directly.

I don't think anybody has any deep emotional ties to the current
kallsyms code and that horrific step of the kernel build, do they?

               Linus
