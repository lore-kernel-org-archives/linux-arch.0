Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB533E367;
	Fri, 23 Jan 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156341; cv=none; b=bKYQmBNNVgJ8OLOFXjuAl/ZVC61KIbdfipEhS+u3Ptd3a+WhWCUpE4mR9vs9hy7/4N0AODbkZVjdN7lhvUTUu/lqKmHfwqbp3k4D0YY8iEdWVtXaASyraRfup7neXrqqDRnrorvgRWx2+08Bfx/xHIk3FY6+3O0KDqxUyNfkjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156341; c=relaxed/simple;
	bh=yUGkWN+iu6/7NRuE5sT7dnx+rXlaISfY11BdQmiWqJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsSlBwdbQrh7SgkehnhMwpEWVi6ZuHfVxaIZaea89Z+w+gK353aSpTpSXzS+kCDqMkwUy1hkbgjppYIUYcXQwDBXH2bepwnjPCoSDHqBNZMkWZWP/SiB5zSJVaLcuoY2iT6dnVKQv2wRij7wVu4K3qbPyW/3rv7fVaW3OQi44jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XgSZ+KHW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XgSZ+KHW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gyOf4Vs38CnQQkdPfkNXajZzz23yi3NyTlLdhTK6YlE=; b=XgSZ+KHWw9am7bLdjQkvQgFi9G
	h230R9Tyf03Gx17xy5ULbM879iC16/8ecRhrN/+egahUgXJZa2H1S2vZYG/+jWWKjhl+BtEejHcn8
	TfWC8/oHVJujnSRPCbLb+RA4r+awBKijkDqifBMcKyuxam/TTvy1TpQ7ITjQZmEcCcxd9UNQpUOm+
	3RP0sDPKrmnDcUHimhunWh8EaGrrQiouH8I19OLojGE89Qt8IM1y/055Yf2kYL+beqliFZzi1yMxb
	ABOoK1pP6TltVqnik6RyL3iMClaSM4ScJY0YSF0J5cLyPGIhjYz8qJHfcA1knK5K/wxIo0y41Cx/H
	DO4w+p4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjCP5-0000000HSa0-3imk;
	Fri, 23 Jan 2026 08:20:27 +0000
Date: Fri, 23 Jan 2026 08:20:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20260123082027.GJ3183987@ZenIV>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com>
 <aXLOELiIG8MHKcIO@rli9-mobl>
 <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
 <aXMtJ_JurQjvN4tU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXMtJ_JurQjvN4tU@smile.fi.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 23, 2026 at 10:11:19AM +0200, Andy Shevchenko wrote:

> > Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
> > Wouldn't it be possible to just merge those?
> 
> Ideally yes, but you also should kick the distro's asses to update it, and
> the sparse should bump its version...
> 
> > That would be much less confusing.
> 
> Seems Al become a sparse maintainer de facto :-)

Huh?  What happened to Chris?  FWIW, I do have some followups to that series
sitting locally; need to get that finished (mostly for proper __VA_OPT__
handling; that got stalled on the lovely corner cases where the interplay
with side effects of macro expansion is really nasty - gcc and clang do
not agree and gcc is arguably buggy) and posted.

I've done quite a bit of sparse work over the years, but I would rather
prefer somebody else as overall maintainer, TYVM...
