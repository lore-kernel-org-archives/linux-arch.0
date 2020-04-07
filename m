Return-Path: <SRS0=OmAX=5X=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-15-yu-cheng.yu@intel.com>
 <4902a6ee-cb0f-2700-1f6d-9d756593183c@intel.com>
 <444d97c4a4f70ccbb12da5e8f7ff498b37a9f60d.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e432d102-7f69-7ba3-6146-c0165eef87e1@intel.com>
Date: Tue, 7 Apr 2020 15:21:59 -0700
MIME-Version: 1.0
In-Reply-To: <444d97c4a4f70ccbb12da5e8f7ff498b37a9f60d.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200407222159.KC4mMgtIT_vvJ-mvIpW5IpaEKm5Di33a5led1xhexqw@z>

On 4/7/20 11:14 AM, Yu-cheng Yu wrote:
> On Wed, 2020-02-26 at 16:08 -0800, Dave Hansen wrote:
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 45442d9a4f52..6daa28614327 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -772,7 +772,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  	 * If it's a COW mapping, write protect it both
>>>  	 * in the parent and the child
>>>  	 */
>>> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>>> +	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
>>> +	    arch_copy_pte_mapping(vm_flags)) {
>>>  		ptep_set_wrprotect(src_mm, addr, src_pte);
>>>  		pte = pte_wrprotect(pte);
>>>  	}
>>
>> You have to modify this because pte_write()==0 for shadow stack PTEs, right?
>>
>> Aren't shadow stack ptes *logically* writable, even if they don't have
>> the write bit set?  What would happen if we made pte_write()==1 for them?
> 
> Here the vm_flags needs to have VM_MAYWRITE, and the PTE needs to have
> _PAGE_WRITE.  A shadow stack does not have either.

I literally mean taking pte_write(), and doing something l

static inline int pte_write(pte_t pte)
{
	if (pte_present(pte) && pte_is_shadow_stack(pte))
		return 1;

        return pte_flags(pte) & _PAGE_RW;
}

Then if is_cow_mapping() returns true for shadow stack VMAs, the above
code doesn't need to change.

> To fix checking vm_flags, what about adding a "arch_is_cow_mappping()" to the
> generic is_cow_mapping()?

That makes good sense to me.

> For the PTE, the check actually tries to determine if the PTE is not already
> being copy-on-write, which is:
> 
> 	(!_PAGE_RW && !_PAGE_DIRTY_HW)
> 
> So what about making it pte_cow()?
> 
> 	/*
> 	 * The PTE is in copy-on-write status.
> 	 */
> 	static inline int pte_cow(pte_t pte)
> 	{
> 		return !(pte_flags(pte) & (_PAGE_WRITE | _PAGE_DIRTY_HW));
> 	}

... with appropriate comments that seems fine to me.
