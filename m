From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Mon, 13 Oct 2014 12:06:18 -0400 (EDT)
Message-ID: <20141013.120618.1470323732942174784.davem@davemloft.net>
References: <87d29w1rf7.fsf@linux.vnet.ibm.com>
	<20141013.012146.992477977260812742.davem@davemloft.net>
	<20141013114428.GA28113@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60979 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbaJMQGW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Oct 2014 12:06:22 -0400
In-Reply-To: <20141013114428.GA28113@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: steve.capper@linaro.org
Cc: aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com

From: Steve Capper <steve.capper@linaro.org>
Date: Mon, 13 Oct 2014 12:44:28 +0100

> Also, as a heads up for Sparc. I don't see any definition of
> __get_user_pages_fast. Does this mean that a futex on THP tail page
> can cause an infinite loop?

I have no idea, I didn't realize this was required to be implemented.
