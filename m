Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54152 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161330AbcE3SXk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2016 14:23:40 -0400
Date: Mon, 30 May 2016 11:23:35 -0700 (PDT)
Message-ID: <20160530.112335.1376503927443399332.davem@davemloft.net>
Subject: Re: [PATCH 12/17] sparc: get rid of superfluous __GFP_REPEAT
From: David Miller <davem@davemloft.net>
In-Reply-To: <1464599699-30131-13-git-send-email-mhocko@kernel.org>
References: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
	<1464599699-30131-13-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mhocko@kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, linux-arch@vger.kernel.org
Message-ID: <20160530182335.im-QFCClnC9-380ZKtZk7gknUxAPQiyZzVovCNEqcRo@z>

From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 30 May 2016 11:14:54 +0200

> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> {pud,pmd}_alloc_one is using __GFP_REPEAT but it always allocates from
> pgtable_cache which is initialzed to PAGE_SIZE objects. This means that
> this flag has never been actually useful here because it has always been
> used only for PAGE_ALLOC_COSTLY requests.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David S. Miller <davem@davemloft.net>
