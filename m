Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68533E7;
	Tue,  3 Feb 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094053; cv=none; b=I/xWb1JUcAxWkAfQIFR9vOC6u9Llcv0h+6xm+lAsXFrLNkwsGI96kOVyoeLmLdmng7AKFoVY82aVX6DCHzzvluomdriLEp5tikg+G2pFxn5ZXwCjKs6o2yGrrI0Scv2E8CcRjBH5aUeDRE4TTjpJ0HxB1aog2s5qac8eyea1BE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094053; c=relaxed/simple;
	bh=Wr1uGsWHXX2Bf+BETc6ZRbu2auK4MLlOIpi4rtyzTmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwvnAVzTnl/QZ+8DQf2Ndr2YWdoYutMaWIb5qoQWak0wStK6F+nINxfuMxNj7OtywEIT895mgx7JN+SK7JN/+pesaZ0ek+SYhVQFgqknjNobPp6YQRc91vE0/mAqDI/co7eQUSUL1zsXne+tfZM18DsfQvQxzztf1/Otyqh+dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCx7Riw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCx7Riw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEEAC116D0;
	Tue,  3 Feb 2026 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770094052;
	bh=Wr1uGsWHXX2Bf+BETc6ZRbu2auK4MLlOIpi4rtyzTmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNCx7RiwyWSk7Fsk1k+S0GWbSqI2Rcy/FPUQbC7RHnyHjkwzgNbLXDcGSXkbzc6dR
	 O4Mw1qD5saPZYlzJbZWES6FCTDaMTjlhQs3XTor/6RKXCVgr573N5FYmAn2m8/LrHt
	 +4hmqZlKigXKJ3U2IwoAbD5XQHvCJo/29GR7eA5a+eZ9GY4H2jswJH9rFuKEHsQ+1/
	 ca32iN6LAmH5eTA47ZJBispuwnpOJXdhLzQXC/V3QRJjlwH5rIbQD01n8Mi6FhdZmR
	 boWSYfaPfXjylwh5sXJyNihx3Qg+8rg4OA8jGLprg88iTQ0y32nqNei2AKac9n/daR
	 VRfFn0YqCuWcw==
Date: Mon, 2 Feb 2026 21:47:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 02/14] kbuild: Add W=c for additional compile time
 checks
Message-ID: <20260203044726.GA3049363@ax162>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-3-david.laight.linux@gmail.com>
 <aYDt8gLSRbFHwVpn@yury>
 <20260202200743.6182eb60@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202200743.6182eb60@pumpkin>

On Mon, Feb 02, 2026 at 08:07:43PM +0000, David Laight wrote:
> On Mon, 2 Feb 2026 13:33:22 -0500
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > On Wed, Jan 21, 2026 at 02:57:19PM +0000, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Some compile time checks significantly bloat the pre-processor output
> > > (particularly when the get nested).
> > > Since the checks aren't really needed on every compilation enable with
> > > W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
> > > Make W=1 imply W=c so the build-bot includes the checks.
> > > 
> > > As well as reducing the bloat from existing checks (like those in
> > > GENMASK() and FIELD_PREP()) it lets additional checks be added
> > > while there are still 'false positives' without breaking normal builds.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> > 
> > Honestly I don't understand this. AFAIU, you've outlined a list of
> > compiler warnings that slow the compilation down, and you group them
> > under 'W=c' option.
> > 
> > What is the use case for it outside of your series. I think, a typical
> > user would find more value in an option that enables some warnings but
> > doesn't sacrifices performance.
> 
> All the compile-time warnings slow down the compilation.
> Even apparently trivial ones (like the check in the generic READ_ONCE()
> that the size is 1, 2, 4 or 8 bytes) have a measurable effect.  

What kind of difference are we talking about here across a regular
build?

> The code a typical user compiles won't have anything that trips any of
> the compile-time asserts.
> They only really happen when compiling new code or adding new checks.
> 
> > Can you consider flipping the 'W=c' behavior?
> 
> Why, most of the time you don't want the checks because the code is
> known to pass them all.
> 
> It also means it can be used for new checks before all the bugs (and
> false positives) have been fixed.
> I did think of just enabling the checks for W=1 builds, but that makes
> it far to hard to enable them.
> As it is you can use W=ce to enable them and stop on warnings and errors.
> 
> Also W=xxx can only really add checks (there are some checks for it being
> non-empty). Documenting that W=x stopped the 'x' checks being done
> would be painful.

Yeah, I don't think we should be overloading the meaning of W=.

> > Can you please explicitly mention warnings included in W=c vs W=1? Can
> > you report compilation time for W=0, W=1 and W=c? What if one needs to
> > enable fast/slow warnings from 2nd or 3rd level? Would W=2c or W=3c
> > work in this case?
> 
> The W=123 options are all completely independent, my W=c is the same.
> I'm not sure it is sane to run W=2 rather than W=12, but it is allowed.
> 
> I made W=1 imply W=1c so that the build bot would pick up the extra checks.
> Apart from that all the 'W' flags are independent.
> W=123 fiddle with the command line -W options and set -DKBUILD_EXTRA_WARN[123]
> so that files can include extra checks.
> W=c just sets the equivalent -D option.

Why even have a different option then? You mention above placing the
checks in W=1 makes them too hard to enable but then you say that you
made W=1 imply W=c?

> > What does this 'c' stands for?
> 
> Anything you want it to :-)
> Discussion session arranged for 2pm-5pm by the bike shed.

W=c already exists, it is documented as enabling extra Kconfig checks in
'make help'. Maybe W=x for "ex"pensive checks? Or maybe if we really
want W=c, maybe rename W=c to W=k for Kconfig? I do not really have a
strong preference.

> In some sense it is 'more warnings than default, but not as many as W=1'.
> Like a lot of the W=1 warnings I wanted to be able to pick up 'code quality'
> issues without breaking the build for normal people.

So something like a W=0.5? :)

> There are definitely some other checks that could be relegated to W=c
> once it has been added.
> 
> I'd also like to add some checks to min_t/max_t/clamp_t to pick up the
> worst of the dodgy/broken code without having to get all the patches
> accepted before the test itself is committed.
> Tests for code like clamp_t(u32, u64_val, 0, ~0u) (yes there are some)
> tend to get very long and may be problematic if enabled by default
> (I got burnt by the 10MB expansion of nested min().)

I do not have a super strong opinion about this overall but it feels
like this is a bit of a slippery slope with warning fragmentation. I
think I would rather see these be treated like regular compiler warnings
where the majority of instances are cleaned up then it is added to W=1
to keep the tree clean.

Cheers,
Nathan
