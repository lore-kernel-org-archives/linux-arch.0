Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:45014 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261931AbUB1VlJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 16:41:09 -0500
Date: Sat, 28 Feb 2004 22:40:57 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-Id: <20040228224057.5959c8be.ak@suse.de>
In-Reply-To: <20040228202833.GB19963@baldric.uwo.ca>
References: <20040226155930.GB24779@baldric.uwo.ca>
	<20040226173115.7bd1aa86.ak@suse.de>
	<20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk>
	<20040226174753.4319802c.ak@suse.de>
	<20040226194747.GA28037@baldric.uwo.ca>
	<20040226205058.5a0d1e34.ak@suse.de>
	<20040227234037.GB10923@baldric.uwo.ca>
	<20040302213932.55852152.ak@suse.de>
	<20040228191536.GA19963@baldric.uwo.ca>
	<20040228203658.5a11df00.ak@suse.de>
	<20040228202833.GB19963@baldric.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Carlos O'Donell <carlos@baldric.uwo.ca>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 28 Feb 2004 15:28:33 -0500
Carlos O'Donell <carlos@baldric.uwo.ca> wrote:

> > Is it really that hard to do the switch in architecture specific code?
> 
> Yes, because I loathe the code duplication I'm seeing in all the arch
> directories. Please don't tell me that it's more maintainable that way.

It's about 5 lines of code. Not really a big issue. The bulk will be 
shared.

> IMO, and I am not granted a crystal ball, the situation could be made
> cleaner through:

[...]

Not sure what this has to do with the issue at hand of adding an is_compat_task()
or not. I have no great opinion on fs/compat et.al vs arch/generic, filenames
really don't concern me.

-Andi
