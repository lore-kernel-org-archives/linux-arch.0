Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56244 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaJMFVx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Oct 2014 01:21:53 -0400
Date: Mon, 13 Oct 2014 01:21:46 -0400 (EDT)
Message-ID: <20141013.012146.992477977260812742.davem@davemloft.net>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
From: David Miller <davem@davemloft.net>
In-Reply-To: <87d29w1rf7.fsf@linux.vnet.ibm.com>
References: <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
	<20141002121902.GA2342@redhat.com>
	<87d29w1rf7.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: aneesh.kumar@linux.vnet.ibm.com
Cc: aarcange@redhat.com, steve.capper@linaro.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com
Message-ID: <20141013052146.-oXZeumcYIe0ZEAdehHXbXPjAGaDQtK6reG-EYirkSI@z>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 13 Oct 2014 10:45:24 +0530

> Andrea Arcangeli <aarcange@redhat.com> writes:
> 
>> Hi Steve,
>>
>> On Fri, Sep 26, 2014 at 03:03:48PM +0100, Steve Capper wrote:
>>> This patch provides a general RCU implementation of get_user_pages_fast
>>> that can be used by architectures that perform hardware broadcast of
>>> TLB invalidations.
>>> 
>>> It is based heavily on the PowerPC implementation by Nick Piggin.
>>
>> It'd be nice if you could also at the same time apply it to sparc and
>> powerpc in this same patchset to show the effectiveness of having a
>> generic version. Because if it's not a trivial drop-in replacement,
>> then this should go in arch/arm* instead of mm/gup.c...
> 
> on ppc64 we have one challenge, we do need to support hugepd. At the pmd
> level we can have hugepte, normal pmd pointer or a pointer to hugepage
> directory which is used in case of some sub-architectures/platforms. ie,
> the below part of gup implementation in ppc64
> 
> else if (is_hugepd(pmdp)) {
> 	if (!gup_hugepd((hugepd_t *)pmdp, PMD_SHIFT,
> 			addr, next, write, pages, nr))
> 		return 0;

Sparc has to deal with the same issue.
