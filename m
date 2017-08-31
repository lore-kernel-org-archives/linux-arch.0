From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v8 02/28] x86/boot: Relocate definition of the initial
 state of CR0
Date: Wed, 30 Aug 2017 21:04:18 -0700
Message-ID: <1504152258.51857.8.camel@ranerica-desktop>
References: <20170819002809.111312-1-ricardo.neri-calderon@linux.intel.com>
	 <20170819002809.111312-3-ricardo.neri-calderon@linux.intel.com>
	 <20170825174133.r5xhcv5utfipsujo@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170825174133.r5xhcv5utfipsujo@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Liang Z Li <liang.z.li@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Andy Lutomirski <luto@amacapital.net>Dave Hansen <dave.hansen>
List-Id: linux-arch.vger.kernel.org

On Fri, 2017-08-25 at 19:41 +0200, Borislav Petkov wrote:

Thanks Borislav for your feedback!

> On Fri, Aug 18, 2017 at 05:27:43PM -0700, Ricardo Neri wrote:
> > Both head_32.S and head_64.S utilize the same value to initialize the
> > control register CR0. Also, other parts of the kernel might want to access
> > to this initial definition (e.g., emulation code for User-Mode Instruction
> 
> s/to //
> 
> > Prevention uses this state to provide a sane dummy value for CR0 when

I'll make this change.

> > emulating the smsw instruction). Thus, relocate this definition to a
> > header file from which it can be conveniently accessed.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
> >  arch/x86/kernel/head_32.S                   | 3 ---
> >  arch/x86/kernel/head_64.S                   | 3 ---
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> > index 185f3d10c194..aae1f2aa7563 100644
> > --- a/arch/x86/include/uapi/asm/processor-flags.h
> > +++ b/arch/x86/include/uapi/asm/processor-flags.h
> > @@ -151,5 +151,11 @@
> >  #define CX86_ARR_BASE	0xc4
> >  #define CX86_RCR_BASE	0xdc
> >  
> > +/*
> > + * Initial state of CR0 for head_32/64.S
> > + */
> 
> No need for that comment.
> 
> With the minor nitpicks addressed, you can add:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thank you! Is it necessary for me to submit a v9 with these updates?
Perhaps I can make these updates in branch for the maintainers to pull
when/if this series is ack'ed.

Thanks and BR,
Ricardo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
