Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:38865 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261831AbUB1MeU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 07:34:20 -0500
Date: Tue, 2 Mar 2004 21:39:32 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-Id: <20040302213932.55852152.ak@suse.de>
In-Reply-To: <20040227234037.GB10923@baldric.uwo.ca>
References: <20040225152204.2769a99b.akpm@osdl.org>
	<20040226043605.GD17229@baldric.uwo.ca>
	<20040229021045.78ac9466.ak@suse.de>
	<20040226155930.GB24779@baldric.uwo.ca>
	<20040226173115.7bd1aa86.ak@suse.de>
	<20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk>
	<20040226174753.4319802c.ak@suse.de>
	<20040226194747.GA28037@baldric.uwo.ca>
	<20040226205058.5a0d1e34.ak@suse.de>
	<20040227234037.GB10923@baldric.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Carlos O'Donell <carlos@baldric.uwo.ca>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 27 Feb 2004 18:40:37 -0500
Carlos O'Donell <carlos@baldric.uwo.ca> wrote:

> On Thu, Feb 26, 2004 at 08:50:58PM +0100, Andi Kleen wrote:
> > > I do not believe these changes will cause kernel maintainers 
> > > to loose their good sense of design. Sprinkling is_compat_task
> > > in every nook and cranny is not the goal of these changes. 
> > 
> > It may not be the goal, but it's opening the floodgates for it.
> >
> > Is it really that hard to keep the 32/64bit check in architecture
> > specific code? It's only a few lines of code anyways.
> 
> The same argument can be used in favour of the changes. Your assumption
> of causation between these changes and future changes wrt ABI design 
> issues is IMO without merit. The patch fixes present problems, with
> minimal impact, a clean interface, and allows this code to be leveraged 
> by a number of arches.

Most of the code is fine, all I request is that you keep the 
part that switches between 32bit and 64bit signals in architecture
specific code.

These are a few lines of your code only.

If you really don't want to do that please provide a way that I can
define away the compat task macro for x86-64 at least (although that would
be a bad idea, just not having it would be better)

> Do you have a draft for an alternate x86_64 ABI that I can read?
> Are you already working on an alternate ABI implementation?

No, it doesn't exist yet. I just don't want to close the door
for such future enhancements. There is a patch for IA64 that does this 
though.

I really don't want this generic macro thing for x86-64. 

> Lets move forward. What are x86_64's needs wrt compat?

They are pretty standard, except for the odd long long is different from long long 
in 32bit requirement (which many people who try to design compat compatible
interfaces get wrong unfortunately because it's a non issue on the RISCs) 

-Andi
