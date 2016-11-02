From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Wed, 2 Nov 2016 13:11:03 +0100
Message-ID: <20161102121103.GA1879@angband.pl>
References: <20161017100130.GA16013@angband.pl>
 <871szfb1x1.fsf@gmail.com>
 <20161018001626.GA5976@angband.pl>
 <20161018123418.6121175b@roar.ozlabs.ibm.com>
 <7b7c237c-c779-f695-e320-d9e00e48d1d2@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b7c237c-c779-f695-e320-d9e00e48d1d2@suse.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 01, 2016 at 04:48:48PM +0100, Michal Marek wrote:
> > Adam Borowski <kilobyte@angband.pl> wrote:
> > 
> >> On Mon, Oct 17, 2016 at 02:22:34PM +0200, Mathieu OTHACEHE wrote:
> >>>> +#include <asm/uaccess.h>
> >>>> +#include <asm/uaccess.h>  
> >>>
> >>> Included twice.  
> >>
> >> D'oh!

This appears to be the only thing to fix, right?

> >>>> +#include <asm/string.h>
> >>>> +#include <asm/page.h>
> >>>> +#include <asm/checksum.h>
> >>>> +
> >>>> +#include <asm-generic/asm-prototypes.h>
> >>>> +
> >>>> +#include <asm/page.h>
> >>>> +#include <asm/pgtable.h>
> >>>> +#include <asm/special_insns.h>
> >>>> +#include <asm/preempt.h>  
> >>>
> >>> No <asm/arch_hweight.h> for __sw_hweight32 and __sw_hweight64 ?   
> >>
> >> diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
> >> new file mode 100644
> >> index 0000000..df13637
> >> --- /dev/null
> >> +++ b/include/asm-generic/asm-prototypes.h
> >> @@ -0,0 +1,7 @@
> >> +#include <linux/bitops.h>
> >>
> >> ... which has these.
> >>
> >> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >> } bitops.h is wrong header as well.
> >> } Why do you need bitops for bunch of function prototypes?
> >>
> >> Unless you guys prefer using low-level headers only, that is.
> > 
> > Well you can't use asm/arch_hweight.h in a generic header of course.
> > I would suggest just including linux/ variants where practical for
> > the asm-generic/asm-prototypes.h header.
> > 
> > We should probably just bring all these arch patches through the
> > kbuild tree.

I believe inclusion of <linux/bitops.h> is the right thing to do, but if
not, the patch would also need:

extern unsigned int __sw_hweight8(unsigned int w);
extern unsigned int __sw_hweight16(unsigned int w);
extern unsigned int __sw_hweight32(unsigned int w);
extern unsigned long __sw_hweight64(__u64 w);


There's also the issue of mcount/__fentry__, but that's apparently already
dealt with in 5de0a8c, already in mainline.

> are you submitting a new version of your x86 asm-prototypes.h patch?

The update is trivial, but yeah, I can resubmit.  If I'm wrong about where
__sw_hweight{8,16,32,64} should come from, please say so.


Meow!
-- 
A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol, 1kg
raspberries, 0.4kg sugar; put into a big jar for 1 month.  Filter out and
throw away the fruits (can dump them into a cake, etc), let the drink age
at least 3-6 months.
