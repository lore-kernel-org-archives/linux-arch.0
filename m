From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above
 47-bits
Date: Fri, 24 Mar 2017 14:44:10 +0530
Message-ID: <d1007940-5066-4fcf-9744-0bb0514b33d4@linux.vnet.ibm.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
 <8760j4sfcz.fsf@skywalker.in.ibm.com>
 <20170324090408.xsj7othssj547w5k@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54915 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934826AbdCXJOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Mar 2017 05:14:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2O9913M107133
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2017 05:14:22 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29cpeusu4x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2017 05:14:21 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Fri, 24 Mar 2017 03:14:21 -0600
In-Reply-To: <20170324090408.xsj7othssj547w5k@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org



On Friday 24 March 2017 02:34 PM, Kirill A. Shutemov wrote:
> On Mon, Mar 20, 2017 at 10:40:20AM +0530, Aneesh Kumar K.V wrote:
>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>>  @@ -168,6 +182,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>>>  	unsigned long addr = addr0;
>>>  	struct vm_unmapped_area_info info;
>>>
>>> +	addr = mpx_unmapped_area_check(addr, len, flags);
>>> +	if (IS_ERR_VALUE(addr))
>>> +		return addr;
>>> +
>>>  	/* requested length too big for entire address space */
>>>  	if (len > TASK_SIZE)
>>>  		return -ENOMEM;
>>> @@ -192,6 +210,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>>>  	info.length = len;
>>>  	info.low_limit = PAGE_SIZE;
>>>  	info.high_limit = mm->mmap_base;
>>> +
>>> +	/*
>>> +	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
>>> +	 * in the full address space.
>>> +	 */
>>> +	if (addr > DEFAULT_MAP_WINDOW)
>>> +		info.high_limit += TASK_SIZE - DEFAULT_MAP_WINDOW;
>>> +
>>
>> Is this ok for 32 bit application ?
>
> DEFAULT_MAP_WINDOW is equal to TASK_SIZE on 32-bit, so it's nop and will
> be compile out.
>

That is not about CONFIG_X86_32 but about 32 bit application on a 64 bit 
kernel. I guess we will never find addr > DEFAULT_MAP_WINDOW with
a 32 bit app ?

-aneesh
