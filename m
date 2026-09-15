Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558C43991E
	for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471808; cv=none; b=a5iWbkBVItAPxkun7sZikmyNmSgkLuyvnNg4bv1G9v3HoFz5Ul7TYDFHH7s/KsUjDOYzgsb7/oNPhrsuHpPH8P66xt2LlkQzQ3X4ISC1z7pZmEIYJzjwj9jHjYyDZbLT7NxVS1kTdj8itGP0P1lXrKm2SN+Wdr21R6+Dh6O8m9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471808; c=relaxed/simple;
	bh=APKTuDGLjMsk92bnnkXJ0rRlkzi8IPJqTj2KURSVBU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVFZ2N5dk1BE0n+oamk4H6EBE0jy+tAWQmK2rcO1fD6lsIFyVxpdQByV2OCyEI5dhdLNswj6mZmtZNDuns9zj7cJZdj8jjZ+b2KJlOQH+zUuoEcdi5uUxPrMAlDwPcmMtAWzuds0RcGf5buMsCBSvn61u2vVDneOUiApq4Orz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfmW0HZG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfmW0HZG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495437bb891so5802115e9.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471803; x=1790076603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dGOErKOPioTgO3v0/s/JdPfHHqPEsYrQAaTIvwRdmxw=;
        b=QfmW0HZGIofUmjnkWGL2TIVkFUxUuxZhOFjQCkuHPy/WVprMzaImb5IXvjMXS/wCGL
         uT++ASkA8Nzq8SsnOaIO0UueO+47EwRvo5F5Q2iv3015O88zbQeDLcIPKzLSIcrifmLG
         RVNd4ny1+Cy+QmrUym6h9ZUTtl8MXydeYJyp4q1FqUlyFJQXlfCStv7fqRBhRq+m6drU
         2MOKbXWfrGw4Cn3wFCJXObY+cq2LnTd2bB/lN0FlToSkrHYz2p1ue1fBhw1OzHr5z4oA
         4tpDK1zE80uk+drClpQQOLiuwshUO/kVmbzbC0pFA/whcZ8lOZHZwDWrcDKDnhhs+UpU
         /o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471803; x=1790076603;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dGOErKOPioTgO3v0/s/JdPfHHqPEsYrQAaTIvwRdmxw=;
        b=kHyuVnL3UHWC2WUyqhrxQ4Rch1x+2bQ0Tf6M7ttBNUtX73eted+OgpBUZakzBl+Yr+
         yelXTdt0xH6QCKjdUFAObqIDlPZtBXrJGZaY3PCm3+qvlVzq9m0Vksol4YiavKRHgw88
         tKwvsOSmDSc+/k1eoPJNX7Ka+ZJrBIpvnAIYlONPh0hsIuMOKMjwTOJwsW5yurZkJyzq
         JhxotPASWPnYnPuxMY93c+jeQeEyqPSfSLQ2lwMuRSY+OsoCbgVvcifi5Rkm5AC4Vp9k
         DWFtiDluevSk2j1X23QQUZkMw34rfyj7EGgkQIZvZE6jYWhmHyDtD9u9dQF/mHonsxwB
         moXA==
X-Forwarded-Encrypted: i=1; AKwUvBz6rAyGnhvhLNW0yiwcFUwOW8WOJ9PgkyzLmKJBJz3KFlpbgTD8enEIzVoDMgHLQtsTU112T0AWIwwk@vger.kernel.org
X-Gm-Message-State: AFuF++nrQOUraRNyVqAzHENv3mcOMvbuHWZ76jwHcw1ieeBzzC9BalLp
	M+AHCnMNF4rx8rb9maNe3G8CvaAWjzdsqCyg7Ue4jKp+buyMlNVJEjl+
X-Gm-Gg: AYBFou2QkNZsadQ+3NswV3gZ+cLzw+o+q/an3JZ6cT1jj15Om8zkI8EK69QSdZ/oJIi
	DHu39nHzCKq/Cc5k57sMka8xqb/xNe0hKzLd3uAGFVmF50xeTwBPgUNPJSatgdg50N8Lw+lyg/y
	OlaqmwAxUxivmkiQ/XEHLaHzEdZ+UrhLFPntRmPsP8CJ2XMcG+wukrhgcnv+dRWkNWDqXnCNQBj
	XxwGbbFnmAzT0+/aAwf5nR5QJ/8oCk6rpcbkXf+ap48G3T0yI7F53Oo0kEnXrltkCwchklWawSE
	MviMQDwxEmGy2aca/mr8jLEsGZKrpimt/dEr28ityzxzhRSLEi/Cu+YOvg4ixA5VW+hMva1bbzM
	TXvyPpZRx2wEXADvRdXA7WzzLyrrtbzwI3I1QaMSrC1Dc7YLz1IaiRMOuxJSu6HwaqzNLxRJSek
	IpNUhtZ91nHe8aSiwclkAI5SDnRgPniWxtySzpCSL+G3KGGLoSmGdtF/HYjix+mXIS4XsGkdMyO
	3BAe8WO5ltlsjFZ4680BwFmHZenTlyM5/mn
X-Received: by 2002:a05:600c:33a1:b0:49d:28b1:260d with SMTP id 5b1f17b1804b1-49e7d74ce16mr30558965e9.12.1789471802734;
        Tue, 15 Sep 2026 04:30:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm31448164f8f.10.2026.09.15.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:30:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:29:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Alexey
 Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 17/21] objtool: decode instructions and resolve
 branch targets in parallel
Message-ID: <20260915122959.2348bf90@pumpkin>
In-Reply-To: <aqkR9Xqu-0Tem1zm@gremlin>
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
	<20260914-build-speedup-v2-17-39817ec5db23@kernel.org>
	<202609141112.F8983EE9C@keescook>
	<aqkR9Xqu-0Tem1zm@gremlin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 11:09:25 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> > > +static unsigned int decode_threads(unsigned long text_size)
> > > +{
> > > +	const long nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> > > +
> > > +	if (text_size < DECODE_THREADED_MIN_TEXT || nr_cpus < 2)
> > > +		return 1;

The text_size check ought to be before the sysconf() call.

> > > +
> > > +	return min_t(unsigned int, nr_cpus, DECODE_MAX_THREADS);

Why min_t() -  you might as well make nr_cpus 'unsigned int'.

> > > +}  
> >
> > No, anything using _SC_NPROCESSORS_ONLN internally is wrong, whether its
> > pigz or objtool.  
> 
> Why? We shouldn't cap a 4 CPU box to 4 CPUs?

You almost certainly don't want to use more...
(Unless they end up waiting for disk)

> 
> The idea is that the empirically obtained 16 core limit should naturally be
> capped to the number of CPUs.

The 'empirical' limit is very likely to be system dependant.
There might also be situations where you don't want the build to run as fast
as possible because the system is performing other workloads.
(Not to mention if you have had to add tracing to find a bug.)

> 
> I guess in a world where make hands jobs off this could be dropped, though,
> if the complexity there seems worthwhile.

You need to pull tokens out of the make pipe :-)

David

