Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A82DCC1F
	for <linux-arch@vger.kernel.org>; Mon,  9 Feb 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630143; cv=none; b=SmYzGnY470UY4RJpnHYDUNB4nUceTl72s6Vj4RAxVPLMcF6lV+Y55TG7faflPfrxiKRjFr6nUsyXIA38AVgrsLrkgK4KRsUzo8v9iUpy8dpQkhdpHzfVLxE2cGBgzCKQjdjvYKGGsEYuQ/5hLudU/j2dzfinQe7wbdQtRgk949Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630143; c=relaxed/simple;
	bh=YuFqX3smt6q2CJNEkl9SfXSQYPgPkPODF2ccdqYslFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBfrE3PTcjLAX0StKa58OE7gAekwxKR0w/W5Kvsa2HBdHmSvgG+sg/25b4RbcrtNE4YSj7NPOJ4pBBAI9sdeGYMHajXuYEI3Ba8T0gr8T21KBIjB+GfVsqM857RYZZz030uCU/R4cPFK5mshRZiuv/5gA7RvzQlLIuZVaRHA+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNvrBFmv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNvrBFmv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43622089851so3419527f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 09 Feb 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770630141; x=1771234941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69fDqZY+sGe7M3B1r7WsUCzwZlIvrT5U0nhB9NLldZY=;
        b=cNvrBFmvtIaLJMIrbkZ+68gBwb5K5Tmcmes6VvB6DS9SVffkX+FITgO65NJBwIkTeU
         dUaKeSm1KeqPGPA9yxQ7yvxEAvPMjUjhuA8QVrBnaZfAl4WW9iGYhT+apSVt1D68Ira8
         uyhRMpGk+bAJX+U4sOg08yKl+dkZJtcLc9rw25EIimxqvHKwSNd+AF/p4ypa9hGhjk/t
         5OVGn+oXbP+0/MWam8i/DaJ7gukWhip3OB5q2jDfml+GuoWl6pYLhdHyPMY3lAIyfQyr
         4KCNDHQiPvtRpS73MSSc1HiWfyTVtcab/xxLNiqVIlmfDcX4ljwruU9uAuZGZOQWIFmw
         FHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630141; x=1771234941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69fDqZY+sGe7M3B1r7WsUCzwZlIvrT5U0nhB9NLldZY=;
        b=rjZH5Bw707X6FTNnNWifMig4rYvDpkVFvWkV8adfO5m1wjQTbNldycuej8qmeR2XHA
         4kLjTT34K3EfBeHVYLLHRBm6eomiR7kmHsf7RjePzHlZdiEvUgwGDwyyG/CEX6rTzva5
         kn3ngIgFFkFANDkKm1DOnKibiMCVhYhs2gx1HAIfcefEyg7USRe8/xIBG+nL+TeqQK4X
         VotgFLB1+8RG6ODBZFFZdhi7AIUORuv9Hxd6B+3pj7N+4/IMTWBbC/7tkQ1aOu0cyNs6
         gA64NnRUsgo1uW2VtPo5ZJXRwJaspEbUIolKQYmPNU8+1GfsPDESALM1JY0hfQgPcOo/
         LbZg==
X-Forwarded-Encrypted: i=1; AJvYcCV83/lm0RVCQxJrVcFLalIjTrdGaxSsdJ5gPYaCQ5oDPStG1YIeSTUJUpoOyUZpITWQ+ekrH6xsnJpo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7C6/4vEgUTgee4ovhThPf0txA//ySPIplWcoK8GVNjAnEPIP
	YJ7cuIDB7NsmE707dG8dSKcuM1hWKqXtSZfBi4YDkgzrHZa0YeqKClOi
X-Gm-Gg: AZuq6aIiFoLF2qfH0oZ1Scqnc6vftaEBz9bTJAo54d8uLMGyQ16WZ83gqg9gJU+hLQw
	U3f/Poxv9SZZKIWhpcWHQMIL+9gvLURxheF6dtQWDoHWQLRa0RJkQUOoNTiIlzipSWDtHF5ZhNN
	bbvKy51Yn0oaAk8ChiRBt52HPr453M47byEovweWkZVco8eLfOKoFvO3X87+40MrNJpfHsS+kHc
	J9FstRty8oghx8a9Le28tcJnXFv4/Vl8nkIxW4qdT/kLUAnDrgkucu7IY00VbuJz/RaiTNaGGyS
	vCdtZsJQZ4A7n0ZqcyQKJu3Cu2ssFpnNvXWiirFYIrgcD6uPa/xAJ0xyw5KxodgXORW85jX6gOQ
	jC04otEGNlV5v45Je1GYcz/GFlm4fwPOR9i3CYLipjAcs9UvO8/AbJY1LannOCwGll8oAnWdx8l
	GJNC5GjhlGInD4nOmo2f12sV/ixuWzzMoHK6TI6TrUaFE+VvztWuR8
X-Received: by 2002:a05:6000:22c6:b0:435:9882:234e with SMTP id ffacd0b85a97d-4362938ff1emr15016035f8f.59.1770630140944;
        Mon, 09 Feb 2026 01:42:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bcdfcsm26587255f8f.10.2026.02.09.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:42:20 -0800 (PST)
Date: Mon, 9 Feb 2026 09:42:14 +0000
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
Subject: Re: [PATCH next 08/14] bits: simplify GENMASK_TYPE()
Message-ID: <20260209094214.5ed5db27@pumpkin>
In-Reply-To: <aYf2yUazqVJBeWZb@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-9-david.laight.linux@gmail.com>
	<aYf2yUazqVJBeWZb@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 21:36:57 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Wed, Jan 21, 2026 at 02:57:25PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Since the type is always unsigned (T)-1 is always the correct value
> > so there is no need to use type_max().
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Here you implicitly add a new restriction that all types passed in
> GENMASK_TYPE() must be unsigned. Can you enforce it with
> is_signed_type(), or at lease with a corresponding comment?

GENMASK_TYPE() is an internal define used in the expansions of,
for example, GENMASK_U32() - it is always passed an unsigned type.
I don't really think it should be used elsewhere at all.

In any case I don't think it makes any difference.
The value or type_max(t) has to match BITS_PER_TYPE(t) or else
the result is wrong, so it has never worked for signed types.

I did try adding a signedness check to FIELD_GET(), there is one
place in the x86-64 build that uses a signed type and requires the
right shift sign extend.
That code (in the fault handler) probably ought to be changed.

	David

> 
> > ---
> >  include/linux/bits.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index a40cc861b3a7..697318f2a47d 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -45,8 +45,7 @@
> >   */
> >  #define GENMASK_TYPE(t, h, l)					\
> >  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
> > -	     (type_max(t) << (l) &				\
> > -	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
> > +	     ((t)-1 << (l) & (t)-1 >> (BITS_PER_TYPE(t) - 1 - (h)))))
> >  
> >  #define GENMASK(h, l)		GENMASK_TYPE(unsigned long, h, l)
> >  #define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
> > -- 
> > 2.39.5  

