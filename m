Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:59336 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaC0GUQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Mar 2014 02:20:16 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Thu, 27 Mar 2014 11:50:13 +0530
Message-ID: <5333C315.3000405@linux.vnet.ibm.com>
Date: Thu, 27 Mar 2014 11:50:05 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com> <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com> <20140325173605.GA21411@node.dhcp.inet.fi>
In-Reply-To: <20140325173605.GA21411@node.dhcp.inet.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org
Message-ID: <20140327062005.1AKxdUp2STtnGW358W58YzIBwKdF3Qx7KuQ_m_xSWYs@z>

On Tuesday 25 March 2014 11:06 PM, Kirill A. Shutemov wrote:
> On Tue, Mar 25, 2014 at 12:20:15PM +0530, Madhavan Srinivasan wrote:
>> Kirill A. Shutemov with the commit 96bacfe542 introduced
>> vm_ops->map_pages() for mapping easy accessible pages around
>> fault address in hope to reduce number of minor page faults.
>> Based on his workload runs, suggested FAULT_AROUND_ORDER
>> (knob to control the numbers of pages to map) is 4.
>>
>> This patch moves the FAULT_AROUND_ORDER macro to arch/ for
>> architecture maintainers to decide on suitable FAULT_AROUND_ORDER
>> value based on performance data for that architecture.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pgtable.h |    6 ++++++
>>  arch/x86/include/asm/pgtable.h     |    5 +++++
>>  include/asm-generic/pgtable.h      |   10 ++++++++++
>>  mm/memory.c                        |    2 --
>>  4 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 3ebb188..9fcbd48 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -19,6 +19,12 @@ struct mm_struct;
>>  #endif
>>  
>>  /*
>> + * With a few real world workloads that were run,
>> + * the performance data showed that a value of 3 is more advantageous.
>> + */
>> +#define FAULT_AROUND_ORDER	3
>> +
>> +/*
>>   * We save the slot number & secondary bit in the second half of the
>>   * PTE page. We use the 8 bytes per each pte entry.
>>   */
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 938ef1d..8387a65 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -7,6 +7,11 @@
>>  #include <asm/pgtable_types.h>
>>  
>>  /*
>> + * Based on Kirill's test results, fault around order is set to 4
>> + */
>> +#define FAULT_AROUND_ORDER 4
>> +
>> +/*
>>   * Macro to mark a page protection value as UC-
>>   */
>>  #define pgprot_noncached(prot)					\
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index 1ec08c1..62f7f07 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -7,6 +7,16 @@
>>  #include <linux/mm_types.h>
>>  #include <linux/bug.h>
>>  
>> +
>> +/*
>> + * Fault around order is a control knob to decide the fault around pages.
>> + * Default value is set to 0UL (disabled), but the arch can override it as
>> + * desired.
>> + */
>> +#ifndef FAULT_AROUND_ORDER
>> +#define FAULT_AROUND_ORDER	0UL
>> +#endif
> 
> FAULT_AROUND_ORDER == 0 case should be handled separately in
> do_read_fault(): no reason to go to do_fault_around() if we are going to
> fault in only one page.
> 

ok agreed. I am thinking of adding FAULT_AROUND_ORDER check with
map_pages check in the do_read_fault. Kindly share your thoughts.

With regards
Maddy

