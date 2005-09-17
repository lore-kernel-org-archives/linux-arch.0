Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: clear_user_highpage()
From: Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0408221245380.17766@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	 <20040812004654.GX11200@holomorphy.com>
	 <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
	 <20040813144115.4c59a2f0.davem@redhat.com>
	 <16672.45037.630064.539644@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0408221245380.17766@ppc970.osdl.org>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 21:01:55 +0200
Message-Id: <1126983715.6451.20.camel@basil.nowhere.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-08-22 at 12:51 -0700, Linus Torvalds wrote:

> I obviously love the result, since it validates my theory that it's better
> to have a nice hot "clear_page()" and avoid cache misses elsewhere. Score
> one for WAGging.

Experiences on Opteron have been similar - NT seems to be a loss 
for normal clear/copy_page.

However i liked the recent results of someone using it for
write() only by defining a special copy_from_user_uncached()
I suspect that would be even a win in most cases as long as you
don't do it for pipes, but only for file systems.

-Andi
