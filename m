From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Mon, 22 Jun 2015 16:41:57 +0200
Message-ID: <20150622144157.GV3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-2-git-send-email-vgupta@synopsys.com>
 <20150615153029.GE3644@twins.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com>
 <20150617133358.GR3644@twins.programming.kicks-ass.net>
 <55817FDD.7060902@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53545 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbFVOmH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2015 10:42:07 -0400
Content-Disposition: inline
In-Reply-To: <55817FDD.7060902@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org

On Wed, Jun 17, 2015 at 07:40:37PM +0530, Vineet Gupta wrote:
> > I would much prefer the raw thing to remain a number; it puts you in
> > pretty much the same place as most other archs, including x86.
> 
> Sure, but that doesn't mean we start using the index of event as a raw ID. There
> are zillion ways to configure cores and the index will certainly start varying.
> Which means that user has to determine at run time (using whatever /proc/xxx) what
> crun corresponds to. Why inflict such pain on poor guy.
> 
> The current raw event, despite representing an ASCII string is still a u64 number.
> So it is not more "raw" than what others have. We can get rid of the swapping
> business when setting up a raw event, by making sure that cached values from probe
> are already in same format.
> 
> But using index as a event id is no go sorry...

Well, you're still stuck converting an 8 char ASCII string to hex, which
arguably isn't too hard, but still rather ugly.

Furthermore, the 'raw' interface is what is used to pass in hardware
configuration otherwise not exposed. If all you currently have is event
idx that's not too interesting.

However, your patch 6 already introduces event modifiers:

+#define ARC_REG_PCT_CONFIG_USER        (1 << 18)       /* count in user mode */
+#define ARC_REG_PCT_CONFIG_KERN        (1 << 19)       /* count in kernel mode */

Those should also be available through the raw interface.

That is, your perf_event_attr::config should pretty much end up in your
hardware unmodified -- with the obvious exception of things like
'interrupt enable' because we want the kernel to be in control of that.

So if you 'overload' your TYPE_RAW to mean something else entirely, you
also loose the ability to specify event modifiers not otherwise modelled
in perf.


There are things you could do though; you could for instance interpret a
!0 perf_event_attr::config1 as the name field and replace the
perf_event_attr::config's event idx with whatever comes out of that
name->idx map -- and/or require perf_event_attr::config's event idx to
be 0 in that case.

This of course assumes there will never be an other valid use for
::config1.

Alternatively you can register a second pmu "cpu_name" and interpret its
::config as the name.


Also, ideally you'd convince acme/jolsa to extend the event parser with
this 8-char ASCII format so you can do all the text munging in userspace
and not have to do the ugly you propose here.
