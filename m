From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] powerpc/pseries: init fault_around_order for pseries
Date: Tue, 29 Apr 2014 15:06:53 +0530
Message-ID: <535F72B5.3000405@linux.vnet.ibm.com>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com> <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com> <877g686fpb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <877g686fpb.fsf@rustcorp.com.au>
Sender: owner-linux-mm@kvack.org
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org, dave.hansen@intel.com
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
