Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:36983 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756664AbYBUNYo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Feb 2008 08:24:44 -0500
Date: Thu, 21 Feb 2008 08:22:52 -0500
From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Announce: Linux-next (Or Andrew's dream  :-))
Message-ID: <20080221132252.GC14614@mit.edu>
References: <20080212051136.GA12802@mit.edu> <20080211221535.bc0dc9cf.akpm@linux-foundation.org> <20080212225716.cf695fe4.sfr@canb.auug.org.au> <20080214081405.GA20791@flint.arm.linux.org.uk> <20080214232229.f7bdc6ac.sfr@canb.auug.org.au> <alpine.LFD.1.00.0802140949460.6110@woody.linux-foundation.org> <20080221015511.1b54d4d3.sfr@canb.auug.org.au> <47BC498C.6000400@s5r6.in-berlin.de> <20080220154235.GD30305@mit.edu> <20080220171316.GA4749@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080220171316.GA4749@cs181133002.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 20, 2008 at 07:13:16PM +0200, Adrian Bunk wrote:
> > A third option would be if people add new functions (with no users) in
> > -rc2 or -rc3 timeframes as long as it is part of a fully reviewed
> > patch with users that will use those new features in various kernel
> > development trees.
> >...
> 
> I don't like suggestions based on unrealistic assumptions like
> "a fully reviewed patch".
> 
> E.g. userspace ABI's are much more stable and everyone is aware that 
> they must be gotten right with the first try since they are then cast in 
> stone - but we all remember the recent timerfd fiasco.

I'm talking about kernel interfaces, not userspace API's.  And we can
change them if they are wrong, since they *are* kernel interfaces; but
if they correct, they ease the cross-tree merge pain.

   		      	       		  	 - Ted
