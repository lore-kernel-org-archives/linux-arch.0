Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36146 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757599Ab1FGViF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Jun 2011 17:38:05 -0400
Subject: Re: [PATCHES v3] pci/of: Generic PCI <-> OF matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20110607090559.149f611b@jbarnes-desktop>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
	 <1307426323.2874.157.camel@pasglop>
	 <20110607090559.149f611b@jbarnes-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Jun 2011 07:37:43 +1000
Message-ID: <1307482663.2874.171.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de, bigeasy@linutronix.de, linux-pci@vger.kernel.org
Message-ID: <20110607213743.MJLWn9ztINtRR3N0nURg1vd8kCtPdNkghyGs6lhPdrc@z>


> > No significant changes (other than a rebase) nor new feedback since last
> > time, I've also added a few acks I got. But not worth spamming the list
> > with a re-post.
> > 
> > I'd like this to go into -next now so it can hit the next merge window,
> > unless somebody objects.
> > 
> > I've put the series in a branch "of-pci" of my powerpc.git repo at:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git of-pci
> > 
> > Please let me know if you're ok (and maybe give me Ack's) and I'll ask
> > Stephen to add it to next.
> 
> Yeah, the generic bits look good to me, you can add my
>   Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Great. Will do. I'll ask Stephen to that that in -next then and will ask
Linus to pull directly at the next merge window, separately from
powerpc.git (tho I might actually end up pulling that tree into
powerpc.git too as I might end up with stuff that depends on it).

Cheers,
Ben.

