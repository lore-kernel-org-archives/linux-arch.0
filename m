From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC PATCH] linker script: unify usage of discard definition
Date: Sun, 5 Jul 2009 00:37:17 +0900
Message-ID: <20090704153717.GA9933@linux-sh.org>
References: <4A4E9638.20304@kernel.org> <8bd0f97a0907032251p753527e1oac25ea1740a1bfdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:36449 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZGDPhY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jul 2009 11:37:24 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a0907032251p753527e1oac25ea1740a1bfdb@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Sam Ravnborg <sam@ravnborg.org>, Tony Luck <tony.luck@intel.com>

On Sat, Jul 04, 2009 at 01:51:04AM -0400, Mike Frysinger wrote:
> On Fri, Jul 3, 2009 at 19:37, Tejun Heo wrote:
> > +/*
> > + * DISCARDS must be the last and archs which want some of the default
> > + * discarded sections in the kernel image can do so by putting them in
> > + * earlier section definition.
> > + */
> 
> i would add to the comment that some people want to discard exit
> text/data at runtime rather than link time due to cross-section
> references such as alt instructions, bug table, eh_frame, etc...
> 
> otherwise, looks good to me.  thanks !
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>

Agreed, as this was a source of confusion initially it is certainly worth
documenting the next time someone is scratching their head thinking about
the variations ;-)

Acked-by: Paul Mundt <lethal@linux-sh.org>
