Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:9383 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261905AbUB1Tjl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 14:39:41 -0500
Date: Sat, 28 Feb 2004 20:36:58 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-Id: <20040228203658.5a11df00.ak@suse.de>
In-Reply-To: <20040228191536.GA19963@baldric.uwo.ca>
References: <20040226043605.GD17229@baldric.uwo.ca>
	<20040229021045.78ac9466.ak@suse.de>
	<20040226155930.GB24779@baldric.uwo.ca>
	<20040226173115.7bd1aa86.ak@suse.de>
	<20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk>
	<20040226174753.4319802c.ak@suse.de>
	<20040226194747.GA28037@baldric.uwo.ca>
	<20040226205058.5a0d1e34.ak@suse.de>
	<20040227234037.GB10923@baldric.uwo.ca>
	<20040302213932.55852152.ak@suse.de>
	<20040228191536.GA19963@baldric.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Carlos O'Donell <carlos@baldric.uwo.ca>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 28 Feb 2004 14:15:37 -0500
Carlos O'Donell <carlos@baldric.uwo.ca> wrote:


> I agree wholeheartedly. I don't want to remove choice, but I do want to
> make maintenance easier, and reduce duplication of effort.

With adding is_compat_task() you're making long term mainteance harder.
 
> > They are pretty standard, except for the odd long long is different
> > from long long in 32bit requirement (which many people who try to
> > design compat compatible interfaces get wrong unfortunately because
> > it's a non issue on the RISCs) 
> 
> AFAIK 'long long' has to be a _minimum_ of 64-bits, but may infact be
> larger. Implementation details always have to be worked out by hand :o)

You misundertood, but never mind.
 
> The patch below will effectively remove is_compat_task() for x86_64.
> Apply it if you wish. You can do a number of nasty things with the
> definition of is_compat_task() in order to catch improper uses.

I must admit I am still not very happy about this.

It would be better to not have it in the first place, because it's a bogus
interface. In the current form people will start to use it for all kinds
of broken uses and it will be eventually impossible to get rid of it.

Is it really that hard to do the switch in architecture specific code?
I really fail to see where the problem is for you with this.

-Andi
