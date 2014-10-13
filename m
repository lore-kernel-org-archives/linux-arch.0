From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Mon, 13 Oct 2014 10:45:24 +0530
Message-ID: <87d29w1rf7.fsf@linux.vnet.ibm.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org> <1411740233-28038-2-git-send-email-steve.capper@linaro.org> <20141002121902.GA2342@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:35847 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbaJMFPi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Oct 2014 01:15:38 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Mon, 13 Oct 2014 15:15:36 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id BBF852BB0040
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 16:15:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9D4uv0Q46006294
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 15:56:57 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9D5FUlT025862
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2014 16:15:31 +1100
In-Reply-To: <20141002121902.GA2342@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com

Andrea Arcangeli <aarcange@redhat.com> writes:

> Hi Steve,
>
> On Fri, Sep 26, 2014 at 03:03:48PM +0100, Steve Capper wrote:
>> This patch provides a general RCU implementation of get_user_pages_fast
>> that can be used by architectures that perform hardware broadcast of
>> TLB invalidations.
>> 
>> It is based heavily on the PowerPC implementation by Nick Piggin.
>
> It'd be nice if you could also at the same time apply it to sparc and
> powerpc in this same patchset to show the effectiveness of having a
> generic version. Because if it's not a trivial drop-in replacement,
> then this should go in arch/arm* instead of mm/gup.c...

on ppc64 we have one challenge, we do need to support hugepd. At the pmd
level we can have hugepte, normal pmd pointer or a pointer to hugepage
directory which is used in case of some sub-architectures/platforms. ie,
the below part of gup implementation in ppc64

else if (is_hugepd(pmdp)) {
	if (!gup_hugepd((hugepd_t *)pmdp, PMD_SHIFT,
			addr, next, write, pages, nr))
		return 0;


-aneesh
