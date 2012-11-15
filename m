From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 38/55] ARC: Low level event capture/logging
Date: Thu, 15 Nov 2012 12:04:13 +0000
Message-ID: <201211151204.13203.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <201211121355.23947.arnd@arndb.de> <50A4C6B5.9010500@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993257Ab2KOMEX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 07:04:23 -0500
In-Reply-To: <50A4C6B5.9010500@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Thursday 15 November 2012, Vineet Gupta wrote:
> On Monday 12 November 2012 07:25 PM, Arnd Bergmann wrote:
> > On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> >> +EXPORT_SYMBOL(take_snap);
> >> +
> >> ...
> >> +EXPORT_SYMBOL(take_snap2);
> > Where are these functions called?
> 
> These are called from various parts of ARCH code, such as before
> handling signal or TLB flush etc.
> 
> > Shouldn't this all just be part of the perf module?
> 
> These are for low level ARCH specific event snapshotting. Maybe
> perf/ftrace already have some of these in the generic code which
> eventually call the ARCH APIs. Our current perf support is just husk of
> an implementation. Once we have the full perf / ftrace support this
> module - except for the even t capture part could just go away.
> OTOH, I've not seen much usage of this from loadable modules - so if you
> deem correct, I can even remove the export.
> 
> > If not, can you make the exports GPL-only?
> 
> Am I right in understanding that this is more related to discouraging
> non GPL modules "in general" than having to do with port itself.

Mostly yes. I understand that there are some reasons why people want
to mark symbols as generally available, e.g. for standard interfaces
that have traditionally been available to every module. My rule is
usually that any newly introduced symbols should be EXPORT_SYMBOL_GPL
by default, unless there is a (documented) reason to use EXPORT_SYMBOL
instead. This is particularly true for low-level interfaces like the
one here.

If you can just remove the export, that is probably the best solution.

On a related note, any global symbol (exported or not) should normally
have a prefix that identifies the subsystem it belongs to. A global
identifier like "take_snap" can potentially conflict with symbols in
other parts of the kernel.

	Arnd
