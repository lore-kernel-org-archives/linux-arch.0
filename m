Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:43850 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbaD2JhF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Apr 2014 05:37:05 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Tue, 29 Apr 2014 19:37:03 +1000
Message-ID: <535F72B5.3000405@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 15:06:53 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH V3 2/2] powerpc/pseries: init fault_around_order for pseries
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com> <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com> <877g686fpb.fsf@rustcorp.com.au>
In-Reply-To: <877g686fpb.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org, dave.hansen@intel.com
Message-ID: <20140429093653.hbt-balzxaNEZlHZWlQ2sxe65w_navBrda8oe_JhXcQ@z>

On Tuesday 29 April 2014 07:48 AM, Rusty Russell wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 2db8cc6..c87e6b6 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -74,6 +74,8 @@ int CMO_SecPSP = -1;
>>  unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K);
>>  EXPORT_SYMBOL(CMO_PageSize);
>>  
>> +extern unsigned int fault_around_order;
>> +
> 
> It's considered bad form to do this.  Put the declaration in linux/mm.h.
> 

ok. Will change it.

Thanks for review
With regards
Maddy

> Thanks,
> Rusty.
> PS.  But we're getting there! :)
> 

