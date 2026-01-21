Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86540330B12
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022896; cv=none; b=U/mROronkhurfDFF0jUnmFj3Ibs8dsRqNAid+ZqVjwOy9DOz/zOqaaFAb5sCCGyfRlQSjo7KMzaFzPuI0uVmyqB76TLjeWagEHgaRtb6aU5++6rmLGX0HVRv7CuRkA+JB5PUd1xcAc8QQB96DGrG5E7IFO5uXBeTtPZRyM7dJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022896; c=relaxed/simple;
	bh=aJRtysccswB3GmdDSce+lpuj01tU0vpN4koKSrA7CWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/YiVk+lXe/EGrhIznsnVigop0pE6Tip//fM7SzqqQfeVrU1Fot2WcKOBVG12ajfgisMNqZx4BnXlAEiM8k0p0mLZq8NcDlvHwnSCxR1lm2T9dJPU9h/A4qcDp3Q7UtesnVKFn7u4BKZIb0KeBZl2+2EgVCxKxN2v84sxgN39bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDFbEUAC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDFbEUAC"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso144744e87.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 11:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022892; x=1769627692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr+UIc7zW1MlTBTbOjASE/j1Va3VjetLWpvwAjcFB+o=;
        b=ZDFbEUACEYJHsPYhert9ZIf4oguZ2nqxMwPYd6FEIKEZgzC7q8TCfx0Jz/yv3SoNed
         f4gtfxGpi80MeuyfQ1uAYOsIj1K+crAQqbYTy11qlOQ8u9qG0cqarda9+SyajKS/IgnL
         j7aXZJFo41KL0fhV+QTTRGaHrhIUzcbSq5TVmEt3WnoBo88AZacSN6+VXjZMsg6bj6iO
         x7GtZ+HgwBHD9fQdFz7XQgOfHaf0w88wz7rkNOt4kY2IxdhkHHW1Y5Nn2Gu1mQppMnmr
         0gyDUxZFgRX2Qts1cRUSkMbwhNw2ruH/+ZrvS+N/xp+YHxYjPXCIaulkzhopAMRSYqjV
         2W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022892; x=1769627692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vr+UIc7zW1MlTBTbOjASE/j1Va3VjetLWpvwAjcFB+o=;
        b=Q6id74wcKdMDb44XmBy0rQg51JqyriB3lFRKHuEOwBXHpM4/oiBuaYdk9kxdaE8S5j
         MLrQGfV2nCti8nL4UEgMigvv/BWIMl0qom5tHxsFRbzzQ1f+HFWNciMjTrcQF1xcy2At
         FOe/KPuNeDYd8Pa93nGiDfa9qW4NYEaQIELmGsYz/qbkCPcDvsrLJBUnjSWyNBvlYYjM
         zIAQuzGWBAJ1XFJa1F6Vmlb0aYSgYyU6nHxzxhcjW/HNZVxtr2pXKAb+4DGiABiBeXPV
         y+bRCkMIleOzryzLHBlN7UyMvMqLHlg0kKi+w2w6OF93Gv3ZYR0uqHa454vSuNHf8Fsv
         5KJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5dxNpnzmznAEP/zUiV2KNHbCTrscElzL1CCUu0BcFMbwHDK8fxIvCj7RTbelhiR8jGhIYYpTrEdu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4eRJfrlzHjigf3VYo7NMp12fTb7RjQnJkZgOHk2kQBbhQYMn
	lZRge4YUSWjeCIv+bEg0Uv0hIdqHqc4VKc38zJQ1ruJIHPs3rtlbUdON
X-Gm-Gg: AZuq6aIO2ktvQV9vlyOQlbOE/Z8Hm4sXOFJcAN89fcMcR0leN0IUWKlQwnfZGLIo9yi
	djGAVsQ7vf+dJOZZQUgOOLYkVqlI7YnIg8XDXb9hzCWZhrfb830VzpLfy4EQ0PD6iU0Tyy5ebCX
	e6/hzCFLkTRU5Mn+FYN2/A+oGmbhr6PCmNybXTFNOVDeACMxiUwQgiNax6rdnp3a6znS7JzYSpN
	n93LuoO04toj8R2LihYxJ1EX9u+WkAhWuugFCRZY/E81pBBFnZHfkS+b6++RtszRvFF0dNr8PRG
	KNRodPDdW+E1l9/16yYhOtvkQ5tNXLiF3BolV6BBAWWKbWmIza9y+E+LZ6s5iOK/XV/jKJlIHNF
	ZnLMu3De5lXXvAbI5y7is01/IX3QBfiBVVFKWXVDYCZi4Bg6yMQ89HdMWTugpdAhyXqfoG1lr5J
	Y8ERIeOBHoA/bZ+LEGvgSf/oaUoByXg3szVoYKwKlEZagPpOsxo5Tk
X-Received: by 2002:a05:6512:2c8b:b0:59d:d09d:95c6 with SMTP id 2adb3069b0e04-59dd09d96bdmr1105271e87.15.1769022891988;
        Wed, 21 Jan 2026 11:14:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf34d379sm4893436e87.23.2026.01.21.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:14:51 -0800 (PST)
Date: Wed, 21 Jan 2026 19:14:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Jani
 Nikula <jani.nikula@intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <20260121191448.1dc59684@pumpkin>
In-Reply-To: <1ed83fd2-575b-4b22-9a01-b3a2110af78f@kernel.org>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-12-david.laight.linux@gmail.com>
	<1ed83fd2-575b-4b22-9a01-b3a2110af78f@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 19:43:07 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> On 21/01/2026 at 15:57, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > The current checks in GENMASK/BIT (eg reversed high/low) only work
> > for 'integer constant expressions' not 'compile-time constants'.
> > This is true for const_true() and -Wshift-count-overflow/negative.
> > While compile-time constants may be unusual, they can happen through
> > function inlining.  
> 
> Did those new checks actually found any real problem in the code? This
> adds a lot of complexity so I am not sure whether this is a winning
> trade-off.

Not in an x86-64 allmodconfig build.
They might in a 32bit one where there have definitely been issues.

> 
> > This isn't too bad with gcc, but if clang detects a negative/over-large
> > shift it treats it as 'undefined behaviour' and silently discards all
> > code that would use the result, so:
> > int f(u32 x) {int n = 32; return x >> n; }
> > generates a function that just contains a 'return' instruction.
> > If 'n' was a variable that happened to be 32, most modern cpu mask
> > the count - so would return 'x', some might return 0.  
> 
> But then, you only solve that shift problem for GENMASK() and
> BIT(). Any other usage of the left/right shifts are not diagnosed
> unless your check get copy pasted all over the place.
> 
> I think that such a check belongs to a static analyzer. Speaking of
> which:
> 
> 	$ cat test.c
> 	typedef unsigned int u32;
> 	static int f(u32 x) {int n = 32; return x >> n; }
> 
> 	$ sparse test.c
> 	test.c:2:46: warning: shift too big (32) for type unsigned int$ cat test.c
> 
> So here, I would rather keep relying on sparse rather that introducing
> the W=c logic and all that macro complexity.

I suspect the compiler test will find more than sparse.
I liked getting that to work, but maybe it is OTT.

But the W=c is more generally useful.
As well as removing all the compile-time tests from GENMASK() and
(in another patch FIELD_PREP()) which really do bloat the .i file,
I'd like to add some new tests to min/max/clamp to try to get rid
of the more dodgy (and likely buggy) cases without breaking
everyone's build - just failing the W=1 builds is better.
Using a separate flag means you can use W=ce to stop the build,
doing a W=1e build is hopeless.

	David

> 
> 
> Yours sincerely,
> Vincent Mailhol

