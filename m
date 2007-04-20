Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39614 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993118AbXDTUN7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 16:13:59 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: larger per cpu data
Date: Fri, 20 Apr 2007 22:11:58 +0200
References: <617E1C2C70743745A92448908E030B2A015F22CB@scsmsx411.amr.corp.intel.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A015F22CB@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704202211.58419.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 20 April 2007 20:23:13 Luck, Tony wrote:
> > I heard there were some problems with ia64 have those been fixed too?
> 
> IA64 has a 64KB page allocated for each cpu for the percpu data. Right
> now we are using 28K-32K for the arch/ia64/configs/* variations.

Could that be enlarged without too much trouble?

> > Anybody would have a problem with increasing per CPU data in a
> > standard kernel by a few KB?
> 
> How many is "a few" ... and much more importantly is your few KB
> a fixed amount, or does it scale up with the number of network cards
> (or anything else that there might be a lot of on a large system)?

> A fixed extra 8-10K should be fine.  #NIC * 1K would cause problems.

There are scalable parts, but those would likely stay allocated.
==

-Andi

