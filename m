Return-Path: <adsharma@sc.intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:58783 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261967AbUB2COd
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 21:14:33 -0500
Date: Sat, 28 Feb 2004 18:11:06 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040229021105.GA6964@intel.com>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228155529.64bc0741.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Feb 28, 2004 at 03:55:29PM -0800, David S. Miller wrote:
> 
> Platforms with virtually indexed caches use SHMLBA of a size such that
> it is the largest cache virtual aliasing factor.  In this way, processes
> with different SHM mappings of the shared writable memory will immediately
> see writes done by other processes and aliases cannot enter the cache due
> to virtual addresses being "just right".

I read that to mean that there is a correctness problem, apart from
performance issues on some platforms.

How about something like:

			else
#ifndef ARCH_HAS_VCACHE
			if (addr & ~PAGE_MASK)
#endif
 				return -EINVAL;

So that platforms with virtually indexed caches are not affected ?

	-Arun
