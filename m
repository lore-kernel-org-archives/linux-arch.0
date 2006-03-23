Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mgate01.necel.com ([203.180.232.81]:2272 "EHLO
	mgate01.necel.com") by vger.kernel.org with ESMTP id S932204AbWCWGgw
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 01:36:52 -0500
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Date: Thu, 23 Mar 2006 15:36:25 +0900
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au> (Stephen Rothwell's message of "Thu, 23 Mar 2006 16:46:23 +1100")
Message-Id: <buofyl9llau.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

BTW, why not keep use the parisc version of the structure for the common
version, as it has comments for each field (not world breaking, but a
nice little thing)?

-miles
-- 
"Suppose we've chosen the wrong god. Every time we go to church we're
just making him madder and madder." -- Homer Simpson
