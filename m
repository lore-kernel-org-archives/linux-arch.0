Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:39161 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975AbXJ0VHW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Oct 2007 17:07:22 -0400
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20071027201429.GE9816@martell.zuzino.mipt.ru>
References: <20071020235546.GB1825@martell.zuzino.mipt.ru>
	 <Pine.LNX.4.64.0710272114590.1818@scrub.home>
	 <20071027201429.GE9816@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Sat, 27 Oct 2007 23:07:13 +0200
Message-Id: <1193519234.27652.21.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2007-10-28 at 00:14 +0400, Alexey Dobriyan wrote:
> On Sat, Oct 27, 2007 at 09:20:43PM +0200, Roman Zippel wrote:
> > On Sun, 21 Oct 2007, Alexey Dobriyan wrote:
> > 
> > > So far remedies were:
> > > a) grep(1) -- obviously fragile. I tried at some point grepping for
> > >    spin_lock_irqsave(), found quite a few, but it became booooring quickly.
> > > b) BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long)) -- was tried,
> > >    brutally broke some arches, survived one commit before revert :^)
> > >    Doesn't work on i386 where sizeof(unsigned int) == sizeof(unsigned long).
> > > 
> > > So it would be nice to have something more robust.
> > 
> > If it's just about the type checking, something like below should pretty 
> > much do the same.
> 
> It won't catch, the following if both variables are unsigned long:
> 
> 	spin_lock_irqsave(&lock, flags);
> 		[stuff]
> 	spin_unlock_irqrestore(&lock, foo->flags);
> 
> It won't catch "static unsigned long flags;". With sparse, we can
> eventually mark type as "on-stack only".

> > +static __always_inline void __irq_flags_check(unsigned long *flags)
> > +{
+	BUILD_BUG_ON(!__builtin_stack_addr(flags));
> > +}
> > +

obviously gcc doesn't (yet) support that __builtin function, but you
could make it work for sparse and define a dummy for gcc.

