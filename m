From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Date: Wed, 29 Aug 2018 16:54:13 +0000
Message-ID: <A7F037E7-6FA1-418D-A8D9-E8752663EF86@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-3-namit@vmware.com>
 <20180829184925.64caee4dadf705080373f84f@kernel.org>
 <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
Content-Language: en-US
Content-ID: <64481C5D4380F94F95B21EF5D2D69D6C@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

at 8:41 AM, Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>> On Wed, 29 Aug 2018 01:11:43 -0700
>> Nadav Amit <namit@vmware.com> wrote:
>>=20
>>> From: Andy Lutomirski <luto@kernel.org>
>>>=20
>>> Sometimes we want to set a temporary page-table entries (PTEs) in one o=
f
>>> the cores, without allowing other cores to use - even speculatively -
>>> these mappings. There are two benefits for doing so:
>>>=20
>>> (1) Security: if sensitive PTEs are set, temporary mm prevents their us=
e
>>> in other cores. This hardens the security as it prevents exploding a
>>> dangling pointer to overwrite sensitive data using the sensitive PTE.
>>>=20
>>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>>> remote page-tables.
>>>=20
>>> To do so a temporary mm_struct can be used. Mappings which are private
>>> for this mm can be set in the userspace part of the address-space.
>>> During the whole time in which the temporary mm is loaded, interrupts
>>> must be disabled.
>>>=20
>>> The first use-case for temporary PTEs, which will follow, is for poking
>>> the kernel text.
>>>=20
>>> [ Commit message was written by Nadav ]
>>>=20
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>> arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>>> 1 file changed, 20 insertions(+)
>>>=20
>>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/=
mmu_context.h
>>> index eeeb9289c764..96afc8c0cf15 100644
>>> --- a/arch/x86/include/asm/mmu_context.h
>>> +++ b/arch/x86/include/asm/mmu_context.h
>>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast=
(void)
>>>      return cr3;
>>> }
>>>=20
>>> +typedef struct {
>>> +     struct mm_struct *prev;
>>> +} temporary_mm_state_t;
>>> +
>>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *=
mm)
>>> +{
>>> +     temporary_mm_state_t state;
>>> +
>>> +     lockdep_assert_irqs_disabled();
>>> +     state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
>>> +     switch_mm_irqs_off(NULL, mm, current);
>>> +     return state;
>>> +}
>>=20
>> Hmm, why don't we return mm_struct *prev directly?
>=20
> I did it this way to make it easier to add future debugging stuff
> later.  Also, when I first wrote this, I stashed the old CR3 instead
> of the old mm_struct, and it seemed like callers should be insulated
> from details like this.

Andy, please let me know if you want me to change it somehow, and please
provide your signed-off-by.
