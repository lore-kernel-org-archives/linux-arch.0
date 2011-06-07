From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHES v3] pci/of: Generic PCI <-> OF matching
Date: Tue, 07 Jun 2011 15:58:43 +1000
Message-ID: <1307426323.2874.157.camel@pasglop>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45532 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab1FGF7K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Jun 2011 01:59:10 -0400
In-Reply-To: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de, bigeasy@linutronix.de, linux-pci@vger.kernel.org

On Mon, 2011-04-11 at 14:12 +1000, Benjamin Herrenschmidt wrote:
> Here's a new batch. This time, I'm reasonably confident I build-tested the
> right commit-id's on sparc :-)
> 
> To sort out the sparc problem I took a slightly different approach than
> discussed. I made the new code be of_pci.c (which I enabled on sparc)
> and put the old stuff into of_pci_irq.c (which should still be disabled
> there).
> 
> I've also consolidated pci_bus_to_OF_node() while at it.

Hi Jesse !

No significant changes (other than a rebase) nor new feedback since last
time, I've also added a few acks I got. But not worth spamming the list
with a re-post.

I'd like this to go into -next now so it can hit the next merge window,
unless somebody objects.

I've put the series in a branch "of-pci" of my powerpc.git repo at:

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git of-pci

Please let me know if you're ok (and maybe give me Ack's) and I'll ask
Stephen to add it to next.

Cheers,
Ben.
