From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Date: Fri, 06 Mar 2020 10:37:13 -0800
Message-ID: <070d9d78981f0aad2baf740233e8dfc32ecd29d7.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-6-yu-cheng.yu@intel.com>
         <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d4dabb84-5636-2657-c45e-795f3f2dcbbc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2020-02-26 at 10:05 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > +# Check assembler Shadow Stack suppot
> 
> 				  ^ support
> 
> > +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > +  ifeq ($(call as-instr, saveprevssp, y),)
> > +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> > +  endif
> > +endif
> 
> Is this *just* looking for instruction support in the assembler?
> 
> We usually just .byte them, like this for pkeys:
> 
>         asm volatile(".byte 0x0f,0x01,0xee\n\t"
>                      : "=a" (pkru), "=d" (edx)
>                      : "c" (ecx));
> 
> That way everybody with old toolchains can still build the kernel (and
> run/test code with your config option on, btw...).

We used to do this for CET instructions, but after adding kernel-mode
instructions and inserting ENDBR's, the code becomes cluttered.  I also
found an earlier discussion on the ENDBR:

https://lore.kernel.org/lkml/CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/

It makes sense to let the user know early on that the system cannot support
CET and cannot build a CET-enabled kernel.

One thing we can do is to disable CET in Kconfig and not in kernel
build, which I will do in the next version.

Yu-cheng
