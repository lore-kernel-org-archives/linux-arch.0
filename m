Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:12984 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932581AbWCHVdg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 16:33:36 -0500
Date: Wed, 8 Mar 2006 13:33:35 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
Message-ID: <20060308213335.GA8131@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com> <1141695346.11401.39.camel@cog.beaverton.ibm.com> <20060307190607.GA31533@agluck-lia64.sc.intel.com> <1141760224.21582.17.camel@leatherman> <20060307224028.GA31872@agluck-lia64.sc.intel.com> <1141772520.21582.36.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141772520.21582.36.camel@leatherman>
Sender: linux-arch-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 07, 2006 at 03:01:58PM -0800, john stultz wrote:
> You are right there. The jitter handling (if I recall, basically a
> cmpxchg w/ the last read cycle value to be sure the clocksource doesn't
> go backward) wouldn't be doable in userspace, but it seems that would
> already be a pretty bad hit on performance. Is it not? And how many
> systems actually use unsycned/jittery ITCs instead of alternative mmioed
> clocksources?

Yes the cmpxchg can be painful on a large NUMA ... so those systems tend
to use a non-jittery source.  Smaller machines may not have access (as
BIOS may not describe where the HPET is), and there is also a tradeoff
since reading the "ar.itc" register is much faster[1] than reading some
bus-based clock ... so the cmpxchg may not hurt too badly if you only
have a few cpus.

> Regardless, if its really a blocking issue, I'm not opposed to putting
> the direct access methods back into the structure, or going with an
> alternative solution to make these bits doable. Ingo might have a better
> idea for this as well.

I'm always open to a "better idea" ... but if one of those fails to show up
then I'd like to have the direct access methods.

> Do you have any other issues or questions?

Not at this time.

-Tony

[1] Ok, "is less slow than" (reading ar.itc isn't "fast" either).
