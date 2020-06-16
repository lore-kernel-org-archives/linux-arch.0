From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/pgtable: Move extern zero_pfn outside
 __HAVE_COLOR_ZERO_PAGE
Date: Tue, 16 Jun 2020 12:04:51 +0200
Message-ID: <4ca94b8c-4817-828f-5452-aff547bc61f1@redhat.com>
References: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
 <f55dff2d-d32e-8de1-0177-e6ba713e0cd9@redhat.com>
 <19858112-8f10-493c-9873-84f2000b00b0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19858112-8f10-493c-9873-84f2000b00b0@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 16.06.20 11:48, Anshuman Khandual wrote:
> 
> 
> On 06/16/2020 01:09 PM, David Hildenbrand wrote:
>> On 16.06.20 06:08, Anshuman Khandual wrote:
>>> zero_pfn variable is required whether __HAVE_COLOR_ZERO_PAGE is enabled
>>
>> Why is that relevant for this patch?
> 
> That just states how it is organized right now wrt __HAVE_COLOR_ZERO_PAGE.
> 
>>
>>> or not. Also it should not really be declared individually in all functions
>>> where it gets used. Just move the declaration outside, which also makes it
>>> available for other potential users.
>>
>> So, all you're essentially doing is exposing zero_pfn in pgtable.h now.
> 
> Right, but it just happens in the process of consolidating three different
> instances of 'extern unsigned long zero_pfn' in the same file which are
> redundant.
> 
>>
>> If everybody should just use my_zero_pfn(), I don't really see the
>> benefit of this patch, sorry.
> 
> It consolidates redundant declarations and reduces code. We could just have
> a comment for zero_pfn stating that it should not be used directly.
> 

... or just leave it as is and have self-documenting code.

-- 
Thanks,

David / dhildenb
