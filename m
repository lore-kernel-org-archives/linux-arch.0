Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5923090C2
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062869; cv=none; b=jmzPknQuFmSC1J9/M8zfw45SzNDukIYpvfgSw0Umo3NECIum7M+kZEL3/32GjOesnO+ExLyc22QxprIAudm5+z/fM+7OFsMDP6fNLz5VK30/BVbtzg2Wyo8Mu5rKNM6wS/YhoklrMi9qSHp+86tRKjWJnQl/ZPw7q8OYj79OlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062869; c=relaxed/simple;
	bh=4d5k+cLKvcSJRwu2KsiEvqnEQBX1x0O/rF4njXLiEuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iquu+t9jDEngaPIcn3r+t52V8mPT4v1WN1dgtDSpxypuJC1ZIZ53s2zwQAws6JHVvfk++S1txiw9tz9pUQctVh8ukaIpe54Y8ujfjtDX8nT9+GNcw5R4Q6SQeyWmCdzgD6A41WH67yqUcBJsU1xd5ZqdO6xHqN+pJ1o0pMIcMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge28o8P6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge28o8P6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf03573so24036965e9.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Feb 2026 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062866; x=1770667666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWA8WLmHT5w9U8xiagfCzbCN6laFB2qQWZ5TMZiamFE=;
        b=ge28o8P6sG/Jdbmm1YqWYeodh0xQ0T3gJiw7B6RsKxJZc4agUFqzFh4yGnRs2jkFaD
         kZJToA/OBoHKG4HqUEXgylw79TsZxPkdqg3WLJdd5Zh2F+pwJLDIFSjQVdgFuH40XX5z
         N0MfZpgDaD5nHxIxFQWsl8mEs4q1MHn0JP4aMreMeq6KtxXX/vBIxumwbaWG/eCB/rgJ
         mMpETlRgsi1MdKDjz9Y9e+4r80cOX/PkJipghj7eyNg4BtIJGpTZ0UTiuhu6zJdyEPOC
         xQOgL16vFiUsUP0ge9WnqzOz2DyF/FwKe0YWOwg/6Nv4HtCI6j19fRwZxB/T5IQb9Va2
         jIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062866; x=1770667666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWA8WLmHT5w9U8xiagfCzbCN6laFB2qQWZ5TMZiamFE=;
        b=hQnuCJkfqOBMA9hdkkVdufmCljVueLwqkTrXPjuo5uNMsbzYNom6VGEDQqKcHYuAS/
         TcOIFO8FF4RTN9l5Y1JbOLQyzJ024TVYqYRqWSB2U+izVewYuxrftoUgz13qvrfeX6nJ
         7vhwg2Njy0lI+U2j0Is1RMH2DmTHsmGEO1iwvYyTT3djf1yoKUuVyRbxW+0riQDuNjwZ
         uwgwxBQbY07AtGthebClYJz+OQ7vbnbX0/RAN5ckEb8uWz394V5z7BzQ3w5L1M1pkz+1
         7EhHGOj+pcPzojpWxEWxJ3WMwkOWr6NMZwuBAvFrxhzHlDlXE6OsACTkF9xPVSe/8lem
         htxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOUQPGORMSS9yvijmQwPeO+TqlUBP1bKq+Jzk3nbls4+1w9nqhrDKgrn++t83aimbCSS60+hGUW5rX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi71eDiIwyDrMO6d3TDA2wGA2yJM5u82q2rrSJ81HPj5ToAi6X
	zaE17ItRswyn0/u4mgg/LV6E3j1b6hgOoVZm8FvqVcAgMjbNFaSRtADN
X-Gm-Gg: AZuq6aJbi+xMomx9dtLGuCiSI4+bjsTw3w4SKQhetuW7yzGxo3iC8NB9oxdhGnJvBh+
	QeVEYqAUREUhijD7y9j93tiBi2TCG5Cjvr3iqlwLPlX0JsXO9dcl8zX3gUB8W49esjXoP3wGHj/
	CzHMYiHY5yddyE4do92ir3FnRl5z4MOipqHpEXd6Q935TLRZCZyJPyG0+/jbJDXe1/mRvPZxr6x
	uG9kshPsq3jGEifUKHQbYPNItTCI6U+cE4XPa6fU+U2q5XZfkduTGL8QXcGMgyX4aOxh56auZ6I
	8luAhaidrzAQbkga4dHAMLgpWq77QhiymvQQKFKXllK9o0CjbCiyy5z0NvzXDJS7PovES6BTEK8
	7urALxgc+GrEW4dy8dYq5kcvfv6f++AACjFGQX+5IJ9aVEMmfYoywLAPbc2trVyKU47sBRNypPr
	GHLneNghPR+t7KSef331nA2Qjtd5rOELWW7Olx4Y1mKY6f/caNZ3vc
X-Received: by 2002:a05:600c:c059:20b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-482db491f33mr118708985e9.20.1770062866092;
        Mon, 02 Feb 2026 12:07:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051372cdsm16709975e9.13.2026.02.02.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:07:45 -0800 (PST)
Date: Mon, 2 Feb 2026 20:07:43 +0000
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
Subject: Re: [PATCH next 02/14] kbuild: Add W=c for additional compile time
 checks
Message-ID: <20260202200743.6182eb60@pumpkin>
In-Reply-To: <aYDt8gLSRbFHwVpn@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-3-david.laight.linux@gmail.com>
	<aYDt8gLSRbFHwVpn@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 13:33:22 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Wed, Jan 21, 2026 at 02:57:19PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Some compile time checks significantly bloat the pre-processor output
> > (particularly when the get nested).
> > Since the checks aren't really needed on every compilation enable with
> > W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
> > Make W=1 imply W=c so the build-bot includes the checks.
> > 
> > As well as reducing the bloat from existing checks (like those in
> > GENMASK() and FIELD_PREP()) it lets additional checks be added
> > while there are still 'false positives' without breaking normal builds.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Honestly I don't understand this. AFAIU, you've outlined a list of
> compiler warnings that slow the compilation down, and you group them
> under 'W=c' option.
> 
> What is the use case for it outside of your series. I think, a typical
> user would find more value in an option that enables some warnings but
> doesn't sacrifices performance.

All the compile-time warnings slow down the compilation.
Even apparently trivial ones (like the check in the generic READ_ONCE()
that the size is 1, 2, 4 or 8 bytes) have a measurable effect.  

The code a typical user compiles won't have anything that trips any of
the compile-time asserts.
They only really happen when compiling new code or adding new checks.

> Can you consider flipping the 'W=c' behavior?

Why, most of the time you don't want the checks because the code is
known to pass them all.

It also means it can be used for new checks before all the bugs (and
false positives) have been fixed.
I did think of just enabling the checks for W=1 builds, but that makes
it far to hard to enable them.
As it is you can use W=ce to enable them and stop on warnings and errors.

Also W=xxx can only really add checks (there are some checks for it being
non-empty). Documenting that W=x stopped the 'x' checks being done
would be painful.

> Can you please explicitly mention warnings included in W=c vs W=1? Can
> you report compilation time for W=0, W=1 and W=c? What if one needs to
> enable fast/slow warnings from 2nd or 3rd level? Would W=2c or W=3c
> work in this case?

The W=123 options are all completely independent, my W=c is the same.
I'm not sure it is sane to run W=2 rather than W=12, but it is allowed.

I made W=1 imply W=1c so that the build bot would pick up the extra checks.
Apart from that all the 'W' flags are independent.
W=123 fiddle with the command line -W options and set -DKBUILD_EXTRA_WARN[123]
so that files can include extra checks.
W=c just sets the equivalent -D option.

> What does this 'c' stands for?

Anything you want it to :-)
Discussion session arranged for 2pm-5pm by the bike shed.

In some sense it is 'more warnings than default, but not as many as W=1'.
Like a lot of the W=1 warnings I wanted to be able to pick up 'code quality'
issues without breaking the build for normal people.

There are definitely some other checks that could be relegated to W=c
once it has been added.

I'd also like to add some checks to min_t/max_t/clamp_t to pick up the
worst of the dodgy/broken code without having to get all the patches
accepted before the test itself is committed.
Tests for code like clamp_t(u32, u64_val, 0, ~0u) (yes there are some)
tend to get very long and may be problematic if enabled by default
(I got burnt by the 10MB expansion of nested min().)

	David

> 
> Thanks,
> Yury
> 
> > ---
> >  scripts/Makefile.warn | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/Makefile.warn b/scripts/Makefile.warn
> > index 68e6fafcb80c..e8a799850973 100644
> > --- a/scripts/Makefile.warn
> > +++ b/scripts/Makefile.warn
> > @@ -2,8 +2,9 @@
> >  # ==========================================================================
> >  # make W=... settings
> >  #
> > -# There are four warning groups enabled by W=1, W=2, W=3, and W=e
> > -# They are independent, and can be combined like W=12 or W=123e.
> > +# There are five warning groups enabled by W=c, W=1, W=2, W=3, and W=e
> > +# They are independent, and can be combined like W=12 or W=123e,
> > +# except that W=1 implies W=c.
> >  # ==========================================================================
> >  
> >  # Default set of warnings, always enabled
> > @@ -109,6 +110,13 @@ KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
> >  
> >  KBUILD_CFLAGS += -Wunused
> >  
> > +#
> > +# W=c - Expensive compile-time checks, implied by W=1
> > +#
> > +ifneq ($(findstring c, $(KBUILD_EXTRA_WARN))$(findstring 1, $(KBUILD_EXTRA_WARN)),)
> > +KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARNc
> > +endif
> > +
> >  #
> >  # W=1 - warnings which may be relevant and do not occur too often
> >  #
> > -- 
> > 2.39.5  

