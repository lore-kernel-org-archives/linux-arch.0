From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/20] arm: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:55:45 +0100
Message-ID: <20160428145545.GN19428@n2100.arm.linux.org.uk>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
 <1461849846-27209-5-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56546 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcD1Oz6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 10:55:58 -0400
Content-Disposition: inline
In-Reply-To: <1461849846-27209-5-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org

On Thu, Apr 28, 2016 at 03:23:50PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> PGALLOC_GFP uses __GFP_REPEAT but none of the allocation which uses
> this flag is for more than order-2. This means that this flag has never
> been actually useful here because it has always been used only for
> PAGE_ALLOC_COSTLY requests.

I'm unconvinced.  Back in 2013, I was seeing a lot of failures, so:

commit 8c65da6dc89ccb605d73773b1dd617e72982d971
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Nov 30 12:52:31 2013 +0000

    ARM: pgd allocation: retry on failure

    Make pgd allocation retry on failure; we really need this to succeed
    otherwise fork() can trigger OOMs.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Maybe something has changed again in the MM layer which makes this flag
unnecessary again, and it was a temporary blip around that time, I don't
know.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
