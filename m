Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47486 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcFAQYg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2016 12:24:36 -0400
Date: Wed, 1 Jun 2016 17:24:24 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 04/17] arm: get rid of superfluous __GFP_REPEAT
Message-ID: <20160601162424.GD19428@n2100.arm.linux.org.uk>
References: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
 <1464599699-30131-5-git-send-email-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464599699-30131-5-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org
Message-ID: <20160601162424.jjP6mJMljSd21RjsDHjNYyGiHzY8EAGAqiImYq18kT8@z>

On Mon, May 30, 2016 at 11:14:46AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> PGALLOC_GFP uses __GFP_REPEAT but none of the allocation which uses
> this flag is for more than order-2. This means that this flag has never
> been actually useful here because it has always been used only for
> PAGE_ALLOC_COSTLY requests.

I hear what you say, but...

commit 8c65da6dc89ccb605d73773b1dd617e72982d971
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Nov 30 12:52:31 2013 +0000

    ARM: pgd allocation: retry on failure

    Make pgd allocation retry on failure; we really need this to succeed
    otherwise fork() can trigger OOMs.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

and that's the change which introduced this, and it did solve a problem
for me.  So I'm not happy to give an ack for this change unless someone
can tell me why adding __GFP_REPEAT back then had a beneficial effect.
Maybe there was some other bug in the MM layer in 2013 which this change
happened to solve?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
