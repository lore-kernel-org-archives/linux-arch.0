From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Tue, 1 Oct 2019 11:52:11 -0700
Message-ID: <28e680b6-1da4-70c6-4345-b3b2eaae48fd@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-2-leonardo@linux.ibm.com>
 <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
 <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
 <48bf32ca-5d3e-5d69-4cd1-6720364a0d81@nvidia.com>
 <673bcb94b7752e086cc4133fb6cceb24394c02c0.camel@linux.ibm.com>
 <8534727b-72ed-b974-219e-02155bcd17a8@nvidia.com>
 <9cd8e83334047b9144133781be9abd25a5678f3d.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <9cd8e83334047b9144133781be9abd25a5678f3d.camel@linux.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Leonardo Bras <leonardo@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Keith Busch <keith.busch@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: linux-arch.vger.kernel.org

On 10/1/19 11:39 AM, Leonardo Bras wrote:
> On Mon, 2019-09-30 at 14:47 -0700, John Hubbard wrote:
>> On 9/30/19 11:42 AM, Leonardo Bras wrote:
>>> On Mon, 2019-09-30 at 10:57 -0700, John Hubbard wrote:
...
> 
> I am failing to understand the issue.
> I mean, smp_call_function_many() will issue a IPI to each CPU in
> CPUmask and wait it to run before returning. 
> If interrupts are disabled (either by MSR_EE=0 or local_irq_disable),
> the IPI will not run on that CPU, and the wait part will make sure to
> lock the thread until the interrupts are enabled again. 
> 
> Could you please point the issue there?

The biggest problem here is evidently my not knowing much about ppc. :) 
So if that's how it behaves, then all is well, sorry it took me a while
to understand the MSR_EE=0 behavior.

> 
>>>> Simply skipping that means that an additional mechanism is required...which
>>>> btw might involve a new, ppc-specific routine, so maybe this is going to end
>>>> up pretty close to what I pasted in after all...
>>>>> Of course, if we really need that, we can add a bool parameter to the
>>>>> function to choose about disabling/enabling irqs.
>>>>>> * This is really a core mm function, so don't hide it away in arch layers.
>>>>>>     (If you're changing mm/ files, that's a big hint.)
>>>>>
>>>>> My idea here is to let the arch decide on how this 'register' is going
>>>>> to work, as archs may have different needs (in powerpc for example, we
>>>>> can't always disable irqs, since we may be in realmode).
>>
>> Yes, the tension there is that a) some things are per-arch, and b) it's easy 
>> to get it wrong. The commit below (d9101bfa6adc) is IMHO a perfect example of
>> that.
>>
>> So, I would like core mm/ functions that guide the way, but the interrupt
>> behavior complicates it. I think your original passing of just struct_mm
>> is probably the right balance, assuming that I'm wrong about interrupts.
>>
> 
> I think, for the generic function, that including {en,dis}abling the
> interrupt is fine. I mean, if disabling the interrupt is the generic
> behavior, it's ok. 
> I will just make sure to explain that the interrupt {en,dis}abling is
> part of the sync process. If an arch don't like it, it can write a
> specific function that does the sync in a better way. (and defining
> __HAVE_ARCH_LOCKLESS_PGTBL_WALK_COUNTER to ignore the generic function)
> 

Tentatively, that sounds good. We still end up with the counter variable
directly in struct mm_struct, and the generic function in mm/gup.c 
(or mm/somewhere), where it's easy to find and see what's going on. sure.

thanks,
-- 
John Hubbard
NVIDIA
