From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC 00/15] decouple pagefault_disable() from preempt_disable()
Date: Thu, 07 May 2015 12:51:22 +0200
Message-ID: <554B43AA.1050605@de.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com> <20150506150158.0a927470007e8ea5f3278956@linux-foundation.org> <20150507094819.GC4734@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150507094819.GC4734@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Am 07.05.2015 um 11:48 schrieb Ingo Molnar:
> 
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Wed,  6 May 2015 19:50:24 +0200 David Hildenbrand <dahi@linux.vnet.ibm.com> wrote:
>>
>>> As Peter asked me to also do the decoupling in one shot, this is
>>> the new series.
>>>
>>> I recently discovered that might_fault() doesn't call might_sleep()
>>> anymore. Therefore bugs like:
>>>
>>>   spin_lock(&lock);
>>>   rc = copy_to_user(...);
>>>   spin_unlock(&lock);
>>>
>>> would not be detected with CONFIG_DEBUG_ATOMIC_SLEEP. The code was
>>> changed to disable false positives for code like:
>>>
>>>   pagefault_disable();
>>>   rc = copy_to_user(...);
>>>   pagefault_enable();
>>>
>>> Whereby the caller wants do deal with failures.
>>
>> hm, that was a significant screwup.  I wonder how many bugs we
>> subsequently added.
> 
> So I'm wondering what the motivation was to allow things like:
> 
>    pagefault_disable();
>    rc = copy_to_user(...);
>    pagefault_enable();
> 
> and to declare it a false positive?
> 
> AFAICS most uses are indeed atomic:
> 
>         pagefault_disable();
>         ret = futex_atomic_cmpxchg_inatomic(curval, uaddr, uval, newval);
>         pagefault_enable();
> 
> so why not make it explicitly atomic again?

Hmm, I am probably misreading that, but it sound as you suggest to go back
to Davids first proposal
https://lkml.org/lkml/2014/11/25/436
which makes might_fault to also contain might_sleep. Correct?

Christian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
