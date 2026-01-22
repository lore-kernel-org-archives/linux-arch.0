Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E834EEFD
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093762; cv=none; b=cs0eh08hIIgEGMfRIUgtOlon6Vn8mTguhB8hOZXZFP6gPypoHud7EwUUdeMQqhcJp4KwHat+LfIsHoWlHk5k8544dalHou3r5ltbuix+HPaN6VwwikZ9sRRNm5rLTtj94q0gRD7RfS1o5OyybKkrZRryhicvy5Tm07fQNZ902hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093762; c=relaxed/simple;
	bh=VuqGJIVM8VcpIVsws5L0tiI/QL70lNQvuGx5zIlxuyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpMm4JlknLnMaFdbbsW2JFDaWuCAJ6LJAlQdmq+mHcGJOKb073hUeZL6YRmKHuHcyVdpX7by9J0EOnWtGSmGP9sBF1omBBO+YyYv4jEIkcah3rm9uSXBe7mZXeg2aS4DkQ6JuVP9CCEKARij7gGG8aZ6BJSym3dRBH0f3LI5+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1qNhjLf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1qNhjLf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so975830f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769093759; x=1769698559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Z3xY5BPN6XAwZM/W6drGSAohVogKjxUvJh+CCUHDg=;
        b=M1qNhjLfikF6MgkY9EQrLEppXqw90M8+qUZTOUUqXo9bHoZSfxQ6KzfMmF0EZz6sXz
         yHoI+f6aDal3utlEvEq4PbEKmjamFtJqNibAkXkBHDsVpqlIw1lFMLD9cT8KGYB5QnYh
         Bn0hJKVAJyj7ytsJSHLgPahB+sAxjR7o9OXR5T4aW/pfRLkMNhE8ABINjQ+/3rFFC8Gd
         89Wdxk2s9l0LUk0l/ghFwa5yIvRglhXtmeooDGs7cMwSJz9f6NvoRAflmZ9oSEeiSz6a
         xjN7IM5PUMJHpBUfOBQ/4PVfAMlXB8faooMP/4jwrNj9J07Qdgv3LA1xJaLSV3sWZgKo
         yxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093759; x=1769698559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39Z3xY5BPN6XAwZM/W6drGSAohVogKjxUvJh+CCUHDg=;
        b=cChGE/rEZ8IQQQMKBX/yipKBlCjD8TwL2UBeBRCY6igm4AsqTehOv80FA8iOPaiDml
         GJPirbWae7DCbpcabiIpG9A/xPGADD+eCMYICbewZ3sczgaeLOF8XhtwGmSz/6WfDUy9
         p5xX5VjuuGjwLGOV3B5Xv1eEd/Half/K+ObzILjtkvOZ2qEqNYQ0eiQaEQuH3eGGCTcP
         Ec4CyBRAgLjS80MvL/cuYB985EQMSEh1tgyYwHz4Y/754Vk389oIHcTm5wXJtbbdp//g
         8FY6zTItseoDGiZXfAG3STtsSbXENFui8PBgQRf4SlYL/DDzRD4aNBeeJ7Ya20eKtTgN
         tLyw==
X-Forwarded-Encrypted: i=1; AJvYcCVAMQUxQU15+ojIdrTetlIvgQrsJoo0g1e6HgLqCVO1oA69OYt9r1Z30r6Yhx2aSf20QdbHDP2xYX1/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67NzywsGoOdREopPGQMnoj2gCEmCuSVbTnUTHAOQp2nMy4AGD
	FJFd+wZNOPJ4ggW5vhWOdD2sL4TCAqR5qqKXXl8AlnANiXZqmoeralhW
X-Gm-Gg: AZuq6aJq/zcb3rfXwU6qQ6r7bv1teix10+wJFeFnzbXTmJ2NmPUEBFkJLQuN8AgbwdT
	8i2OfnpwFTkcYg99gpXENAAYafMm+1k0EGrPlCzVB5KWZGSIxvbjuBKinnqLHOkFkg5U6CxYy8w
	pFW0WWGU2txNwK7/hgj/I4/zB5BgOFGhw942Es+Q/fcbgL2XZtICFlPfwPUsaGoQtL491Z3AROD
	9gWkO6L2/DXpJfKvvov3gysYrE8A+iBoEjue6FSVu1NYEiUj/yju14RUxW6f1YpYgkElXMQmvME
	9GOcYt9p7MenGyPNgSwbU4G3qpz2pkBYKfNNjbRDvGSARjOdVM/JThPl7KpT5M17XRSpSG1YOh1
	kmTDogug0du7xY6LXFGc+gloSXY6a258TosDB7zmV2ZpKns76T/D9E3YDtoilIhFhGVGbOJD3DZ
	hL0F4N5uPAmKLteBUEe5eayVLqfwBSShU3QyDztBnZoHFLEvefKRlv
X-Received: by 2002:a5d:584d:0:b0:432:84f9:8bea with SMTP id ffacd0b85a97d-43569bcf38emr33053462f8f.51.1769093758592;
        Thu, 22 Jan 2026 06:55:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm44884589f8f.4.2026.01.22.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:55:58 -0800 (PST)
Date: Thu, 22 Jan 2026 14:55:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, Nathan Chancellor
 <nathan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <20260122145556.7d72f217@pumpkin>
In-Reply-To: <aXIzpC6wpdv47cSH@smile.fi.intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
	<202601221237.soiAkwkN-lkp@intel.com>
	<20260122103337.26473d1c@pumpkin>
	<aXIzpC6wpdv47cSH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 16:26:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
> > On Thu, 22 Jan 2026 12:41:22 +0800
> > kernel test robot <lkp@intel.com> wrote:  
> 
> > > sparse warnings: (new ones prefixed by >>)
> > >    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):  
> > > >> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.    
> > 
> > Can we stop sparse complaining about sizeof(VLA) ?  
> 
> First of all, the LKP should install the fork of sparse by Al Viro. That will
> fix tons of warnings that are related to modules and speed up the process
> itself.
> 

The problem I have is I want to generate a compile time error inside:
	__builtin_choose_expr(__is_constexpr(x), x && error_a(),
		statically_true(y) && error_b());
Neither static_assert() nor a negative bitfield can be used in error_a()
because they are errors when x isn't isn't a 'constexpr',
There is less of a problem for error_b() it can contain a function call,
but can't contain {( ...)}.

One of the compiler complained about sizeof (char [-!!(expr)]) as well.
I'm not sure of anything else that can be use to get an error.
I could use 0 >> -1 but that is only a warning, at least the error message
is related to the bug.

Any other ideas?

	David

