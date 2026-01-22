Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE633C503;
	Thu, 22 Jan 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092013; cv=none; b=Al957G189HhWJE+7aYV1wnIdhi2rVDZhcBCWJM23hR/UHr+8+iJ4cEWhnlvtr7hy8w7kKVsUItnu2g+m2OrBqVblr7wW1BjDioq55u28qz6MQ4HbWkaYoaXyPFytdnq3EWdml4+JG+s3C7Bgr+N96WPS7ePqqkfCd9ITkkOT+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092013; c=relaxed/simple;
	bh=QB5NUK4YOqUArNa5QXuw5NpYDg4DBBZDL0+JySd5Y7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8sjmbvQSkfLW4gzMLB3/XTGv3xVbFQBp5U4U/WH9KjIwnI9ATKvGKkVsxw1azGW9bUblCxwZ9ymYN+Mg2GDvy3K4T+e+0Gd6zmEqKgqkZh94FrxEKxxEHZxatwqTgd4sm4d2rjN8x8aXuRDUmt5yAHNQtcZHqwMKjosIdbVVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjsnGsro; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjsnGsro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769092011; x=1800628011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QB5NUK4YOqUArNa5QXuw5NpYDg4DBBZDL0+JySd5Y7w=;
  b=UjsnGsro7s8y4EceQdpz9oHHh4Y/tZwExJFP/whWzoVTfqqPJrHoYWB7
   1HYFnGOrkTPMahVcHBlaYjCBvGZxzgyI9YMqgfdLZ1rLnGESJsgOBORUm
   sbykrEcjdmrMJ0S686Lk0l9kP7bQ/ShD50YG5KEZ2dZEiCr/4GIvroypS
   PWjvyWg/fsX4Ckpet+t0MfGcNqCgMF3Gu6QWVD2Vbmd/AdO0mVfJkN/P8
   lsqx2fqjjFwMp8eU+g2OBa5BSpTp+eSSsvNxgu6q0qmNG8SUL99P4e3u+
   bPwJVpSWYVjpX4/R14e9MVDKIbWKE5Mxv+P9/JPHNm3FaG0LOJPUAUeS8
   A==;
X-CSE-ConnectionGUID: l6c5DOs9R1ON7Xtz6JPO8w==
X-CSE-MsgGUID: yJxDvZplSHaPHN1UszJ+Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81705807"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81705807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:26:50 -0800
X-CSE-ConnectionGUID: urOX2XhJQJG4sCfejh0tog==
X-CSE-MsgGUID: dSn0a2/0SCi8GKyD8LZLQA==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:26:46 -0800
Date: Thu, 22 Jan 2026 16:26:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <aXIzpC6wpdv47cSH@smile.fi.intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122103337.26473d1c@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
> On Thu, 22 Jan 2026 12:41:22 +0800
> kernel test robot <lkp@intel.com> wrote:

> > sparse warnings: (new ones prefixed by >>)
> >    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
> > >> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  
> 
> Can we stop sparse complaining about sizeof(VLA) ?

First of all, the LKP should install the fork of sparse by Al Viro. That will
fix tons of warnings that are related to modules and speed up the process
itself.

-- 
With Best Regards,
Andy Shevchenko


