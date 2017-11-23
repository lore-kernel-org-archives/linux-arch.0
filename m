Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbdKWNHG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Nov 2017 08:07:06 -0500
Subject: Re: MPK: pkey_free and key reuse
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <e7d1e622-bbac-2750-2895-cc151458ff2f@linux.intel.com>
 <48ac42c0-4c31-cef8-a75a-8f3beab7cc66@redhat.com>
 <633b5b03-3481-0da2-9d6c-f5298902e36a@linux.intel.com>
 <068b89c7-4303-88a7-540a-1491dc8a292d@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3c4aab06-af97-ccd2-ed51-a462ec251c65@suse.cz>
Date: Thu, 23 Nov 2017 14:07:03 +0100
MIME-Version: 1.0
In-Reply-To: <068b89c7-4303-88a7-540a-1491dc8a292d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171123130703.FRfkhXQ6vzlzkcNsCEWH0914VaEiQMva6thQGWVzgE0@z>

On 11/23/2017 01:48 PM, Florian Weimer wrote:
>>>> Using the malloc() analogy, we
>>>> don't expect that free() in one thread actively takes away references to
>>>> the memory held by other threads.
>>>
>>> But malloc/free isn't expected to be a partial antidote to random
>>> pointer scribbling.
>>
>> Nor is protection keys intended to be an antidote for use-after-free.
> 
> I'm comparing this to munmap, which is actually such an antidote 
> (because it involves an IPI to flush all CPUs which could have seen the 
> mapping before).
> 
> I'm surprised that pkey_free doesn't perform a similar broadcast.

Hmm, I'm not sure this comparison is accurate. IPI flushes in unmap are
done because the shared page tables were updated, and TLB's in other
cpu's might be stale. The closest pkey equivalent would be allocating a
new pkey that only my thread can use, and then using it in
pkey_mprotect() to change some memory region. Then other threads will
lose access and I believe IPI's will be issued and existing TLB mappings
in other cpu's removed.

pkey_remove() has AFAICS two potential problems:
- the key is still used in some page tables. Scanning them all and
resetting to 0 would be rather expensive. Maybe we could maintain
per-pkey counters (for pkey != 0) in the mm, which might not be that
expensive, and refuse pkey_free() if the counter is not zero?
- the key is still "used" by other threads in their PKRU. Here I would
think that if kernel doesn't broadcast pkey_alloc() to other threads, it
also shouldn't broadcast the freeing? We also can't track per-pkey
"threads using pkey" counters, as WRPKRU is pure userspace.
