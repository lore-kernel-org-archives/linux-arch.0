Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268350AbUHLCMC@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:28629 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268349AbUHLCMC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:12:02 -0400
Date: Thu, 12 Aug 2004 04:11:11 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: clear_user_highpage()
Message-ID: <20040812021111.GB14411@wotan.suse.de>
References: <20040811161537.5e24c2b6.davem@redhat.com> <1092267062.2166.19.camel@gaston> <20040811165547.4cbc98a4.davem@redhat.com> <1092269017.2136.32.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092269017.2136.32.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 12, 2004 at 10:03:37AM +1000, Benjamin Herrenschmidt wrote:
> 
> > I think dynamic-resolution timers are the way to go here.
> > Rusty was talking about something along theses lines at
> > the networking summit.
> 
> Yup, several people talked about it at KS/OLS and I think  s390 has
> some implementation already, though I hadn't time to look at it yet,
> hopefully that will happen sooner or later.

My main issue with the s390 approach is that they actually 
wanted to get rid of jiffies. That's fine for long term,
but short term it would be a big problem because it would
break everything. IMHO the way to do it would be to define
jiffies to a function and keep virtual jiffies using the CLOCK_MONOTONIC
timer. Then only tick with a low frequency for statistic ticks
and disabled for idle or when an actual event is scheduled.

I didn't have time to actually work on it, the s390 guys
are writing actual code, so they win for now :)

-Andi
