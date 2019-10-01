From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
Date: Tue, 1 Oct 2019 12:04:28 -0700
Message-ID: <a5e86058-7950-b832-b042-8cc864de761d@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-4-leonardo@linux.ibm.com>
 <ce0a4110-9f83-36db-dc85-6a727d30d030@nvidia.com>
 <2cebe169221ae9270963d4bc4fd8e43066745f98.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <2cebe169221ae9270963d4bc4fd8e43066745f98.camel@linux.ibm.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Keith Busch <keith.busch@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-arch.vger.kernel.org

On 10/1/19 10:56 AM, Leonardo Bras wrote:
> On Mon, 2019-09-30 at 14:51 -0700, John Hubbard wrote:
>> On 9/27/19 4:40 PM, Leonardo Bras wrote:
...
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 98f13ab37bac..7105c829cf44 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2325,6 +2325,7 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
>>>  int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>>  			  struct page **pages)
>>>  {
>>> +	struct mm_struct *mm;
>>
>> I don't think that this local variable adds any value, so let's not use it.
>> Similar point in a few other patches too.
> 
> It avoids 1 deference of current->mm, it's a little performance gain.
> 

No, it isn't. :) 

Longer answer: at this level (by which I mean, "wrote the C code, haven't looked
at the generated asm yet, and haven't done a direct perf test yet"), none of us
C programmers are entitled to imagine that we can second guess both the compiler 
and the CPU well enough to claim that  declaring a local pointer variable on the
stack will even *affect* performance, much less know which way it will go!

The compiler at -O2 will *absolutely* optimize away any local variables that
it doesn't need.

And that leads to how kernel programmers routinely decide about that kind of 
variable: "does the variable's added clarity compensate for the extra visual 
noise and for the need to manage the variable?"

Here, and in most (all?) other points in the patchset where you've added an
mm local variable, the answer is no.


>>
...	start_lockless_pgtbl_walk(mm);
>>
>> Minor: I'd like to rename this register_lockless_pgtable_walker().
>>
>>>  		local_irq_disable();
>>>  		gup_pgd_range(addr, end, gup_flags, pages, &nr);
>>>  		local_irq_enable();
>>> +		end_lockless_pgtbl_walk(mm);
>>
>> ...and deregister_lockless_pgtable_walker().
>>
> 
> I have no problem changing the name, but I don't register/deregister
> are good terms for this. 
> 
> I would rather use start/finish, begin/end, and so on. Register sounds
> like something more complicated than what we are trying to achieve
> here. 
> 

OK, well, I don't want to bikeshed on naming more than I usually do, and 
what you have is reasonable, so I'll leave that alone. :)

thanks,
-- 
John Hubbard
NVIDIA
