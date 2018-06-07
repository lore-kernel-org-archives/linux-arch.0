From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
Date: Thu, 07 Jun 2018 09:51:13 -0700
Message-ID: <1528390273.4636.28.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-3-yu-cheng.yu@intel.com>
         <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, 2018-06-07 at 09:40 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > WRUSS is a new kernel-mode instruction but writes directly
> > to user shadow stack memory.  This is used to construct
> > a return address on the shadow stack for the signal
> > handler.
> >
> > This instruction can fault if the user shadow stack is
> > invalid shadow stack memory.  In that case, the kernel does
> > fixup.
> >
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/include/asm/special_insns.h          | 44 +++++++++++++++++++++++++++
> >  arch/x86/lib/x86-opcode-map.txt               |  2 +-
> >  arch/x86/mm/fault.c                           | 13 +++++++-
> >  tools/objtool/arch/x86/lib/x86-opcode-map.txt |  2 +-
> >  4 files changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> > index 317fc59b512c..8ce532fcc171 100644
> > --- a/arch/x86/include/asm/special_insns.h
> > +++ b/arch/x86/include/asm/special_insns.h
> > @@ -237,6 +237,50 @@ static inline void clwb(volatile void *__p)
> >                 : [pax] "a" (p));
> >  }
> >
> > +#ifdef CONFIG_X86_INTEL_CET
> > +
> > +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> > +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> > +{
> > +       int err;
> > +
> 
> Please add a comment indicating what exact opcode this is.

I will fix it.

> 
> Peterz, isn't there some fancy better way we're supposed to handle the
> error return these days?
> 
> > +       asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"
> > +                    "xor %[err],%[err]\n"
> > +                    "2:\n"
> > +                    ".section .fixup,\"ax\"\n"
> > +                    "3: mov $-1,%[err]; jmp 2b\n"
> > +                    ".previous\n"
> > +                    _ASM_EXTABLE(1b, 3b)
> > +               : [err] "=a" (err)
> > +               : [val] "S" (val), [addr] "D" (addr)
> > +               : "memory");
> > +       return err;
> > +}
> > +#else
> > +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> > +{
> > +       return 0;
> 
> BUG()?  Or just omit the ifdef?  It seems unhelpful to have a stub
> function that does nothing.

I will fix it.

> 
> > +}
> > +#endif
> > +
> > +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> > +{
> > +       int err;
> > +
> 
> Comment here too, please.

OK.

> 
> > +       asm volatile("1:.byte 0x66, 0x48, 0x0f, 0x38, 0xf5, 0x37\n"
> > +                    "xor %[err],%[err]\n"
> > +                    "2:\n"
> > +                    ".section .fixup,\"ax\"\n"
> > +                    "3: mov $-1,%[err]; jmp 2b\n"
> > +                    ".previous\n"
> > +                    _ASM_EXTABLE(1b, 3b)
> > +               : [err] "=a" (err)
> > +               : [val] "S" (val), [addr] "D" (addr)
> > +               : "memory");
> > +       return err;
> > +}
> > +#endif /* CONFIG_X86_INTEL_CET */
> > +
> >  #define nop() asm volatile ("nop")
> >
> >
