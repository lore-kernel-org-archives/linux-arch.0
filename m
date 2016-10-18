From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Tue, 18 Oct 2016 02:16:26 +0200
Message-ID: <20161018001626.GA5976@angband.pl>
References: <20161017100130.GA16013@angband.pl>
 <871szfb1x1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871szfb1x1.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 17, 2016 at 02:22:34PM +0200, Mathieu OTHACEHE wrote:
> > +#include <asm/uaccess.h>
> > +#include <asm/uaccess.h>
> 
> Included twice.

D'oh!

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
> 
> No <asm/arch_hweight.h> for __sw_hweight32 and __sw_hweight64 ? 

diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
new file mode 100644
index 0000000..df13637
--- /dev/null
+++ b/include/asm-generic/asm-prototypes.h
@@ -0,0 +1,7 @@
+#include <linux/bitops.h>

... which has these.

Alexey Dobriyan <adobriyan@gmail.com> wrote:
} bitops.h is wrong header as well.
} Why do you need bitops for bunch of function prototypes?

Unless you guys prefer using low-level headers only, that is.


Meow!
-- 
A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol, 1kg
raspberries, 0.4kg sugar; put into a big jar for 1 month.  Filter out and
throw away the fruits (can dump them into a cake, etc), let the drink age
at least 3-6 months.
