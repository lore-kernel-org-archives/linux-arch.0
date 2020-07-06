From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
Date: Mon, 6 Jul 2020 14:42:59 +0200
Message-ID: <2f77487a-e92e-1a38-ffd9-e5506441d25d@redhat.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-7-catalin.marinas@arm.com>
 <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
 <20200706112057.GA6432@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729186AbgGFMnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 08:43:12 -0400
In-Reply-To: <20200706112057.GA6432@gaia>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Price <steven.price@arm.com>

On 06.07.20 13:21, Catalin Marinas wrote:
> On Mon, Jul 06, 2020 at 10:24:04AM +0200, David Hildenbrand wrote:
>> On 03.07.20 17:36, Catalin Marinas wrote:
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 6be1aa559b1e..276140c94f4a 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -135,6 +135,9 @@ enum pageflags {
>>>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
>>>  	PG_young,
>>>  	PG_idle,
>>> +#endif
>>> +#ifdef CONFIG_64BIT
>>> +	PG_arch_2,
>>>  #endif
>>>  	__NR_PAGEFLAGS,
>>
>> People are usually *very* picky when it comes to new page flags. It
>> somewhat concerns me that we bump up __NR_PAGEFLAGS for any 64bit arch.
>> That feels wrong.
> 
> It was guarded by a specific config option initially but the comments
> suggested that it could be dropped for 64-bit architectures:
> 
> https://lore.kernel.org/linux-arm-kernel/20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org/
> 
> The page flags is indeed a pretty limited resource as it also includes
> the sparsemem section, node and zone fields. However, on 64-bit this
> should be fine (the sparsemem section is gone with vmemmap support).

Right, so 64bit architectures/configs with SPARSEMEM &&
!SPARSEMEM_VMEMMAP could be affected only. I think mips would be one
example where we don't have VMEMMAP support. For most other 64bit
architectures (x86_64, s390x, powerpc, ...) SPARSEMEM_VMEMMAP should be
the default (although I've seen bug reports/configs where VMEMMAP was
disabled).

-- 
Thanks,

David / dhildenb
