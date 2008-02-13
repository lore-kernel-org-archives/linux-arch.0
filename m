Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41946
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752106AbYBMAlR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 19:41:17 -0500
Date: Tue, 12 Feb 2008 16:41:49 -0800 (PST)
Message-Id: <20080212.164149.209357519.davem@davemloft.net>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080212191552.GA20883@kroah.com>
References: <20080212174824.GA1919@kroah.com>
	<alpine.LFD.1.00.0802121011280.2920@woody.linux-foundation.org>
	<20080212191552.GA20883@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greg@kroah.com
Cc: torvalds@linux-foundation.org, jeff@garzik.org, arjan@infradead.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Greg KH <greg@kroah.com>
Date: Tue, 12 Feb 2008 11:15:53 -0800

> On Tue, Feb 12, 2008 at 10:26:53AM -0800, Linus Torvalds wrote:
> > We absolutely MUST NOT have the mindset that "cross-subsystem conflicts 
> > happen all the time". 
> 
> They usually don't, by virtue of our current development model and how
> we have the kernel structured.

BTW, there are some things we can do to with the kernel structure
to help a lot of really idiotic cases.  Here are some odd-the-cuff
suggestions:

1) Make feature-removal-schedule a directory with files in it.
   Everyone touches that file, creating merge issues.

2) Let's move away from some/dir/{Kconfig,Makefile} schemes and
   instead have each "thing" have it's own Kconfig.foo or
   Makefile.foo that gets automatically sucked into the main
   directory Makefile or Kconfig using file globs or similar.

   Even better, encode the building of things into the *.[ch]
   files themselves, and have the Kconfig/Makefile machinery
   automatically extract this information when you build.

Little things like this would go a long way to eliminating merge
hassles.

For example, with #2, when a driver is added it would only
every add files never edit existing files.  Merge conflicts
are impossible unless two new drivers try to use the same
file names. :-)

