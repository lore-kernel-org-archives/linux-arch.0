From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 12 Jun 2008 09:07:16 -0600
Message-ID: <20080612150716.GX30405@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com> <200806031433.12460.nickpiggin@yahoo.com.au> <200806030952.10360.jbarnes@virtuousgeek.org> <4847A690.302@sgi.com> <1212655433.9496.109.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:56528 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYFLPHe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jun 2008 11:07:34 -0400
Content-Disposition: inline
In-Reply-To: <1212655433.9496.109.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jes Sorensen <jes@sgi.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Nick Piggin <nickpiggin@yahoo.com.au>, Jeremy Higdon <jeremy@sgi.com>, Roland Dreier <rdreier@cisco.com>, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Thu, Jun 05, 2008 at 06:43:53PM +1000, Benjamin Herrenschmidt wrote:
> Note that the powerpc implementation currently clears the flag
> on spin_lock and tests it on unlock. We are considering changing
> that to not touch the flag on spin_lock and just clear it whenever
> we do a sync (ie, on unlock, on explicit mmiowb, and possibly even
> on readl's where we happen to do sync's).

Your current scheme sounds like it's broken for

spin_lock(a)
writel();
spin_lock(b);
spin_unlock(b);
spin_unlock(a);

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
