Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458F3587A1
	for <linux-arch@vger.kernel.org>; Sun,  8 Feb 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770589649; cv=none; b=fWdZaTCQxdjz8oxlmmcFMXHVpSbU1bVnh7ElIFrVZl3aHJ/o/Ui4QBJQ9saxU7MOs1Ctj0ah3HEiafcRUKrNZDZwmmvYOoDjLX7RKD7CM6DOV9vA4Ed1KJnJH/DdRU6dWCPQTEPP4kqikpa35yatu9LVa90DhOPqEheCeXGqRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770589649; c=relaxed/simple;
	bh=JqQfkRKGgXEuMyoMTMD+BHm4yYbh9FilgzrH+YKQPD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3umMd6qbuO0DZXTV2lGaXN7XaVw50l+Xi1dlILWa2eQ1m5N5xrMZjgg5QcVzOf+tW79SnFx8suHQQ44+yyAq4sVkvPgY+FBgtYIc+c0gsQ2YiVYN22SqpyuMWgdYVXw3qkAoXW4NfQ2lhzuQykV+ac43iig+vsmBW6hgd/PnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyqIKqdt; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyqIKqdt"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48336a6e932so5102345e9.3
        for <linux-arch@vger.kernel.org>; Sun, 08 Feb 2026 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770589647; x=1771194447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktWT/NVGItdmNF1PY1FSsYjrY9j/tnKNE9OQGN+tNog=;
        b=PyqIKqdtoWz+HvG5e9EruQe3WTdNfeicea1H3aE+7ZaUNAXj1GDey7S17SxYl52BSU
         MzTq+3frUGAhwoC6cGyDn9EDZx+j4BXSDCEnw41db7pT5taBIAbgVs2/n98luyiXm2m9
         0fNnrqnorzRBZA6q03F64RDCcDyx0M2hiDjO6SMm93eAeDA3DGrem0+rCyHo6qecfxDu
         8Iqtn9rBdEuNUsbeVczR7pGv9JcVbbdkw0IhgxhvpWR2pT3M+mplHyOcnZUdKwhLG8nu
         1nwngPIWWo7jnC+vV9ZcgOGstBLZhPAPe3i0zY8poHBlE/7d6pE2znf8j0r3ZItv07ue
         Nykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770589647; x=1771194447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktWT/NVGItdmNF1PY1FSsYjrY9j/tnKNE9OQGN+tNog=;
        b=sRqA0Tn7Pcy1y8A05fjw4y9hmJ4QxWhHdO6EiK23zQumrq8wzdWjVEwyJFIqUOWKlG
         4eJN0JOV7oZfMSAnOBWYTM4tKWcekzWZBup5u9ajWBEV5W+IY627vD8ovscs59Loc6bO
         YueajlWha09/KWmRyE9cBAAUbhY/JebkD+eEDCkcITySc0ckyW5xFimRrdwVbfgc6dzZ
         bo0IXEYfZQYYBfC1WsF9a5MoqG1BELfXie+RNa/H9R2dqxiU4TWx/I2rqxJS7LCOiGkl
         fFKoSqTM/2/HbZO0LQfOhYuEHy+wmwMux8YzhYqTERNE9RROWaUjrnPwEUxo2tEEmpAT
         WGQw==
X-Forwarded-Encrypted: i=1; AJvYcCWjUr+2yNEJs5EiZwibaCgMpB1gxlmx4Nl1oR3BktSbeJ2aNBttCnw87Wiic2kAgSYAwfrbNNCcm9eq@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiIEbvGO6Gqfigc98jjuL/DhjYcj+edOq3klaXEWL1mRmw7cH
	p3qtDtafk7myTCA5KUEWuOsIhHJy2xU6VkbpEfo0MjGyo14UrJETrbjX
X-Gm-Gg: AZuq6aJm0MB1oFlzkkHESrz9pvU02r/BycS4sF4TU1Vg4XZkDwuIgAfpa9sPo1jygHX
	JBd36NP/bJgFSZvnBaDqxK+5R/w4mnYAkDIKp3xUT8qOr0n57ZJd+TCjmei3vmRx7QzXfcyCqa7
	zARy0NXQBZOWb9GKkprqIh4mQnajM+26pTt4vcRfGxOICF++AMdngdFKZ7YDEcZb4+xODlPy9YO
	HHJ9+FRfUfBy0yGaIoiAandvx5a2U1QEjWf70fLEP+k1q3jAlFQAQ6NUUnC1WegsHO4VynO5tfp
	KWQ1dw6WXRpdpdjN3cP5HMxw9Ugv33+7OL7v7bl6M3qiWjoqbl29Cr+5DtHXay7iXPRonlEjMUx
	W8GhQrepbFlDBCasDQig5+mRQwWgX7ydpiyAfMSqirvECtTc85Z7LqXdIm2Nb4RvpKYRT3QK9eI
	Tmc1OHUGUUVk80d9xfAykVb8sohdbAXcNaT+ePJFGCHMEcoG5gzdvCOF6qUOChRn0=
X-Received: by 2002:a05:600c:4745:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-483201e4b18mr150839385e9.16.1770589646663;
        Sun, 08 Feb 2026 14:27:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437699bc1cdsm7935312f8f.7.2026.02.08.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:27:26 -0800 (PST)
Date: Sun, 8 Feb 2026 22:27:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Jani
 Nikula <jani.nikula@intel.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 10/14] bits: Fix assmebler expansions of
 GENMASK_Uxx() and BIT_Uxx()
Message-ID: <20260208222724.6e2dd07e@pumpkin>
In-Reply-To: <aYj-LdTWwvGLJP4O@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-11-david.laight.linux@gmail.com>
	<aYgDlpdXWqYvj3LN@yury>
	<20260208114214.270b4982@pumpkin>
	<aYj-LdTWwvGLJP4O@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Feb 2026 16:20:45 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Sun, Feb 08, 2026 at 11:42:14AM +0000, David Laight wrote:
> > On Sat, 7 Feb 2026 22:31:34 -0500
> > Yury Norov <ynorov@nvidia.com> wrote:
> >   
> > > On Wed, Jan 21, 2026 at 02:57:27PM +0000, david.laight.linux@gmail.com wrote:  
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > > 
> > > > The assembler only supports one type of signed integers, so expressions
> > > > using BITS_PER_LONG (etc) cannot be guaranteed to be correct.
> > > > 
> > > > Use ((2 << (h)) - (1 << (l))) for all assembler GENMASK() expansions and
> > > > add definitions of BIT_Uxx() as (1 << (nr)).
> > > > 
> > > > Note that 64bit results are (probably) only correct for 64bit builds
> > > > and 128bits results will never be valid.    
> > > 
> > > And this important note will sink in git history.  
> > 
> > At least it isn't only in the email archives.
> > I can put it in a comment.
> >   
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>    
> > > 
> > > This has been discussed in details when those GENMASK_Uxx() were
> > > introduced. Assembler doesn't support C types, and can't provide any
> > > guarantees. It may only confuse readers when they see something like
> > > GENMASK_U8() in the assembler code, and there's nothing on behalf of
> > > that declaration to enforce the limitation.  
> > 
> > It won't be in asm code, the asm code will be expanding a constant
> > from a C header file.  
> 
> It can be included and preprocessed well in any .S file:
> 
> #define GENMASK_TYPE(t, h,l) ((2 << (h)) - (1 << (l)))
> #define GENMASK(h, l) GENMASK_TYPE(unsigned long, (h), (l))
> 
>     .section .rodata
> fmt:
>     .string "GENMASK(63,60) = 0x%016llx\n"
> 
>     .text
>     .globl main
>     .type main, @function
> 
> main:
>     push    %rbp
>     mov     %rsp, %rbp
> 
>     lea     fmt(%rip), %rdi
>     mov     $GENMASK(63,60), %rsi
>     xor     %rax, %rax
>     call    printf@PLT
> 
>     mov     $0, %eax
>     pop     %rbp
>     ret
> 
> In C this doesn't work at all as it throws overflow. It doesn't even
> work in asm volatile section.

Indeed - that I'm not trying to use that expression in C.
Although it will work for non-constants.
For constants you'd have to use ((1 << hi) - 1) * 2) + 1.
While I'm pretty sure the compiler will convert it to the former, both
generate worse code in some corner cases.

The issue at the moment is that you get these definitions from uapi/linux/bits.h

#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))

For .S files both _UL() and _ULL() are null, so these are:

#define __GENMASK(h, l) (((~0) << (l)) & (~0 >> (__BITS_PER_LONG - 1 - (h))))
#define __GENMASK_ULL(h, l) (((~0) << (l)) & (~0 >> (__BITS_PER_LONG_LONG - 1 - (h))))

Which makes them identical except for the two constants.
On 32bit builds the two constants are different which means that while __GENMASK(5, 2)
and __GENMASK_ULL(5,2) should have the same value they may not (depending exactly
how the assembler evaluates constant expressions).
Assuming that either __BITS_PER_LONG or __BITS_PER_LONG_LONG has anything to do
with the number of bits in the assembler's expression evaluator doesn't seem
right at all.

	David

>  
> > > That's why we didn't add fake C types support in the assembler. Unless
> > > we find a way to enforce C types capacity in assembler(s), let's keep
> > > those macros C-only.  
> > 
> > But GENMASK_ULL() was already there and would generate invalid values
> > (for small values) on 32bit.  
> 
> You continuously repeat that GENMASK_ULL() generates wrong values, but
> never submitted a fix.
> 
> Anyways, if you think GENMASK_ULL() is not needed in assembler, it's
> even harder to advocate fixed-type flavors.
> 
> > The only reason for defining these for assembler is so that .h files
> > that use the definitions can be used in .S files.
> > As soon as any of the BIT_Unn() get used the asm code is likely to
> > try to expand them.  
> 
> The only reason for fixed-type GENMASK() and BIT() is strict
> parameters checking. This is not possible in assembler.
> 
> Thanks,
> Yury

