Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:52462 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbaJNMI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Oct 2014 08:08:56 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Tue, 14 Oct 2014 17:38:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <20141014115854.GA32351@linaro.org>
References: <1413284274-13521-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <20141014115854.GA32351@linaro.org>
Date: Tue, 14 Oct 2014 17:38:43 +0530
Message-ID: <8738aqonuc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20141014120843.WLw39_r-2bzy7xphfIFD6rsmKElq6QG56NhonbTDuZQ@z>

Steve Capper <steve.capper@linaro.org> writes:

> On Tue, Oct 14, 2014 at 04:27:53PM +0530, Aneesh Kumar K.V wrote:
>> get_user_pages_fast attempts to pin user pages by walking the page
>> tables directly and avoids taking locks. Thus the walker needs to be
>> protected from page table pages being freed from under it, and needs
>> to block any THP splits.
>> 
>> One way to achieve this is to have the walker disable interrupts, and
>> rely on IPIs from the TLB flushing code blocking before the page table
>> pages are freed.
>> 
>> On some platforms we have hardware broadcast of TLB invalidations, thus
>> the TLB flushing code doesn't necessarily need to broadcast IPIs; and
>> spuriously broadcasting IPIs can hurt system performance if done too
>> often.
>> 
>> This problem has been solved on PowerPC and Sparc by batching up page
>> table pages belonging to more than one mm_user, then scheduling an
>> rcu_sched callback to free the pages. This RCU page table free logic
>> has been promoted to core code and is activated when one enables
>> HAVE_RCU_TABLE_FREE. Unfortunately, these architectures implement
>> their own get_user_pages_fast routines.
>> 
>> The RCU page table free logic coupled with a an IPI broadcast on THP
>> split (which is a rare event), allows one to protect a page table
>> walker by merely disabling the interrupts during the walk.
>> 
>> This patch provides a general RCU implementation of get_user_pages_fast
>> that can be used by architectures that perform hardware broadcast of
>> TLB invalidations.
>> 
>> It is based heavily on the PowerPC implementation.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> 
>> NOTE: I kept the description of patch as it is and also retained the documentation.
>> I also dropped the tested-by and other SOB, because i was not sure whether they want
>> to be blamed for the bugs here. Please feel free to update.
>
> Hi Aneesh,
> Thank you for coding this up.
>
> I've compiled and briefly tested this on arm (with and without LPAE),
> and arm64. I ran a custom futex on THP tail test, and this passed.
> I'll test this a little more aggressively with ltp.
>
> I think Linus has already pulled in the RCU gup I posted, could you
> please instead write a patch against?

Will do that. 

> 2667f50 mm: introduce a general RCU get_user_pages_fast()

In that patch don't you need to check the _PAGE_PRESENT details in case
of gup_huge_pmd ?


-aneesh

