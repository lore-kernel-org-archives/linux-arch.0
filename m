From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH resend] kbuild: provide include/asm/asm-prototypes.h for
 x86
Date: Mon, 21 Nov 2016 09:00:22 +0100
Message-ID: <20161121080022.GA2564@al>
References: <20161121164940.33b555ea@roar.ozlabs.ibm.com>
 <20161121063945.6586-1-kilobyte@angband.pl>
 <20161121182714.2cd5da75@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121182714.2cd5da75@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Vince Weaver <vincent.weaver@maine.edu>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 21, 2016 at 06:27:14PM +1100, Nicholas Piggin wrote:
> Hi Adam,
> 
> Thanks. I'd suggest doing x86: or x86/kbuild: prefix for the patch. Also
> possibly consider describing what the patch does at a higher level in your
> subject line, e.g.:
> 
>   x86/kbuild: enable modversions for symbols exported from asm
> 
> Also, it wouldn't hurt to add a little changelog of your own. Describe
> problem then solution, e.g.,
> 
>   Commit 4efca4ed ("kbuild: modversions for EXPORT_SYMBOL() for asm") adds
>   modversion support for symbols exported from asm files. Architectures
>   must include C-style declarations for those symbols in asm/asm-prototypes.h
>   in order for them to be versioned.
> 
>   Add these declarations for x86, and an architecture-independent file that
>   can be used for common symbols.
> 
> (if you want to use that as-is or rewrite it, no problem).
> 
> You can add Acked-by: Nicholas Piggin <npiggin@gmail.com>

Hi Adam, Nicholas,

Thanks for the patch! I have confirmed that this fixes the defconfig and
the normal .config build I use for debugging, so:

Tested-by: Peter Wu <oeter@lekensteyn.nl>

It might also be worth to mention in the changelog the user impact,
namely that kernels may fail to load modules at all when
CONFIG_MODVERSIONS=y.

Kind regards,
Peter

> Also it's not a big deal, but if you redo the patch, you could consider
> splitting it into two (first add the generic header, then the x86 header),
> but both can go via the x86 tree.
> 
> Thanks,
> Nick
> 
> On Mon, 21 Nov 2016 07:39:45 +0100
> Adam Borowski <kilobyte@angband.pl> wrote:
> 
> > Nicholas Piggin wrote:
> > > Architectures will need to have an include/asm/asm-prototypes.h that
> > > defines or #include<>s C-style prototypes for exported asm functions.
> > > We can do an asm-generic version for the common ones like memset so
> > > there's not a lot of pointless duplication there.  
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > Tested-by: Kalle Valo <kvalo@codeaurora.org>
> > ---
> >  arch/x86/include/asm/asm-prototypes.h | 12 ++++++++++++
> >  include/asm-generic/asm-prototypes.h  |  7 +++++++
> >  2 files changed, 19 insertions(+)
> >  create mode 100644 arch/x86/include/asm/asm-prototypes.h
> >  create mode 100644 include/asm-generic/asm-prototypes.h
> > 
> > diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> > new file mode 100644
> > index 0000000..ae87224
> > --- /dev/null
> > +++ b/arch/x86/include/asm/asm-prototypes.h
> > @@ -0,0 +1,12 @@
> > +#include <asm/ftrace.h>
> > +#include <asm/uaccess.h>
> > +#include <asm/string.h>
> > +#include <asm/page.h>
> > +#include <asm/checksum.h>
> > +
> > +#include <asm-generic/asm-prototypes.h>
> > +
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/special_insns.h>
> > +#include <asm/preempt.h>
> > diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
> > new file mode 100644
> > index 0000000..df13637
> > --- /dev/null
> > +++ b/include/asm-generic/asm-prototypes.h
> > @@ -0,0 +1,7 @@
> > +#include <linux/bitops.h>
> > +extern void *__memset(void *, int, __kernel_size_t);
> > +extern void *__memcpy(void *, const void *, __kernel_size_t);
> > +extern void *__memmove(void *, const void *, __kernel_size_t);
> > +extern void *memset(void *, int, __kernel_size_t);
> > +extern void *memcpy(void *, const void *, __kernel_size_t);
> > +extern void *memmove(void *, const void *, __kernel_size_t);
> 
