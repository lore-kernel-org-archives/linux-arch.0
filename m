Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:42393 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965072AbWBGTPz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2006 14:15:55 -0500
Date: Tue, 7 Feb 2006 20:14:18 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/1] Fix spinlock debugging delays to not time out too early
Message-ID: <20060207191418.GA28414@elte.hu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com> <200602071929.24762.ak@muc.de> <20060207184435.GA18589@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207184435.GA18589@agluck-lia64.sc.intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Luck, Tony <tony.luck@intel.com> wrote:

> On Tue, Feb 07, 2006 at 07:29:24PM +0100, Andi Kleen wrote:
> > For this case that would be ok, as long as it isn't a hour or so,
> > but let's say < 1 minute.
> 
> About 9.7 seconds on ia64 for:
> 
> 	for (i = 0; i < loops_per_jiffy * HZ; i++) {
> 		__delay(1);
> 	}
> 
> so yes, well under a minute.

yeah, that's good enough. We want to have a minimum delay of 1 second, 
because otherwise we'd be getting false positives under high load (and 
under some bad drivers). Having a larger delay is not an issue, as long 
as it's below the average hit-reset latency of users ;)

i'd expect the HPET-based __delay(1) to be the heaviest.

	Ingo
