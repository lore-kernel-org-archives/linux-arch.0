Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951333043A4;
	Fri, 23 Jan 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155889; cv=none; b=Am94gd0X/Dnx93w8ejQo0rooWA27gGR+hs+7/zknDr6s5yDdF3698pK/Kj08xMKJiKFUwKn2D8qsxwXDjZcMHgnvoPfKqq3/6NfVTejwW7xLKqYodjGefuT7OF+hWTvS47oBFM5IhCDXUX6DNFOYB53o0EniKVoffOwxD6Se9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155889; c=relaxed/simple;
	bh=QtOiRkTP425/4cQrafxcluo4JRBRv0NYekdLhguDDwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkybrJKfg0XV3tjbVWMBQRnmo+4LyFLy4BXzkMQzm3ioSEDGmNY4E2fw0ioNncjAg4xsH3pV0bPS3jh/EY8VAXb7FO51rNFhHTtDo2zrf3RLmM27Rx0M5tVHtiaklrCRaE6E7d0Ku9n+0LllKvMjv0QXo6MrP0iW5tC31z6JrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELduKjBh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELduKjBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769155888; x=1800691888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QtOiRkTP425/4cQrafxcluo4JRBRv0NYekdLhguDDwg=;
  b=ELduKjBh8IN3MPqYTz9puIqGa9UUv6v9THu74VN/c3CfnTtmqPCyy5Ml
   ONoMRgegkxFXIpQTNgKkWc013ToLy6zJLiEWMQJNEawrLI/SlUWWvIpjN
   35uakH2cny2FxdomsSJDJAiA167QPDxqPyTPdMyH4wevXj0fOWQhSVQms
   s0RmXJvnvMQEGxvFx54n3Ygs2UPObX58vepwE8xDwQ4lsguigD4XzDFe1
   ubFSJbUoesUMvNHlnYLBSd2IeccHe46HB7mhS+8RZHPfJT0Ck6ssWvc8z
   Si6HzIi4XIApD0tV7vz/ssKMWfAzqC7Mwu+aX4D3siKzfqx4AFNyjc7BB
   A==;
X-CSE-ConnectionGUID: qpb4bXkiQFehiUy24bzHGQ==
X-CSE-MsgGUID: muEodgupS7yz7ZcFwBBQEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81036906"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="81036906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:11:27 -0800
X-CSE-ConnectionGUID: D/r5puBYQOWiTSqaAXqqnw==
X-CSE-MsgGUID: 5+oXIWBBQqCxe61TIqyuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206786060"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:11:21 -0800
Date: Fri, 23 Jan 2026 10:11:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Philip Li <philip.li@intel.com>, Chris Li <sparse@chrisli.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <aXMtJ_JurQjvN4tU@smile.fi.intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com>
 <aXLOELiIG8MHKcIO@rli9-mobl>
 <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 09:01:04AM +0100, Vincent Mailhol wrote:
> Adding the relevant parties to the discussion:
> 
> +To: Al Viro
> +To: Chris Li
> 
> On 23/01/2026 at 02:25, Philip Li wrote:
> > On Thu, Jan 22, 2026 at 04:26:44PM +0200, Andy Shevchenko wrote:
> >> On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
> >>> On Thu, 22 Jan 2026 12:41:22 +0800
> >>> kernel test robot <lkp@intel.com> wrote:
> >>
> >>>> sparse warnings: (new ones prefixed by >>)
> >>>>    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
> >>>>>> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  
> >>>
> >>> Can we stop sparse complaining about sizeof(VLA) ?
> >>
> >> First of all, the LKP should install the fork of sparse by Al Viro. That will
> >> fix tons of warnings that are related to modules and speed up the process
> >> itself.
> > 
> > Thanks Andy, i will switch to the repo from Al Viro for sparse.
> 
> Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
> Wouldn't it be possible to just merge those?

Ideally yes, but you also should kick the distro's asses to update it, and
the sparse should bump its version...

> That would be much less confusing.

Seems Al become a sparse maintainer de facto :-)

-- 
With Best Regards,
Andy Shevchenko


