Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262183AbUJZCUK@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:40160 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262145AbUJZCRv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2004 22:17:51 -0400
Date: Mon, 25 Oct 2004 19:17:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] Add NO_IRQ to all architectures
Message-ID: <20041026021746.GC17038@holomorphy.com>
References: <1098756491.17886.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098756491.17886.18.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 26, 2004 at 12:08:11PM +1000, Benjamin Herrenschmidt wrote:
> Here'd a patch adding a definition of NO_IRQ to all archs
include/asm-*/irq.h. This patch currently defines it to (-1) for all
> archs. IRQ numbers are randomly stored in int's, unsigned int's, or
> all sort of things all over the kernel, but that shouldn't be a
> problem in most cases. NO_IRQ is mostly to be used within a given
> driver, to identify a device for which it has no IRQ assigned. This
> concerns relatively few drivers, like 8250 or IDE.
> At this point, I do _not_ intend to fix the probe_irq_*() API to
> return NO_IRQ instead of 0, that could be done in a second step (or
> x86 NO_IRQ could simply be defined to be 0 ...), but I will fix IDE
> in a subsequent patch.
> It would be nice though if things could slowly get fixed to deal with
> it in a better way.

Maybe wrapping the numbers in a struct for strict typechecking given
some config option, eventually making it mandatory once enough drivers
are swept would make sense.


-- wli
