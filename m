Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:54662 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1946901AbWKAOYR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Nov 2006 09:24:17 -0500
Date: Wed, 1 Nov 2006 09:24:14 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Message-ID: <20061101142414.GA3219@athena.road.mcmartin.ca>
References: <20061028223730.GC3243@athena.road.mcmartin.ca> <20061030155910.GC13625@athena.road.mcmartin.ca> <20061030230210.041531ea.akpm@osdl.org> <20061101182352.c35b41ba.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101182352.c35b41ba.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, Kyle McMartin <kyle@parisc-linux.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 01, 2006 at 06:23:52PM +1100, Stephen Rothwell wrote:
> It will be fine.  Neither of the passed ints have valid negative values.
> The original comment was overly zealous.
> 
> However it would be nice to not have "32" in the names of gerneic compat
> functions i.e. call it copy_compat_siginfo_from_user or
> get_compat_siginfo.
> 

This was for parity with copy_siginfo_to_user32. Once I replace both of
those on all arches but ia64 with a generic one (ia64 seems to be the only
arch with a different struct siginfo.) I will rename them to
compat_copy_siginfo_(to|from)_user, which seems to be the convention.

Cheers,
	Kyle M.
