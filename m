Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268104AbUJSJZq@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35520 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268101AbUJSJZq
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 05:25:46 -0400
Date: Tue, 19 Oct 2004 10:25:45 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: All archs: NO_IRQ definition
Message-ID: <20041019092545.GL16153@parcelfarce.linux.theplanet.co.uk>
References: <1098169077.11400.51.camel@gaston> <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk> <20041019102359.A8991@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019102359.A8991@flint.arm.linux.org.uk>
Sender: <willy@www.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 19, 2004 at 10:23:59AM +0100, Russell King wrote:
> On Tue, Oct 19, 2004 at 10:22:38AM +0100, Matthew Wilcox wrote:
> > BTW, we could just force everyone to add it themselves by merging this
> > patch:
> 
> IRQ_NONE?  What's that?  We're talking about NO_IRQ here.

Er, sorry.  Hand-edited patch (it's currently SERIAL_IRQ_NONE in my tree)
and insomnia aren't a great mix.  Let's all assume I meant NO_IRQ.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
