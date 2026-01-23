Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BF22759C;
	Fri, 23 Jan 2026 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158007; cv=none; b=apoclVip7dUav7jDgq/tTdDBWuq8Jw+WrzpYWJaqCOrc6EL15Q98aaK8dgXzn777sr2fwxEQ4sdC64KJ1i1BJwb+WlPFYcllAeb5C/c/N+uKevDuXHe4DhxiI9rhv/5J3mSkOYE1HAkyLpW01P5HiagG9N9+0kk+MaqBScilzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158007; c=relaxed/simple;
	bh=yxLPZsI3BlaCXSYy3VRdvRI8ej/dhsqIiU79HyiDkSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHdrxDmiAiblKDjg8O3YgoEQP2ms7eaRfbdkcuIKX77+y5EsHfMGU8QcZobamSgTW/aTGD9hYAHw5O3d1vN8t/NItOOLEgrvEAgKXU7P2E0PJwkbtU88KLkz+kWgDUCqRY18XcvJeOgjZbIG5X06pbX+ESvy0lrdy4IXVdCRNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FafuA+8K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FafuA+8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769158005; x=1800694005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxLPZsI3BlaCXSYy3VRdvRI8ej/dhsqIiU79HyiDkSY=;
  b=FafuA+8KDRE+3wBDCjgD+llxnqdnFhQOv5qQKue6kJYv0AUIhMhfY1py
   eMj97Rddt4oinZ22RkapQ9DySqimmHNTd4Nj6oEzzwIXKDye40wOgBOA5
   37r5ONq5w1hy0d+6NhV10nTgkHxoVPl/Utcb5XfwU6mYyQ4NzdJLKwcfr
   raMSBYoaFabzAKfF5wzjbNrLOOKiRrM106uMzviRCpH5tMpJlTfLnR7h5
   5hub2BqzLU3KbVFV91Kk3sJrECAV6Rq3keYx4JurLiZ9N5SeOX/ns2Lxw
   AHKzU2iz3CLkaQmcbL00mRectRP5OeW89U6hJiJkabfxoHc5kzAh59cUk
   A==;
X-CSE-ConnectionGUID: yqH57tYOQSy3+SbIJBLgLA==
X-CSE-MsgGUID: tT5uHhPVRayYkaNvhVCthw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70310696"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70310696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:46:45 -0800
X-CSE-ConnectionGUID: I0uBEMeHRLq8+KZyIRqqfA==
X-CSE-MsgGUID: fUlz+CFyRPexsZDcn7SC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="237621745"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:46:40 -0800
Date: Fri, 23 Jan 2026 10:46:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Li <sparse@chrisli.org>,
	Philip Li <philip.li@intel.com>,
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
Message-ID: <aXM1bWepP2sVy9qA@smile.fi.intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com>
 <aXLOELiIG8MHKcIO@rli9-mobl>
 <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
 <aXMtJ_JurQjvN4tU@smile.fi.intel.com>
 <20260123082027.GJ3183987@ZenIV>
 <aXMwIcH7Zh-1yNq3@smile.fi.intel.com>
 <f9fcd1c6-373c-4345-b413-9bb6c1cd2d3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9fcd1c6-373c-4345-b413-9bb6c1cd2d3a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 09:32:39AM +0100, Vincent Mailhol wrote:
> On 23/01/2026 at 09:24, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 08:20:27AM +0000, Al Viro wrote:
> >> On Fri, Jan 23, 2026 at 10:11:19AM +0200, Andy Shevchenko wrote:

...

> >>>> Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
> >>>> Wouldn't it be possible to just merge those?
> >>>
> >>> Ideally yes, but you also should kick the distro's asses to update it, and
> >>> the sparse should bump its version...
> >>>
> >>>> That would be much less confusing.
> >>>
> >>> Seems Al become a sparse maintainer de facto :-)
> >>
> >> Huh?  What happened to Chris?
> 
> After the project hiatus, I can imagine that there is some confusion :)
> 
> But Chris is back in his role of maintainer since September 2025. See:
> 
>   - https://lore.kernel.org/linux-sparse/CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com/
>   - https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=67f0a03cee4637e495151c48a02be642a158cbbb
> 
> > I don't know, but upstream sparse haven't applied any solution for
> > MODULE*("FOO") stuff, nor reaction on my ping in that discussion
> > (I did it like week or so ago).

My ping: https://lore.kernel.org/all/aV9vo7_turBr84bs@black.igk.intel.com/
But now I realised that there was another version of the series, and Chris
seems active there.
https://lore.kernel.org/all/CACePvbU5Pqo=bw_j8arOq16o1JBOSwPtuMZBVozy4FV7YsSLGw@mail.gmail.com/

> I am out of context here, but were the correct people CCed?

I dunno.

-- 
With Best Regards,
Andy Shevchenko


