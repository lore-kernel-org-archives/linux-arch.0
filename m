Return-Path: <carlos@baldric.uwo.ca>
Received: from baldric.uwo.ca ([129.100.10.225]:53775 "EHLO baldric")
	by vger.kernel.org with ESMTP id S263197AbUB0Xlq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2004 18:41:46 -0500
Date: Fri, 27 Feb 2004 18:40:37 -0500
From: "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-ID: <20040227234037.GB10923@baldric.uwo.ca>
References: <20040225152204.2769a99b.akpm@osdl.org> <20040226043605.GD17229@baldric.uwo.ca> <20040229021045.78ac9466.ak@suse.de> <20040226155930.GB24779@baldric.uwo.ca> <20040226173115.7bd1aa86.ak@suse.de> <20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk> <20040226174753.4319802c.ak@suse.de> <20040226194747.GA28037@baldric.uwo.ca> <20040226205058.5a0d1e34.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226205058.5a0d1e34.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Feb 26, 2004 at 08:50:58PM +0100, Andi Kleen wrote:
> > I do not believe these changes will cause kernel maintainers 
> > to loose their good sense of design. Sprinkling is_compat_task
> > in every nook and cranny is not the goal of these changes. 
> 
> It may not be the goal, but it's opening the floodgates for it.
>
> Is it really that hard to keep the 32/64bit check in architecture
> specific code? It's only a few lines of code anyways.

The same argument can be used in favour of the changes. Your assumption
of causation between these changes and future changes wrt ABI design 
issues is IMO without merit. The patch fixes present problems, with
minimal impact, a clean interface, and allows this code to be leveraged 
by a number of arches.

Do you have a draft for an alternate x86_64 ABI that I can read?
Are you already working on an alternate ABI implementation?

Lets move forward. What are x86_64's needs wrt compat?

c.
