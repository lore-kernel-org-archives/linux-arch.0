Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268108AbUJSJ1p@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:22708 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268101AbUJSJ1p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 05:27:45 -0400
Subject: Re: All archs: NO_IRQ definition
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
References: <1098169077.11400.51.camel@gaston>
	 <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 10:27:39 +0100
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-10-19 at 10:22 +0100, Matthew Wilcox wrote:
> On Tue, Oct 19, 2004 at 04:57:57PM +1000, Benjamin Herrenschmidt wrote:
> > parisc
> 
> -1 for parisc, please.

And also for every arch where there isn't an overriding reason for it
_not_ to be -1. If either zero or -1 works, use -1. We'll get better
coverage of random driver authors doing 'if (!irq)' that way. 

So your question becomes: anyone whose architecture can't cope with
NO_IRQ being -1, please shout now before we break it.

> BTW, we could just force everyone to add it themselves by merging this
> patch:

Do it.

-- 
dwmw2
