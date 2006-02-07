Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:47297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964850AbWBGSbb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2006 13:31:31 -0500
From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 1/1] Fix spinlock debugging delays to not time out too early
Date: Tue, 7 Feb 2006 19:29:24 +0100
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071929.24762.ak@muc.de>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 07 February 2006 19:20, Luck, Tony wrote:
> > The fix is to include a __delay(1) call in the loop, to correctly approximate
> > the intended delay timeout of 1 second.  The code assumes that every
> > architecture implements __delay(1) to last around 1/(loops_per_jiffy*HZ)
> > seconds.
> 
> But we calculate loops_per_jiffy based on somewhat larger vales passed
> to __delay() ... where the function call overhead is amortized away.
>
> I'd expect that __delay(1) would last quite a bit longer than
> 1/(loops_per_jiffy * HZ) ... so we'll wait a lot more than a
> second.

For this case that would be ok, as long as it isn't a hour or so,
but let's say < 1 minute.

-Andi

