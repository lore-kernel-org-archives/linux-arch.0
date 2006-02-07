Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:5861 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964859AbWBGSp3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Feb 2006 13:45:29 -0500
Date: Tue, 7 Feb 2006 10:44:35 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [patch 1/1] Fix spinlock debugging delays to not time out too early
Message-ID: <20060207184435.GA18589@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com> <200602071929.24762.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071929.24762.ak@muc.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Tue, Feb 07, 2006 at 07:29:24PM +0100, Andi Kleen wrote:
> For this case that would be ok, as long as it isn't a hour or so,
> but let's say < 1 minute.

About 9.7 seconds on ia64 for:

	for (i = 0; i < loops_per_jiffy * HZ; i++) {
		__delay(1);
	}

so yes, well under a minute.

-Tony
