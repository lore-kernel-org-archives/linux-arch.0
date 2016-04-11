From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 06/19] arc: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 14:23:42 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E9D497@us01wembx1.internal.synopsys.com>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <1460372892-8157-7-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49300 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbcDKOXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2016 10:23:45 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Monday 11 April 2016 04:38 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
>
> pte_alloc_one_kernel uses __get_order_pte but this is obviously
> always zero because BITS_FOR_PTE is not larger than 9 yet the page
> size is always larger than 4K.  This means that this flag has never
> been actually useful here because it has always been used only for
> PAGE_ALLOC_COSTLY requests.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
