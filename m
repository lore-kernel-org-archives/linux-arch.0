Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F842F39C2
	for <linux-arch@vger.kernel.org>; Tue,  3 Feb 2026 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117258; cv=none; b=U4k0MT49NuhBbHj1pmUaYsNctzHg+PKR4B1YlXAGcGM4TTaxN9C9C6P2pqfCgYgOXx+amEy6bY7bSrAoojGEYvAMIy/QLxMzZ3o8KrbnyhBSktSAFFlbQBUGVTkugrws7MMhnp8iuyZfGwnlvifqygunaHDyPBEdKmV1xaxpTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117258; c=relaxed/simple;
	bh=TGZHFs+y5PZEiI0dxc1o5jYsv5t57JErrTDo5l+CpR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZU/Taldo4NucxDGk9aD5r/YtQ1u/QdbDWSDF5E4RP1kizqp1Xp9JyPBWDa/i4I7PARiF9IXEIKFtxPCINX7xK/avfUKDv6zGtQFkVV0aZ1ZngYHsxa46xmlMnIdDT43C4zIJsPGNFTS3lkDhUZRiWZWb6jbKEUgAWyhdzlRo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tom3Y4nY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tom3Y4nY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee07570deso45944005e9.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Feb 2026 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770117256; x=1770722056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adwbTe5M7kxA5p3EcIAVpKLTNbIPukeDa7ym8Wf5u6g=;
        b=Tom3Y4nYl7ndjmQl1+HY0MiEtYUfF8aY0Gvv7QlUBU3GfdbIVeG9V/Y7UVYmnljRp1
         PURDcD+fytyNzEPJT4bPzpMltxrAvWQRtq2aIA+oYH9fvRPYrd4RKLPyfrUGKrtozM1k
         4bHKMJmx4EFyO9GDrlujAyFOVpe2NtFq2jWyBip8OD1FCAuFKqj2Cl/FarHhJCCm9bHG
         g/C4fDVZZhMVLy9aM76A5gBJPOVsZ4TkOM8l9xLCpLqdAl4GQnTu4Sm7sVKWagMHCYoj
         SxpinmrjCob0FuDFZ7vwjfTV5tv4C2T81EfCZqbiirH+BRFcE+DY87ydDJjfHucjm+dL
         Nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117256; x=1770722056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adwbTe5M7kxA5p3EcIAVpKLTNbIPukeDa7ym8Wf5u6g=;
        b=wH+ZWKQo3JXfdtsSlCkeTz+KmJkJN46UloJtfd5g2IiNvXJZ+aBa/YKjmmHrZcEcFG
         rbuR9t45sLq55A7mC9ZKY8oZ+cxlzsjdgZ9PVc9ho+7W+Co/rv3asKw/Pr/aeQ94aGTd
         ueE4T5Kn43hz7D0Q2hyZ8d84TT3vXjy9+9CEOWyRAfYyRgxz8XZALbfOTHswaVpe9Yis
         Mw122erKftRnHBF2Gab2gtidqYqZlptW/ybcWkKOmhJC0tqtv/uamO/nOvXlcZy9yTGP
         3CP9FF6j1mC95vA8pgGMYU2PB5IkZ0bDVhC80ywI7E2W6INc9o9mWzxruz88sj/bBqmD
         WuNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7wE4XiuA9ejTisHxZ90RFJlOKpyI0jxHadwkAFvzy6LE1NMuMXzAVUiBA4JpOM9ObN5cRDjorFHcq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27gbfjFYXY3i0GkWohXyieWMK/nNRarRyUbaTEYnn1V3FpFnZ
	/4Do77MJ4mQTMr/+YvgXA2bgEqRLTK0tkX6LVErwAoGx+Ou92hXddwkH
X-Gm-Gg: AZuq6aKE60otEHZqjC0GyVCrJBjTapiYKtTNomdU+9bpmyWLiaH3dyP1xpFkDlBQFUn
	o98JiUDJWtj5/glfEUm0H8cpg4j9g+XlRe4exhSF4Do7uTzQHTilwyR21YAT/PxoJyn0k4jROOA
	yIiMtWNGEtkhO0MFf2y4/cWc5iE+IIXShVUViBnHUkeK67Ckalhu6/t/jmMiE6c1aVBkTQAdSRW
	iz5McF2xZqCYRab1C6W7GM9+kYOye1G2XqRyNjkbZrmDp56teqKNKGI3t28dlUxTFg3tnEnfd+e
	l5UcJkeklnjaM2EyuPvXanDBgZ6DKt8uVX2SyYpOcAzmsobngdYHUapiYHyA8mHQfW8YiG3xVoX
	lSEH48IQTm2H1/a8y6Z56IaO8PSVSK3GPY4dkXh2IcJQe9dRsWSNk7g22nmP9ZMBvvQDfBvdP1V
	Nb3TcLzWgSU6mn+vIXMUZWGGt3gu/KZfqlAEE4Q4GhjSF7un3+qiag
X-Received: by 2002:a05:600c:a00e:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-482db4bda8dmr203947335e9.16.1770117255417;
        Tue, 03 Feb 2026 03:14:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10f82aesm53083817f8f.19.2026.02.03.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:14:15 -0800 (PST)
Date: Tue, 3 Feb 2026 11:14:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Greg Kroah-Hartman
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
Message-ID: <20260203111413.7cf29fa3@pumpkin>
In-Reply-To: <20260203044726.GA3049363@ax162>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-3-david.laight.linux@gmail.com>
	<aYDt8gLSRbFHwVpn@yury>
	<20260202200743.6182eb60@pumpkin>
	<20260203044726.GA3049363@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 21:47:26 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Feb 02, 2026 at 08:07:43PM +0000, David Laight wrote:
> > On Mon, 2 Feb 2026 13:33:22 -0500
> > Yury Norov <ynorov@nvidia.com> wrote:
> >   
> > > On Wed, Jan 21, 2026 at 02:57:19PM +0000, david.laight.linux@gmail.com wrote:  
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > > 
> > > > Some compile time checks significantly bloat the pre-processor output
> > > > (particularly when the get nested).
> > > > Since the checks aren't really needed on every compilation enable with
> > > > W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
> > > > Make W=1 imply W=c so the build-bot includes the checks.
> > > > 
> > > > As well as reducing the bloat from existing checks (like those in
> > > > GENMASK() and FIELD_PREP()) it lets additional checks be added
> > > > while there are still 'false positives' without breaking normal builds.
> > > > 
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>    
> > > 
> > > Honestly I don't understand this. AFAIU, you've outlined a list of
> > > compiler warnings that slow the compilation down, and you group them
> > > under 'W=c' option.
> > > 
> > > What is the use case for it outside of your series. I think, a typical
> > > user would find more value in an option that enables some warnings but
> > > doesn't sacrifices performance.  
> > 
> > All the compile-time warnings slow down the compilation.
> > Even apparently trivial ones (like the check in the generic READ_ONCE()
> > that the size is 1, 2, 4 or 8 bytes) have a measurable effect.    
> 
> What kind of difference are we talking about here across a regular
> build?

IIRC a couple of %.
I repeated a few builds with/without and it was much greater than the
variation between the builds.
That is a pretty trivial test, but there are a lot of READ_ONCE().
Find a few of those and the difference is significant.

> 
> > The code a typical user compiles won't have anything that trips any of
> > the compile-time asserts.
> > They only really happen when compiling new code or adding new checks.
> >   
> > > Can you consider flipping the 'W=c' behavior?  
> > 
> > Why, most of the time you don't want the checks because the code is
> > known to pass them all.
> > 
> > It also means it can be used for new checks before all the bugs (and
> > false positives) have been fixed.
> > I did think of just enabling the checks for W=1 builds, but that makes
> > it far to hard to enable them.
> > As it is you can use W=ce to enable them and stop on warnings and errors.
> > 
> > Also W=xxx can only really add checks (there are some checks for it being
> > non-empty). Documenting that W=x stopped the 'x' checks being done
> > would be painful.  
> 
> Yeah, I don't think we should be overloading the meaning of W=.

I did thing of supporting W=-e so that you can do W=1-e on a config
that enables WERROR, since there isn't much chance of a W=1e build
succeeding any time soon.

> > > Can you please explicitly mention warnings included in W=c vs W=1? Can
> > > you report compilation time for W=0, W=1 and W=c? What if one needs to
> > > enable fast/slow warnings from 2nd or 3rd level? Would W=2c or W=3c
> > > work in this case?  
> > 
> > The W=123 options are all completely independent, my W=c is the same.
> > I'm not sure it is sane to run W=2 rather than W=12, but it is allowed.
> > 
> > I made W=1 imply W=1c so that the build bot would pick up the extra checks.
> > Apart from that all the 'W' flags are independent.
> > W=123 fiddle with the command line -W options and set -DKBUILD_EXTRA_WARN[123]
> > so that files can include extra checks.
> > W=c just sets the equivalent -D option.  
> 
> Why even have a different option then? You mention above placing the
> checks in W=1 makes them too hard to enable but then you say that you
> made W=1 imply W=c?

What I meant was it is hard to see the errors in a W=1 build.
So I wanted the enable the checks without picking up W=1.

> 
> > > What does this 'c' stands for?  
> > 
> > Anything you want it to :-)
> > Discussion session arranged for 2pm-5pm by the bike shed.  
> 
> W=c already exists, it is documented as enabling extra Kconfig checks in
> 'make help'. Maybe W=x for "ex"pensive checks? Or maybe if we really
> want W=c, maybe rename W=c to W=k for Kconfig? I do not really have a
> strong preference.

It was 'c' for Compile time (a bit silly - but they are source 'compile-time'
tests rather then 'run-time' ones).
I'd only looked in makefile.warn for other uses.

> > In some sense it is 'more warnings than default, but not as many as W=1'.
> > Like a lot of the W=1 warnings I wanted to be able to pick up 'code quality'
> > issues without breaking the build for normal people.  
> 
> So something like a W=0.5? :)

That is really what I was looking for.
Perhaps setting -DKBUILD_WARN_LEVEL=level*10 would do?
So W=1 would set 10, W=2 20 (etc) with some scheme for setting intermediate
values (or at least (say) 5).

> > There are definitely some other checks that could be relegated to W=c
> > once it has been added.
> > 
> > I'd also like to add some checks to min_t/max_t/clamp_t to pick up the
> > worst of the dodgy/broken code without having to get all the patches
> > accepted before the test itself is committed.
> > Tests for code like clamp_t(u32, u64_val, 0, ~0u) (yes there are some)
> > tend to get very long and may be problematic if enabled by default
> > (I got burnt by the 10MB expansion of nested min().)  
> 
> I do not have a super strong opinion about this overall but it feels
> like this is a bit of a slippery slope with warning fragmentation. I
> think I would rather see these be treated like regular compiler warnings
> where the majority of instances are cleaned up then it is added to W=1
> to keep the tree clean.

That is slightly different because (mostly) they are warnings from a
new compiler version so are picked up by people running the new compiler
before they break things and then added to W=1.
Adding an extra check to an existing header needs the change committing
to get test coverage somewhat earlier - maybe to force some reluctant
maintainers to actually fix their code.

I definitely needed to conditionally include the checks with W=e but
without W=1, this seemed the best way to do it.

	David

> 
> Cheers,
> Nathan

