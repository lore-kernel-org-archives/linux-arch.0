Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cabal.ca ([134.117.69.58]:54486 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750949AbWAYQfT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jan 2006 11:35:19 -0500
Date: Wed, 25 Jan 2006 11:34:36 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [RFC] is_compat_task helper
Message-ID: <20060125163436.GN5604@quicksilver.road.mcmartin.ca>
References: <20060124000753.GC5604@quicksilver.road.mcmartin.ca> <200601240113.39825.ak@suse.de> <20060123.210755.31638992.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123.210755.31638992.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 23, 2006 at 09:07:55PM -0800, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 24 Jan 2006 01:13:39 +0100
> > On Tuesday 24 January 2006 01:07, Kyle McMartin wrote:
> > > +/* Arches may override __is_compat_task from asm/compat.h */
> > I don't think this particular patch is a good idea. PER_LINUX32 means
> > something completely different than you think on many architectures.
> > You can't do a default for it.
> 
> Indeed, it is definitely preferable to just flat out break
> the build than give a bogus default.
>

Sounds fine to me.
 
> If the build breaks, you see the failure and the platform
> maintainer makes sure the correct implementation is made.
> If it silently just builds, you end up with potential silent
> failures which just sucks :)

Alrighty, would there by any objection to ripping out the 
`generic' __is_compat_task and letting this sit in -mm for arch
maintainers to fix their builds?

Thanks,
	Kyle
