From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date: Thu, 26 Mar 2020 13:39:03 -0700
Message-ID: <202003261335.CC263EF@keescook>
References: <20200326193021.255002-1-hjl.tools@gmail.com>
 <20200326201142.GJ11398@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50360 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCZUjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2020 16:39:07 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so2971324pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2020 13:39:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200326201142.GJ11398@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Sami Tolvanen <samitolvanen@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>

On Thu, Mar 26, 2020 at 09:11:42PM +0100, Borislav Petkov wrote:
> On Thu, Mar 26, 2020 at 12:30:20PM -0700, H.J. Lu wrote:
> > In x86 kernel, .exit.text and .exit.data sections are discarded at
> > runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> > and define it in x86 kernel linker script to keep them.
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S     |  1 +
> >  include/asm-generic/vmlinux.lds.h | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index e3296aa028fe..7206e1ac23dd 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -21,6 +21,7 @@
> >  #define LOAD_OFFSET __START_KERNEL_map
> >  #endif
> >  
> > +#define RUNTIME_DISCARD_EXIT
> >  #define EMITS_PT_NOTE
> >  #define RO_EXCEPTION_TABLE_ALIGN	16
> >  
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e00f41aa8ec4..6b943fb8c5fd 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -894,10 +894,16 @@
> >   * section definitions so that such archs put those in earlier section
> >   * definitions.
> >   */
> > +#ifdef RUNTIME_DISCARD_EXIT
> > +#define EXIT_DISCARDS
> > +#else
> > +#define EXIT_DISCARDS							\
> > +	EXIT_TEXT							\
> > +	EXIT_DATA
> > +#endif
> 
> /me goes back and reads the old thread on this...
> 
> Kees, do you expect other arches to actually need this
> RUNTIME_DISCARD_EXIT thing or was that a hypothetical thing?
> 
> /me searches more...
> 
> oh, there's a patchset from you
> 
> https://lkml.kernel.org/r/20200228002244.15240-1-keescook@chromium.org
> 
> which already contains this patch *and* an ARM64 patch which defines
> RUNTIME_DISCARD_EXIT so I'm guessing ARM64 wants to discard at runtime
> too.

Correct.

> Which leaves the question why is H.J. sending that patch separate and
> you carry it in a patchset about orphan section warning? Seems like it
> wants to be in your patchset?

I had needed the same clean up for the orphan section handling, and
since it hadn't been picked up yet, I included it in my series. I'm
still stuck addressing several review comments, so there's no reason to
wait for me: I can easily rebase once these patches land somewhere. I'd
be happy to see them in -tip.

Thanks!

-Kees

-- 
Kees Cook
