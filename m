From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Tue, 18 Oct 2016 12:34:18 +1100
Message-ID: <20161018123418.6121175b@roar.ozlabs.ibm.com>
References: <20161017100130.GA16013@angband.pl>
        <871szfb1x1.fsf@gmail.com>
        <20161018001626.GA5976@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35352 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758644AbcJRBe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 21:34:28 -0400
In-Reply-To: <20161018001626.GA5976@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Adam,

Thanks, this is looking good. powerpc will be able to use the generic
header.

On Tue, 18 Oct 2016 02:16:26 +0200
Adam Borowski <kilobyte@angband.pl> wrote:

> On Mon, Oct 17, 2016 at 02:22:34PM +0200, Mathieu OTHACEHE wrote:
> > > +#include <asm/uaccess.h>
> > > +#include <asm/uaccess.h>  
> > 
> > Included twice.  
> 
> D'oh!
> 
> > > +#include <asm/string.h>
> > > +#include <asm/page.h>
> > > +#include <asm/checksum.h>
> > > +
> > > +#include <asm-generic/asm-prototypes.h>
> > > +
> > > +#include <asm/page.h>
> > > +#include <asm/pgtable.h>
> > > +#include <asm/special_insns.h>
> > > +#include <asm/preempt.h>  
> > 
> > No <asm/arch_hweight.h> for __sw_hweight32 and __sw_hweight64 ?   
> 
> diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
> new file mode 100644
> index 0000000..df13637
> --- /dev/null
> +++ b/include/asm-generic/asm-prototypes.h
> @@ -0,0 +1,7 @@
> +#include <linux/bitops.h>
> 
> ... which has these.
> 
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> } bitops.h is wrong header as well.
> } Why do you need bitops for bunch of function prototypes?
> 
> Unless you guys prefer using low-level headers only, that is.

Well you can't use asm/arch_hweight.h in a generic header of course.
I would suggest just including linux/ variants where practical for
the asm-generic/asm-prototypes.h header.

We should probably just bring all these arch patches through the
kbuild tree.

I'm sorry for the breakage: I didn't realize it broke the build with
some configs, otherwise I would have given Michal a heads up before
his pull request, and worked to get this stuff in first.

Thanks,
Nick
