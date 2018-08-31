From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Date: Fri, 31 Aug 2018 13:42:10 +0900
Message-ID: <20180831134210.0cdadcff14ba063fa0d93abd@kernel.org>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-3-namit@vmware.com>
        <20180829184925.64caee4dadf705080373f84f@kernel.org>
        <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
        <20180830103859.ac309b71c53d267da2f6e9f8@kernel.org>
        <EEEC1254-F6CA-4E08-AAFC-CFABE5FE51B3@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EEEC1254-F6CA-4E08-AAFC-CFABE5FE51B3@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 29 Aug 2018 18:59:52 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> 
> 
> > On Aug 29, 2018, at 6:38 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > On Wed, 29 Aug 2018 08:41:00 -0700
> > Andy Lutomirski <luto@kernel.org> wrote:
> > 
> >>> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>> On Wed, 29 Aug 2018 01:11:43 -0700
> >>> Nadav Amit <namit@vmware.com> wrote:
> >>> 
> >>>> From: Andy Lutomirski <luto@kernel.org>
> >>>> 
> >>>> Sometimes we want to set a temporary page-table entries (PTEs) in one of
> >>>> the cores, without allowing other cores to use - even speculatively -
> >>>> these mappings. There are two benefits for doing so:
> >>>> 
> >>>> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
> >>>> in other cores. This hardens the security as it prevents exploding a
> >>>> dangling pointer to overwrite sensitive data using the sensitive PTE.
> >>>> 
> >>>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> >>>> remote page-tables.
> >>>> 
> >>>> To do so a temporary mm_struct can be used. Mappings which are private
> >>>> for this mm can be set in the userspace part of the address-space.
> >>>> During the whole time in which the temporary mm is loaded, interrupts
> >>>> must be disabled.
> >>>> 
> >>>> The first use-case for temporary PTEs, which will follow, is for poking
> >>>> the kernel text.
> >>>> 
> >>>> [ Commit message was written by Nadav ]
> >>>> 
> >>>> Cc: Andy Lutomirski <luto@kernel.org>
> >>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >>>> Cc: Kees Cook <keescook@chromium.org>
> >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>> Signed-off-by: Nadav Amit <namit@vmware.com>
> >>>> ---
> >>>> arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
> >>>> 1 file changed, 20 insertions(+)
> >>>> 
> >>>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> >>>> index eeeb9289c764..96afc8c0cf15 100644
> >>>> --- a/arch/x86/include/asm/mmu_context.h
> >>>> +++ b/arch/x86/include/asm/mmu_context.h
> >>>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
> >>>>      return cr3;
> >>>> }
> >>>> 
> >>>> +typedef struct {
> >>>> +     struct mm_struct *prev;
> >>>> +} temporary_mm_state_t;
> >>>> +
> >>>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> >>>> +{
> >>>> +     temporary_mm_state_t state;
> >>>> +
> >>>> +     lockdep_assert_irqs_disabled();
> >>>> +     state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> >>>> +     switch_mm_irqs_off(NULL, mm, current);
> >>>> +     return state;
> >>>> +}
> >>> 
> >>> Hmm, why don't we return mm_struct *prev directly?
> >> 
> >> I did it this way to make it easier to add future debugging stuff
> >> later. Also, when I first wrote this, I stashed the old CR3 instead
> >> of the old mm_struct, and it seemed like callers should be insulated
> >> from details like this.
> > 
> > Hmm, I see. But in that case, we should call it "struct temporary_mm"
> > and explicitly allocate (and pass) it, since we can not return the
> > data structure from stack.
> 
> Why not?

Ah, ok as far as it returns a data structure as immediate value.
(I don't recommend it because it hides a copy..)

> 
> > If we can combine it with new mm, it will
> > be more encapsulated e.g.
> > 
> > struct temporary_mm {
> >    struct mm_struct *mm;
> >    struct mm_struct *prev;
> > };
> > 
> > static struct temporary_mm poking_tmp_mm;
> > 
> > poking_init()
> > {
> >    if (init_temporary_mm(&tmp_mm, &init_mm))
> >        goto error;
> >    ...
> > }
> > 
> > text_poke_safe()
> > {
> >    ...
> >    use_temporary_mm(&tmp_mm);
> >    ...
> >    unuse_temporary_mm(&tmp_mm);
> > }
> > 
> > Any thought?
> 
> That seems more complicated for not very much gain.

Hmm, OK. anyway that is just a style note. The code itself looks good for me.

Thank you,

> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
