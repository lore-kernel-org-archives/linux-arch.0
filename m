Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173235B142;
	Fri, 23 Jan 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156649; cv=none; b=YEs0Es2ZfdKNzf93wmT06VaCeSG7mF5vmhL/y3ABTR3dkkwQOeCN9glbL/XJ7lKxQXrEfrK6B5An7t53BphOm8EQRFDuriCgea45oIcbyvzYQE5viqtOXkskkvghwtl8oYb0yw9O7bXrp+ERzkgJO83T84XAJhtZ7Gz7frZ4mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156649; c=relaxed/simple;
	bh=dwMlkmjcBaCYcjWa46P1uHRBsYlOiR+4SOQZ1svV6MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL0Lr1fudthpO6Kpj55vbUC/1qixlImzc9IL059z6fAzl9SluaBUex2r6huUWJmcIOtw3R2c32YlFT5PLiKfYAm/R5w14Hme2rmHxfzcAzw6zXAj7FLWlJldM8kauyJ0d78y20vXmKmaVlpeuTgfGMo3MK4vac7ih11ZBOStACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B53xQv/1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B53xQv/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769156648; x=1800692648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwMlkmjcBaCYcjWa46P1uHRBsYlOiR+4SOQZ1svV6MQ=;
  b=B53xQv/18BeF5U46UOID82D+SCTOI7Uz8ppDUGzHqSKmnW2VDK23QD2G
   vHLCEpIyfcVR+n28sqri86moMO/4u6mEg3BntbUNQgyeihLNzxnPUMjr0
   QUTvQUgFe6KWhHogDiJ9ecKDrl4+LLTR5PLh5ll1gCibGTGJsi7718RgK
   8lzMgZUC5xUdHQFpm+tz6k49WxodXNv/qW/vMMaKI3zYill4NQn15+RHT
   iRtk2W/8hSHM2bwE4qlM+MQjLxaOMAaSOGT16oZBYHziYaGrL6NZCN/8i
   AWcTOppfg08wVbuHTTkT/HII4pboeYVLWf4hsbwAJiew3Beg0mAbkaCTC
   w==;
X-CSE-ConnectionGUID: q3TkLD7GQ6KwcpPYaWDLPw==
X-CSE-MsgGUID: KmH/0QjLSPu29Ab4tNSSRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70318208"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70318208"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:24:07 -0800
X-CSE-ConnectionGUID: lkoPECn7TsODORNe+iM/Hw==
X-CSE-MsgGUID: Z3qn46K0TxqDntbM2syu4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206874169"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:24:03 -0800
Date: Fri, 23 Jan 2026 10:24:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vincent Mailhol <mailhol@kernel.org>, Philip Li <philip.li@intel.com>,
	Chris Li <sparse@chrisli.org>,
	David Laight <david.laight.linux@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <aXMwIcH7Zh-1yNq3@smile.fi.intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com>
 <aXLOELiIG8MHKcIO@rli9-mobl>
 <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
 <aXMtJ_JurQjvN4tU@smile.fi.intel.com>
 <20260123082027.GJ3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123082027.GJ3183987@ZenIV>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:20:27AM +0000, Al Viro wrote:
> On Fri, Jan 23, 2026 at 10:11:19AM +0200, Andy Shevchenko wrote:
> 
> > > Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
> > > Wouldn't it be possible to just merge those?
> > 
> > Ideally yes, but you also should kick the distro's asses to update it, and
> > the sparse should bump its version...
> > 
> > > That would be much less confusing.
> > 
> > Seems Al become a sparse maintainer de facto :-)
> 
> Huh?  What happened to Chris?

I don't know, but upstream sparse haven't applied any solution for
MODULE*("FOO") stuff, nor reaction on my ping in that discussion
(I did it like week or so ago).

> FWIW, I do have some followups to that series
> sitting locally; need to get that finished (mostly for proper __VA_OPT__
> handling; that got stalled on the lovely corner cases where the interplay
> with side effects of macro expansion is really nasty - gcc and clang do
> not agree and gcc is arguably buggy) and posted.

Thanks for doing all this!

> I've done quite a bit of sparse work over the years, but I would rather
> prefer somebody else as overall maintainer, TYVM...


-- 
With Best Regards,
Andy Shevchenko


