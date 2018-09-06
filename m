From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Thu, 6 Sep 2018 11:09:23 -0700
Message-ID: <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
References: <20180902173224.30606-1-namit@vmware.com> <20180905185617.GC24082@hirez.programming.kicks-ass.net> <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com> <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com> <20180906081300.GF24082@hirez.programming.kicks-ass.net> <20180906101641.GG24142@hirez.programming.kicks-ass.net> <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com> <20180906171754.GJ24106@hirez.programming.kicks-ass.net> <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org



> On Sep 6, 2018, at 10:58 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> at 10:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>>> On Thu, Sep 06, 2018 at 05:01:25PM +0000, Nadav Amit wrote:
>>> In addition, there might be a couple of issues with your fix:
>>=20
>> It boots on my box ;-)
>>=20
>>> 1. __set_pte_vaddr() is not used exclusive by set_fixmap(). This means
>>> the warning might be wrong, but also means that these code patches (Xen=E2=
=80=99s
>>> set_pte_mfn(), CPU-entry-area setup) needs to be checked. And as you sai=
d
>>> before, someone might use this function for other purposes as well.
>>=20
>> CEA is fine, that actually needs it too.
>>=20
>> The one thing I missed out on earlier is the below chunk, that is no
>> longer needed now that cea_set_pte() actually does the right thing.
>>=20
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index b7b01d762d32..14ad97fa0749 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -293,12 +293,6 @@ static void ds_update_cea(void *cea, void *addr, siz=
e_t size, pgprot_t prot)
>> preempt_disable();
>> for (; msz < size; msz +=3D PAGE_SIZE, pa +=3D PAGE_SIZE, cea +=3D PAGE_S=
IZE)
>> cea_set_pte(cea, pa, prot);
>> -
>> - /*
>> -  * This is a cross-CPU update of the cpu_entry_area, we must shoot down=

>> -  * all TLB entries for it.
>> -  */
>> - flush_tlb_kernel_range(start, start + size);
>> preempt_enable();
>> }
>>=20
>> @@ -310,8 +304,6 @@ static void ds_clear_cea(void *cea, size_t size)
>> preempt_disable();
>> for (; msz < size; msz +=3D PAGE_SIZE, cea +=3D PAGE_SIZE)
>> cea_set_pte(cea, 0, PAGE_NONE);
>> -
>> - flush_tlb_kernel_range(start, start + size);
>> preempt_enable();
>> }
>>=20
>>=20
>>> 2. Printing the virtual address can break KASLR.
>>=20
>> Local KASLR is a myth.. but sure, we can fix the print.
>>=20
>>> 3. The WARN() can introduce some overhead since checking if IRQs are
>>> disabled takes considerably long time. Perhaps VM_WARN() or something is=

>>> better. I realize this code-path is not on the hot-path though...
>>=20
>> Yeah, if it triggers you have bigger problems. We can make it
>> WARN_ONCE() I suppose.
>>=20
>>> 4. I guess flush_tlb_kernel_range() should also have something like
>>> VM_WARN_ON(irqs_disabled()), just as an additional general sanity check.=

>>=20
>> It has, it's hidden in kernel/smp.c:smp_call_function_many().
>=20
> Right. Thanks.
>=20
>>=20
>>> Let me know if you want me to make these changes and include your patch i=
n
>>> the set.
>>=20
>> The set is no longer needed. text_poke() is fine and correct with this
>> one patch.
>=20
> It depends what security you want. Some may consider even the short
> time-window in which the kernel code is writable from other cores as
> insufficient for security.
>=20
> In addition, the set removes the need for remote TLB shootdowns that
> text_poke() - with this fix - requires.
>=20

I=E2=80=99m personally in favor of not needing a global broadcast flush to i=
nstall kprobes.=
