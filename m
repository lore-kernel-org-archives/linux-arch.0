Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D532165EA
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084768; cv=none; b=C3Nm0ratZSHkKAK2askiGIBVPdTS1E8vHDjrs7QCL6KRgWzr9eFuYLDkcLQa6VGtS7RPQEP5B4aT9YBy8cExUAXyUBidq9o6JnTbGDP0+Kz7rhkmBDpCwJv5hny5bGTB5ezY3NWtn3ufF+z5bc3b05itlEUzi+Ie3lb7KWMhBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084768; c=relaxed/simple;
	bh=o1a0s6yqxdzNssBJ8GLz4MYX+xieOSENOccN8XZK4Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZrErnG2Wl6XWThusRTYcS4sQVu56Q+sqjvMei9+IfjJNb1OsbKhfCNiFiqxykAh8aCHvWm1sl2WwOmtij4bt6vfnj1n4MYO6/qqUi+tQDXl73IcVgeONLCl+4GSGie8UYMtrHMMI5RnYRR9+41+jyjL9+qHE02cbe1cPnShsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWKtGnql; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWKtGnql"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1528608a12.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769084763; x=1769689563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvVMyc7Izyekg4erNbUiI7MR1H3oQdShyZ4b768kWrQ=;
        b=UWKtGnqlWshNPMDBU1v55/4f+yf0INk6Nmy3YKYrSFm1TCof0PMAe6eOQI8mTszuQo
         VHXaVqzrNO1Ylc0JilhPBV2ZaZ48Z4p1jkiZ2YwzZD2S2oTZEfoG7ld3jLj8nxjjDyNN
         XRxTxFKWMaXimFBlrNmW2smn7imjZ+jGa90s1K+K0W2YHqxBqcV+mtFnDOwbtKjpvS4G
         kBW8SzruUmKSisKOZL7C0MEp6T669Mp/cFf/zSUDCSiXv5zAaz8XWxDNj2BxHzJGKkc4
         qlcEC8mDhlcJkW6JmA0XvxTYwmWSECDMEe5QmuiqylNui2S4wTY2mpBDMsphHPfEI9i6
         lo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084763; x=1769689563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvVMyc7Izyekg4erNbUiI7MR1H3oQdShyZ4b768kWrQ=;
        b=HQS3SbuBr9d7cZmiCj/YA4AeMyt32nWljffYFVsjk10w+YnXRV/hyaQEBjCnZSsFwI
         joWa0yVCzTnzQGkqSlWD9/9znr9tWRLkjOMGdvdrqrQbQQ/UfVWvhZLuz7AvDl4caGOW
         zb+iwFCGucXnUFBChRyFj1rvN5ezx30+yROLKVQOew+CNuMQfJ9rF12V5ZdHnCjrAHZQ
         ikw5sZLvceYY9vJenvS+8xJx2EF5chnSTeeJMnrshtokW5SPEi//vqezH2OCT1QZE+pe
         1nIdjoHGFtNkaaKL4dS/TCydVW3HeKfAS5+uInETBJ5g00QX9gzw6Mkt8+Pl/EqC0ruw
         caqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsJWHa0kXiaGdVZZ1atLX79JDBh21cOzOIvCFdWJ/WTp8ghy1bFqA6A5UzwBI0EOOhK8283f2Pu+wq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZA1ll4cqyCgtCJqpAEhqCr3ICDzRpAEihS93WMk7CLOhSPiw
	dEMB/16Dy63Zyaxiah7sODIPVy5Op5G38z7gEmgs+Ezt3Zah1mc/T4yMcQ/njQ==
X-Gm-Gg: AZuq6aJustp/DHjHLRkFK90aPKtLJtv87lZ+t6Geur32yTcAEDi6IdXGZ0V9tpZVzPl
	qR8Rppa3vXALoFEUHJk/ooLwDNypduaSOQtDlFMn0OuGbTlImthHlIs6jX7qwM9nvlDnElY4892
	Qd/jGzwBRykf2EGYftGYBpUItWhjg+RAx05m7xbI31PXsLSoG98e5G8QsqBNuHtN+kKINNtKDfe
	+S0WuwYPl+lB8x69YwkC1q37KhmLLzFPdJ+9k65eIB8WW0pLFuVWYlb3J7vdYXWulH9H2iNdntC
	c0WsCyMPNDnGtq6CgBRARFc6w19wPdV7EXbXxOmjNpd4p9rNSUHSgPDHu3IC1X90i2C4xGAQRG2
	3lFGbihUEF3cuyQ0mZM/LP8gDLDebUS/nfPcLr7dI+chmnMCjRGf48m3jBVNKHtY7XAWL/pU8vP
	dOr6xvhB1MEGEQSoU09jk0JrZbJPFj6immqKMghH1XKkolFca5abMQ
X-Received: by 2002:a05:6000:40c9:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-435a5f4da63mr4516285f8f.3.1769078019504;
        Thu, 22 Jan 2026 02:33:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm45262285f8f.32.2026.01.22.02.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:33:39 -0800 (PST)
Date: Thu, 22 Jan 2026 10:33:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <20260122103337.26473d1c@pumpkin>
In-Reply-To: <202601221237.soiAkwkN-lkp@intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
	<202601221237.soiAkwkN-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 12:41:22 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on next-20260120]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
> base:   next-20260120
> patch link:    https://lore.kernel.org/r/20260121145731.3623-12-david.laight.linux%40gmail.com
> patch subject: [PATCH next 11/14] bit: Strengthen compile-time tests in GENMASK() and BIT()
> config: mips-randconfig-r132-20260122 (https://download.01.org/0day-ci/archive/20260122/202601221237.soiAkwkN-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221237.soiAkwkN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601221237.soiAkwkN-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
> >> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  

Can we stop sparse complaining about sizeof(VLA) ?

	David
