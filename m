Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46079 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbaJXDzQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Oct 2014 23:55:16 -0400
Date: Thu, 23 Oct 2014 23:55:11 -0400 (EDT)
Message-ID: <20141023.235511.1672975903756808524.davem@davemloft.net>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <1414107635.364.91.camel@pasglop>
References: <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
	<20141023.184035.388557314666522484.davem@davemloft.net>
	<1414107635.364.91.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com, steve.capper@linaro.org, aarcange@redhat.com, mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, hannes@cmpxchg.org
Message-ID: <20141024035511.1WiqL1CqdOnBfnggQBw474yWcoqL5uz1Atq-Vhh72uU@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Oct 2014 10:40:35 +1100

> Another option would be to make the generic code use something defined
> by the arch to decide whether to use speculative get or
> not. I like the idea of keeping the bulk of that code generic...

Me too.  We could have inlines that do either speculative or
non-speculative gets on the pages in some header file and hide
the ifdefs in there.
