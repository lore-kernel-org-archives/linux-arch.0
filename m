From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
Date: Mon, 30 Sep 2019 14:47:54 -0700
Message-ID: <8534727b-72ed-b974-219e-02155bcd17a8@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-2-leonardo@linux.ibm.com>
 <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
 <2533a13f226a6e1fab387669b6cced2aa8d2e129.camel@linux.ibm.com>
 <48bf32ca-5d3e-5d69-4cd1-6720364a0d81@nvidia.com>
 <673bcb94b7752e086cc4133fb6cceb24394c02c0.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <673bcb94b7752e086cc4133fb6cceb24394c02c0.camel@linux.ibm.com>
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
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Keith Busch <keith.busch@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Allison Randal <allison@lohutok.net>
List-Id: linux-arch.vger.kernel.org

On 9/30/19 11:42 AM, Leonardo Bras wrote:
> On Mon, 2019-09-30 at 10:57 -0700, John Hubbard wrote:
>>> As I told before, there are cases where this function is called from
>>> 'real mode' in powerpc, which doesn't disable irqs and may have a
>>> tricky behavior if we do. So, encapsulate the irq disable in this
>>> function can be a bad choice.
>>
>> You still haven't explained how this works in that case. So far, the
>> synchronization we've discussed has depended upon interrupt disabling
>> as part of the solution, in order to hold off page splitting and page
>> table freeing.
> 
> The irqs are already disabled by another mechanism (hw): MSR_EE=0.
> So, serialize will work as expected.

I get that they're disabled. But will this interlock with the code that
issues IPIs?? Because it's not just disabling interrupts that matters, but
rather, synchronizing with the code (TLB flushing) that *happens* to 
require issuing IPIs, which in turn interact with disabling interrupts.

So I'm still not seeing how that could work here, unless there is something
interesting about the smp_call_function_many() on ppc with MSR_EE=0 mode...?

> 
>> Simply skipping that means that an additional mechanism is required...which
>> btw might involve a new, ppc-specific routine, so maybe this is going to end
>> up pretty close to what I pasted in after all...
>>> Of course, if we really need that, we can add a bool parameter to the
>>> function to choose about disabling/enabling irqs.
>>>> * This is really a core mm function, so don't hide it away in arch layers.
>>>>     (If you're changing mm/ files, that's a big hint.)
>>>
>>> My idea here is to let the arch decide on how this 'register' is going
>>> to work, as archs may have different needs (in powerpc for example, we
>>> can't always disable irqs, since we may be in realmode).

Yes, the tension there is that a) some things are per-arch, and b) it's easy 
to get it wrong. The commit below (d9101bfa6adc) is IMHO a perfect example of
that.

So, I would like core mm/ functions that guide the way, but the interrupt
behavior complicates it. I think your original passing of just struct_mm
is probably the right balance, assuming that I'm wrong about interrupts.


>>>
>>> Maybe we can create a generic function instead of a dummy, and let it
>>> be replaced in case the arch needs to do so.
>>
>> Yes, that might be what we need, if it turns out that ppc can't use this
>> approach (although let's see about that).
>>
> 
> I initially used the dummy approach because I did not see anything like
> serialize in other archs. 
> 
> I mean, even if I put some generic function here, if there is no
> function to use the 'lockless_pgtbl_walk_count', it becomes only a
> overhead.
> 

Not really: the memory barrier is required in all cases, and this code
would be good I think:

+void register_lockless_pgtable_walker(struct mm_struct *mm)
+{
+#ifdef LOCKLESS_PAGE_TABLE_WALK_TRACKING
+       atomic_inc(&mm->lockless_pgtbl_nr_walkers);
+#endif
+       /*
+        * This memory barrier pairs with any code that is either trying to
+        * delete page tables, or split huge pages.
+        */
+       smp_mb();
+}
+EXPORT_SYMBOL_GPL(gup_fast_lock_acquire);

And this is the same as your original patch, with just a minor name change:

@@ -2341,9 +2395,11 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
        if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
            gup_fast_permitted(start, end)) {
+               register_lockless_pgtable_walker(current->mm);
                local_irq_save(flags);
                gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
                local_irq_restore(flags);
+               deregister_lockless_pgtable_walker(current->mm);


Btw, hopefully minor note: it also looks like there's a number of changes in the same 
area that conflict, for example:

    commit d9101bfa6adc ("powerpc/mm/mce: Keep irqs disabled during lockless 
         page table walk") <Aneesh Kumar K.V> (Thu, 19 Sep 2019)

...so it would be good to rebase this onto 5.4-rc1, now that that's here.


thanks,
-- 
John Hubbard
NVIDIA
