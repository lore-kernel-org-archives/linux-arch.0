From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
Date: Mon, 11 Jun 2018 08:02:56 -0700
Message-ID: <1528729376.4526.0.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-3-yu-cheng.yu@intel.com>
         <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
         <20180611081704.GI12180@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611081704.GI12180@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Mon, 2018-06-11 at 10:17 +0200, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 09:40:02AM -0700, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > Peterz, isn't there some fancy better way we're supposed to handle the
> > error return these days?
> 
> > > +       asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"
> > > +                    "xor %[err],%[err]\n"
> > > +                    "2:\n"
> > > +                    ".section .fixup,\"ax\"\n"
> > > +                    "3: mov $-1,%[err]; jmp 2b\n"
> > > +                    ".previous\n"
> > > +                    _ASM_EXTABLE(1b, 3b)
> > > +               : [err] "=a" (err)
> > > +               : [val] "S" (val), [addr] "D" (addr)
> > > +               : "memory");
> 
> So the alternative is something like:
> 
> __visible bool ex_handler_wuss(const struct exception_table_entry *fixup,
> 			       struct pt_regs *regs, int trapnr)
> {
> 	regs->ip = ex_fixup_addr(fixup);
> 	regs->ax = -1L;
> 
> 	return true;
> }
> 
> 
> 	int err = 0;
> 
> 	asm volatile("1: INSN_WUSS\n"
> 		     "2:\n"
> 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wuss)
> 		     : "=a" (err)
> 		     : "S" (val), "D" (addr));
> 
> But I'm not at all sure that's actually better.

Thanks!  I will fix it.

Yu-cheng
