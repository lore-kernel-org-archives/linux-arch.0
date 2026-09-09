Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307B489897
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966502; cv=none; b=Fy3amJGlpAoxWV+YM/rd2PHx1mGZI+EP2vs843yPHqy/hT+64yRsHbTpDnkdqg2xhQ45mI2EKKhBk5E5xpiOLSLZU1TvJzuObijZGfZl09hT2Fc+cPyS9e/RpJCiX86pWAPlTjCaYqAf8JXM3rcDGEXg8Aem3a6bbTuEPq8jaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966502; c=relaxed/simple;
	bh=qF8PC9Ug90yk/PrOmZBC0YqOzOPUdR+ADtjc56MP5mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STofqZpRPAYJ+HgVzKV1RwdndvmgiiTKIQkjqHpeqPiEhWVnS46w0kYPNFGHuQx0N87cykedbQiVJeVa+Fsfo5+3vJbIgiqbTPZFFA3h3loU03PXQQEQ90hg4wKTlzNe8lPwcuDXuWE/5oM4/af76h+3VUOlJYwuck4VJLjJ8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gzc35VFr; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gzc35VFr"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso490287a12.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788966499; x=1789571299; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9JHU6Yr48iRYl83IyQpODgW1j4SilTECHHS/aRaqSbs=;
        b=Gzc35VFrLq+FZaBP8KUurVqqluJBdaHLwE8piYjHiPcCfwgR+ot5ilA/YwTbkGxZ3d
         Lk+EXdnAUMKq7Ckze7Ngns8UI52vP/RzS8doKp8SrTwCVi7zruRmIZbwGL00oLT1WjrY
         DEUvZmG6ed2LoBwqu2yl6V7SSu+eJ9gRnYPFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966499; x=1789571299;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9JHU6Yr48iRYl83IyQpODgW1j4SilTECHHS/aRaqSbs=;
        b=sgSiYNxT8p6q6Suf1S/syTc8Lp6S+SH2LNa49L0bgNDnYy1GAOeAtq9CNTJc48nJ7b
         dzT3IwgbmG86H2MER4RyAw7KAh3fBQtvnp8IMbLhFtUyk+9CuxFzOjAt3ViZ2XR0bbec
         eGASEMoK5QXxEQ8f3JbRUAIHK+Ba5WXHHBf0hNrkduk69rNyMWsgJSXHDDnXgbqrsDM9
         YnLmchJzNymrCd7KQa0p4LC4pxsuUjhKTOGvscUmzVQvqAvIuCMqfT1XUMKnzbJ6foZX
         vZ7WKrJKlBQ0NiVOoqbKkh7Rh6Z4l+3G7wfDMIEuOin6BDgFAkV8iN+lemc8FWuvbORu
         Dbyg==
X-Forwarded-Encrypted: i=1; AKwUvBzonLjHZC6eHhprNrIc8I9sf2FbHDN+2SmyKbAu5fK5UwN/Nc1x/2aHV1rmlETT2AYS9Iaq0bXHqAUa@vger.kernel.org
X-Gm-Message-State: AFuF++nqGuUSBqpE6tDe+iObzvHd3RDUKUochghZlm+l8lYp1/Yh1PdA
	c3992aX7icMwowhFvuywwMbQmXyr08Vm3Bx1VvAOTjL03haAggPquMbtOrNEBS2Gs0duYh2xStN
	TU4BsTQjw6nt2
X-Gm-Gg: AYBFou3OcEwBhQimx9Mq2v+/AzdmxbngxhBHukCrczWbhIlK+jKDfdaLDWh9I1tA5NK
	UMih8VQyDSkp/4D3ruaGxL+H2G/EJsXqFEBKrvt7WBbmXaqkt2PZ6l1LqI9mKLOPCAvy4hQEKu2
	GIBU1/2NLAGh9fwr0bPlBvblwLbYTejSnLW58KeAa54ZZo0NZk4qLZKr3+4poDc7oDZ0lDN/ItQ
	N0Byw9JPI53YDTsIeOlAomYWIwhjmU1Czl9CjE1CDg8YTphc3O+GDQDpOqlLd00XxN/Nw9wUHog
	53lrpU5lBYDjczckQZr9P9O9JrT6e12uC2yYvyrRXZsQtB3lrfLomS1Yt6MMBr9MH7KSc3lF36f
	lkkvSNO2WOJToQM5ICKnlOeWKwM0tMvDptDulsrz2kBCynMb21+PdDgFI+bNvK5by2iXrruRGlf
	NTdkOpfICF2vHQ8HENRYDCBxeGQ0JeUv2kbEASlTzisDoJACu2lnlBhKbyCkpDQhiYHy5KztJZ9
	JyzURd2xkPLYg6aXJk3dyKE297B5XzKvwOkYbYiE8TAX3o8ahRKmrbRRBlO
X-Received: by 2002:a17:907:c60e:10b0:c29:4415:2ebb with SMTP id a640c23a62f3a-c2944153128mr17245566b.8.1788966015985;
        Wed, 09 Sep 2026 08:00:15 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29411f4db6sm60141166b.27.2026.09.09.08.00.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:00:13 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso13499366b.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:00:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzz/rX53LbX3mOqXXXKALJkCGCMeDC7jr+ps/8bdufrE38BSxSbG8ItKTBjyT/rUBZ9fX4NrSr7lIto@vger.kernel.org
X-Received: by 2002:a17:907:728f:b0:c25:8e4f:6d84 with SMTP id
 a640c23a62f3a-c2941868b12mr66185066b.2.1788966011712; Wed, 09 Sep 2026
 08:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org> <20260908-build-speedup-v1-15-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-15-5dc1ac01672d@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Sep 2026 07:59:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAWpVHmR74jC7sbSJGQEHyaaN0awNfSz_SjPv3VGSYYA@mail.gmail.com>
X-Gm-Features: AcwNN1XmVo334b1UP-lcj3CPx7zvteJ2HddEJqKkfbem-zQh2qUu9HycJHabLtk
Message-ID: <CAHk-=wgAWpVHmR74jC7sbSJGQEHyaaN0awNfSz_SjPv3VGSYYA@mail.gmail.com>
Subject: Re: [PATCH 15/23] modpost: emit module descriptors as assembly
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

On Tue, 8 Sept 2026 at 13:58, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> modpost generates a descriptor for every module in the form of a
> <module>.mod.c file with .modinfo strings, the __this_module descriptor,
> exported symbol tables and (with CONFIG_MODVERSIONS set), the CRC of
> imported symbols.
>
> These files are compiled like any other kernel C file with all of the
> -include preamble, as well as including linux/module.h, header dependencies
> generated by fixdep of a few hundred headers, an objtool run and if LTO is
> being performed, a link is performed to generate native code.

This kind of triggers the same reaction as the kallsyms code: I think
not including <linux/module.h> is probably the biggest win in this
all, and precomputing the offsets of the (few) structures that modpost
uses then makes the whole end result fairly trivial in raw asm.

Fine.

BUT.

You end up with things like this instead:

> diff --git a/scripts/mod/module-offsets.c b/scripts/mod/module-offsets.c

where it generates a header file for those asm scripts so that the asm
generation can do things like

        buf_printf(buf, "\t.size __this_module, %d\n",
MOD_SIZEOF_struct_module);

etc.

But I - again - get the feeling that this is all going through AS as a
silly way to generate an object file, and that there really isn't any
obvious advantage to that side quest.

Becuase no human ever wants to see that asm file, and it's no more
legible than generating the object file directly would have been.

So I get the feeling that it would again be more natural to just
generate the object file directly when all those files really end up
being are a few symbol definitions and a couple of fixed structures
(is there anything but the magic "__this_module" thing and the modinfo
unique ID thing?)

And again - I feel like nobody sane would want to write that code. I
certainly don't. But if this was at least partly automated anyway,
going that extra step might not be all that horrific.

I'll also be honest: part of why I do these suggestions is that I do
think it would be faster to skip the intermediate assembler step, but
a big part of it is that I don't love the random turds our build
creates. Getting rid of the *.mod.c files would be a cleanup of our
strange build.

             Linus
