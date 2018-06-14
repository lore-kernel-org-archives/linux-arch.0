From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
Date: Thu, 14 Jun 2018 07:43:52 -0700
Message-ID: <1528987432.13101.7.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-3-yu-cheng.yu@intel.com>
         <fb30195ed6f5ab17920938192cf0b7ef8d1d4037.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fb30195ed6f5ab17920938192cf0b7ef8d1d4037.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 2018-06-14 at 11:30 +1000, Balbir Singh wrote:
> On Thu, 2018-06-07 at 07:37 -0700, Yu-cheng Yu wrote:
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
> >  		: [pax] "a" (p));
> >  }
> >  
> > +#ifdef CONFIG_X86_INTEL_CET
> > +
> > +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> > +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> > +{
> > +	int err;
> > +
> > +	asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"
> 
> It would nice to use something like ASM_WRUSS/Q like ASM_CLAC/ASM_STAC.
> Is the 0x37 spurious? I don't see addr/val being used in the instructions
> either.
> 

Yes, this is being revised.  We are going to require a GCC and binutils
that support CET.  I will put in the WRUSS instruction, no '.byte' any
more.

Yu-cheng
