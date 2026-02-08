Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997234DCFD
	for <linux-arch@vger.kernel.org>; Sun,  8 Feb 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770550938; cv=none; b=DQtlOlZm231lD16+AU5kNeoGmI9ZSnhnGV8B/ObHehBxNBy1+QrVIRkKKEvrmmX3dNFD2EnUz4Bge0B5q88aEPoofc6q/97Te1Cra/GuEnPu6KrRvDIY+EDjimb+fzxog4HDuwjguz0sg/TOvqu9/RffLPZr/8+QRFDsTRjMvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770550938; c=relaxed/simple;
	bh=43UMcNJoXSmxY1vgHCdnrELO2q3MFAXfRQb8FguLSY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ui3qw6LdQTAnIYFVtmFhFRSpgWbKyTzxBca6sMPUh8md3ETuvUQZpDzBBX0extS/j3OGn3eMzvivVbKyf4+c7vZLmJDJgGFRE+EhvUXzRQ/LcMWeQBgdR1ORNim3S99IrfZuvrSyrTtHVeB5511Eip1a4tp/lBmwU2n2/3H0GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivfDcOEV; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivfDcOEV"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43621bf67ceso1243534f8f.2
        for <linux-arch@vger.kernel.org>; Sun, 08 Feb 2026 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770550937; x=1771155737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZO/BuVOhTPW2rgtOqM33Oa1WfaOaUVHLNvTuwhjP8k=;
        b=ivfDcOEV17ujj2+CUoy/iyQIitQYiOJAM03wQzvuBsBn3725uTbFBF3i97hUZzPeF0
         GimlI2LuHxABCIy3OgStHBCeMVdcoVHvCpTStALF1fyQgaZr90dGtYix6uI7zVWQYiEq
         pIb/yoQ7cwP9FR6cJNchn9EHATpAHhkmm3nJ2ocfB+Ua36LwqYPcEzv9GV5NojMAX6u9
         87Z9uG3bu07CSsboyT0W3FamxtvdZ1iCXZVjTVs6nMRnuU8XHJEI8Ng9Z5WnfJjQ2mUq
         PFLVX13OzDXi8SLHcSw4KfXSzyvVEBlT0oCFzBnixkBrlI9zTfA+Hly/L8NlJ9ZTLAf3
         +GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770550937; x=1771155737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZO/BuVOhTPW2rgtOqM33Oa1WfaOaUVHLNvTuwhjP8k=;
        b=wat/is9NX6IpWkP9E03pd9qtRk7TuA4nvJ81E//gsX2NOvtNAZvImEaCJiDfkUgphn
         ZoLjt/dzAswROKbnVLPRbIpRZJ1YML/ILZbYcbvS0JhyVw7L1KWvMJipR3+qsO++Ilk9
         Sv5Zj8B7nUaa3q1qTNd04OyInm7dedQkwAGWy7fOlNBC6E2ZfMPOskvseXGBHNp1JTVO
         sKSNPc6/scNRuzXkNenHlEXF1aUYetFyQv9nRQgsnH+HcHWjPAh9koPGg2vQzyi4Qb/I
         HbL4mmvxZxFRo/sIYq5yge03jWG/O0VlSZvs/2mG3k0Zo5clpZl3aGPi3mu5lw3xzj/q
         jJgA==
X-Forwarded-Encrypted: i=1; AJvYcCU3VukUzrC+jZZYj9fxRlEO/hlR+8QfGU/Ecck3u8Qi3WM/rI0kczChlfXdroma9qIM562BEAiPELUl@vger.kernel.org
X-Gm-Message-State: AOJu0YwAki0kJztey6LmVKbMhdVO9xijxANB+4pIzwF3AJLSiBLKW7Nw
	jsay/uGdovxcLuTfqhR6SZVILJFhHZ8hmjXX8DGl7ZdLM8oJzBsLU6zd
X-Gm-Gg: AZuq6aKA44hv1jUs4FVtuSt6rHvoDqWCeSs5SAxNGfUTGdP6axUco2R7Qhk0o3kFPt8
	0B+GFda+bVXkgvErO/RA0Plc0yjd8Omks1rHcdn//zAdyosafhuBOQHHin3RL3dsgSGLZK7eg53
	yrSZ2m/hVaZ4SnWHna2UagH2/g/OAKYZccnte5HUziDHujsLxVl3Mx+pLzUAg/xQOSA1GdJjIUy
	g0X+1iRux9AQH+y/fp/g3se7QfIBcVI2PEO1BrVEwF4rh+tMUuXswMaN5lcTe3TpPt1X/XZxc/4
	oQiE6BhvSdhed5rhWcf4U+AHJgcTUUWxwEhvthzadRF+fchsPpQ4TcfCjEwsbVVcbnxAE0bUgbg
	rQ3kZaqvLMPAAOjZ139hSkqmqq2iZAu+VEIwMgPNhrXieVRYIMngrL7FgW057VlnR7yYKEFZFyB
	D0UBfNRsjH2jDQGnvnzLLEUG0xCjNsBQjoYlOJR9PCPEwqUEk8bdLK
X-Received: by 2002:a5d:5848:0:b0:437:6b73:ffac with SMTP id ffacd0b85a97d-4376b740555mr1512420f8f.62.1770550936571;
        Sun, 08 Feb 2026 03:42:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa41sm20364309f8f.23.2026.02.08.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:42:16 -0800 (PST)
Date: Sun, 8 Feb 2026 11:42:14 +0000
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
Message-ID: <20260208114214.270b4982@pumpkin>
In-Reply-To: <aYgDlpdXWqYvj3LN@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-11-david.laight.linux@gmail.com>
	<aYgDlpdXWqYvj3LN@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 22:31:34 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Wed, Jan 21, 2026 at 02:57:27PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > The assembler only supports one type of signed integers, so expressions
> > using BITS_PER_LONG (etc) cannot be guaranteed to be correct.
> > 
> > Use ((2 << (h)) - (1 << (l))) for all assembler GENMASK() expansions and
> > add definitions of BIT_Uxx() as (1 << (nr)).
> > 
> > Note that 64bit results are (probably) only correct for 64bit builds
> > and 128bits results will never be valid.  
> 
> And this important note will sink in git history.

At least it isn't only in the email archives.
I can put it in a comment.

> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> This has been discussed in details when those GENMASK_Uxx() were
> introduced. Assembler doesn't support C types, and can't provide any
> guarantees. It may only confuse readers when they see something like
> GENMASK_U8() in the assembler code, and there's nothing on behalf of
> that declaration to enforce the limitation.

It won't be in asm code, the asm code will be expanding a constant
from a C header file.

> That's why we didn't add fake C types support in the assembler. Unless
> we find a way to enforce C types capacity in assembler(s), let's keep
> those macros C-only.

But GENMASK_ULL() was already there and would generate invalid values
(for small values) on 32bit.

The only reason for defining these for assembler is so that .h files
that use the definitions can be used in .S files.
As soon as any of the BIT_Unn() get used the asm code is likely to
try to expand them.

	David

> 
> Thanks,
> Yury

