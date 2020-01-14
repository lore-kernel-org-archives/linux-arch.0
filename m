Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
 <20200114105002.GD2844@hirez.programming.kicks-ass.net>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 14 Jan 2020 17:58:58 +0530
MIME-Version: 1.0
In-Reply-To: <20200114105002.GD2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <ed2e6567-30db-a3c7-2973-a307bf2dfa7b@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: akpm@linux-foundation.org, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200114122858.zRdPLD3DXgsIg8iGS4OHgbif251F7xK4vKxLn1HGv3o@z>

On 1/14/20 4:20 PM, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 03:31:36PM +0530, Aneesh Kumar K.V wrote:
>> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
>> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
>> easy to backport these changes. Only the first 3 patches need to be backported to stable.
>>
>> The thing is, on anything SMP, freeing page directories should observe the
>> exact same order as normal page freeing:
>>
>>   1) unhook page/directory
>>   2) TLB invalidate
>>   3) free page/directory
>>
>> Without this, any concurrent page-table walk could end up with a Use-after-Free.
>> This is esp. trivial for anything that has software page-table walkers
>> (HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
>> (ie. caches page directories).
>>
>> Even on UP this might give issues since mmu_gather is preemptible these days.
>> An interrupt or preempted task accessing user pages might stumble into the free
>> page if the hardware caches page directories.
>>
>> This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
>> I haven't added patches w.r.t other architecture because they are yet to be acked.
> 
> Obviously looks good to me; will you route this through the Power tree
> since you're in a hurry to see this fixed?
> 

Michael,

Can you take this via your tree?

-aneesh
