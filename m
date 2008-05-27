From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 14:30:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>  <20080526.184047.88207142.davem@davemloft.net>  <1211854540.3286.42.camel@pasglop>  <20080526.192812.184590464.davem@davemloft.net>  <1211859542.3286.46.camel@pasglop>  <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
 <1211922621.3286.80.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45465 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758468AbYE0VbV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 17:31:21 -0400
In-Reply-To: <1211922621.3286.80.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com



On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2008-05-27 at 08:35 -0700, Linus Torvalds wrote:
> > 
> > Expecting people to fix up all drivers is simply not going to happen. And 
> > serializing things shouldn't be *that* expensive. People who cannot take 
> > the expense can continue to use the magic __raw_writel() etc stuff.
> 
> Ok.
> 
> Do we also remove wmb/rmb/... from drivers then ? :-) I think ia64 would
> need to be fixed to make their writel serializing...

Well..

There's really two different issues:

 (a) x86 and the fact that we have thousands of drivers

which in turn conflicts with

 (b) non-x86 and the fact that other architectures tend to be absolute 
     pieces of cr*p when it comes to ordering, _especially_ across IO.

and the thing about (b) is that the number of drivers involved is a hell 
of a lot smaller. For example, ia64 and the big SGI machines probably 
really only care about roughly five drivers (number taken out of my nether 
regions). 

So practically speaking, I suspect that the right approach is to just say 
"ok, x86 will continue to be pretty darn ordered, and the barriers won't 
really matter (*)" but at the same time also saying "we wish reality was 
different, and well-maintained drivers should probably try to work in the 
presense of re-ordering".

In *practice*, that probably means that most architectures will be better 
off if they emulate x86 closely, just because that means that they won't 
rely on drivers always getting things right, but I think we can leave the 
door open for the odd machines. We should just realize that they will 
never get a lot of testing, but on the other hand, their usage scenarios 
will generally also be very limited (very specific loads, and _very_ 
specific hardware).

And the patch I sent out actually made "__[raw_]readl()" different from 
"readl()" on x86 too, in that the assembly _allows_ a bit more 
re-ordering, even though I doubt it will be visible in practice. So if you 
use the "__" versions, you'd better have barriers even on x86!

			Linus

(*) With the possible but unlikely exception of some big machines with 
separate IO networks, but if they happen they will fall into the 'ia64' 
case of just having a few relevant drivers.
