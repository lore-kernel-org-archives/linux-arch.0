Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54075
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753262AbYBMBUT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 20:20:19 -0500
Date: Tue, 12 Feb 2008 17:20:51 -0800 (PST)
Message-Id: <20080212.172051.58554658.davem@davemloft.net>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.1.00.0802121610220.2920@woody.linux-foundation.org>
References: <47B1CB08.4020101@garzik.org>
	<20080212.155853.193190548.davem@davemloft.net>
	<alpine.LFD.1.00.0802121610220.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: jeff@garzik.org, arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2008 16:44:47 -0800 (PST)

> 	gitk --merge
 ...
> This is something where I actually think git could and should do better: 
> git has the capability to act as more of a "quilt replacement", but 
> because it wasn't part of the original design, we never actualy exposed 
> the simple queue management commands to do this (stgit does things like 
> that, though).
> 
> So if you haven't pushed out, right now you'd have to do this stupid 
> thing:

Thanks for all the useful info.

But as soon as I've applied any patches to my tree I've "pushed out".
So this scheme doesn't work for me.  The first thing I do when I have
changes to apply is clone a tree locally and on master.kernel.org,
then I apply that first patch locally and push it out to master.

What would be really cool is if you could do the rebase thing, push
that to a remote tree you were already pushing into and others could
pull from that and all the right things happen.

A rebase is just a series of events, and those could propagate to
people who are pulling from the tree.  I'm pretty sure GIT could
support this.
