From: Ingo Molnar <mingo@elte.hu>
Subject: Re: LMB bits
Date: Fri, 9 Jul 2010 15:51:17 +0200
Message-ID: <20100709135117.GA4602@elte.hu>
References: <1278031351-23223-1-git-send-email-yinghai@kernel.org>
 <1278659480.28659.149.camel@pasglop>
 <20100709072408.GD10743@elte.hu>
 <AANLkTikAb5UeOLmcZaHWfKEUkwgrE4sNMinkGHxxMdTl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54460 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab0GINvo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Jul 2010 09:51:44 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikAb5UeOLmcZaHWfKEUkwgrE4sNMinkGHxxMdTl@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Yinghai Lu <yinghai@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, Jul 9, 2010 at 09:24, Ingo Molnar <mingo@elte.hu> wrote:
> > * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >> So I've pushed the memblocks rename and the modified version of my patches
> >> that Yinghai produced in the "memblock" branch of the powerpc.git tree,
> >> based on top of current Linus tree.
> 
> > to Linus straight away - to get the big rename out of the way:
> >
> > ??74 files changed, 1039 insertions(+), 1039 deletions(-)
> 
> Seems I have missed that part of the discussion: why is lmb renamed?

The reason is to make it more apparent at first glance what it is all about, 
to reduce the pool of silly abbreviations that only mean something to those 
deeply involved with that code.

Thanks,

	Ingo
