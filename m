Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0064.outbound.protection.outlook.com ([157.55.234.64]:21632
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753028AbcD1QV3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Apr 2016 12:21:29 -0400
Subject: Re: [PATCH 15/20] tile: get rid of superfluous __GFP_REPEAT
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
 <1461849846-27209-16-git-send-email-mhocko@kernel.org>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <7390db4d-9035-6f09-8f0d-134d2bdeccf7@mellanox.com>
Date: Thu, 28 Apr 2016 12:21:11 -0400
MIME-Version: 1.0
In-Reply-To: <1461849846-27209-16-git-send-email-mhocko@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org
Message-ID: <20160428162111.tsPBHrE6tSwfYVTCJojpD7XY3CAksZ1y4KplnoPMWAw@z>

On 4/28/2016 9:24 AM, Michal Hocko wrote:
> From: Michal Hocko<mhocko@suse.com>
>
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
>
> pgtable_alloc_one uses __GFP_REPEAT flag for L2_USER_PGTABLE_ORDER but
> the order is either 0 or 3 if L2_KERNEL_PGTABLE_SHIFT for HPAGE_SHIFT.
> This means that this flag has never been actually useful here because it
> has always been used only for PAGE_ALLOC_COSTLY requests.
>
> Cc: Chris Metcalf<cmetcalf@mellanox.com>
> Cc:linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko<mhocko@suse.com>
> ---
>   arch/tile/mm/pgtable.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

This seems OK as far as I can tell from code review.

Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

