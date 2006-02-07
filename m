Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50332 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964858AbWBGTiJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2006 14:38:09 -0500
From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 1/1] Fix spinlock debugging delays to not time out too early
Date: Tue, 7 Feb 2006 20:37:45 +0100
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com> <20060207184435.GA18589@agluck-lia64.sc.intel.com> <20060207191418.GA28414@elte.hu>
In-Reply-To: <20060207191418.GA28414@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602072037.46079.ak@muc.de>
Sender: linux-arch-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Luck, Tony" <tony.luck@intel.com>, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 07 February 2006 20:14, Ingo Molnar wrote:
> 
> * Luck, Tony <tony.luck@intel.com> wrote:
> 
> > On Tue, Feb 07, 2006 at 07:29:24PM +0100, Andi Kleen wrote:
> > > For this case that would be ok, as long as it isn't a hour or so,
> > > but let's say < 1 minute.
> > 
> > About 9.7 seconds on ia64 for:
> > 
> > 	for (i = 0; i < loops_per_jiffy * HZ; i++) {
> > 		__delay(1);
> > 	}
> > 
> > so yes, well under a minute.
> 
> yeah, that's good enough. We want to have a minimum delay of 1 second, 
> because otherwise we'd be getting false positives under high load (and 
> under some bad drivers). Having a larger delay is not an issue, as long 
> as it's below the average hit-reset latency of users ;)

This reminds me - if we can find a cheaper way than __delay(1) it 
would be actually quite reasonable to do a timeout in the non debug
spinlock. Since it's always out of line it doesn't matter if the code
is bigger and spinning cycles are free anyways, so some checks there
wouldn't matter.

Maybe go through a 32bit counter to overflow a few times? A

It's probably better longer than a second by default.

-Andi

