Return-Path: <SRS0=03B7=63=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 13 May 2020 08:21:33 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 03/12] mm: reorder includes after introduction of
 linux/pgtable.h
Message-ID: <20200513052133.GN14260@kernel.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-4-rppt@kernel.org>
 <20200512192013.GY16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512192013.GY16070@bombadil.infradead.org>
Sender: owner-linux-mm@kvack.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200513052133.7rXVkr8CeDM6GwdAiT02Q8wGKwLHn6tStzMjVtwdU1U@z>

On Tue, May 12, 2020 at 12:20:13PM -0700, Matthew Wilcox wrote:
> On Tue, May 12, 2020 at 09:44:13PM +0300, Mike Rapoport wrote:
> > diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
> > index a093cd45ec79..701a05090141 100644
> > --- a/arch/alpha/kernel/proto.h
> > +++ b/arch/alpha/kernel/proto.h
> > @@ -2,8 +2,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  
> > -#include <linux/pgtable.h>
> > -
> >  /* Prototypes of functions used across modules here in this directory.  */
> >  
> >  #define vucp	volatile unsigned char  *
> 
> Looks like your script has a bug if linux/pgtable.h is the last include
> in the file?

Script indeed cannot handle all the corner case, but this is not one of
them.
I've started initially to look into removing asm/pgtable.h if it was not
needed, but I've run out of patience very soon. This file is what
sneaked in from that attempt.

-- 
Sincerely yours,
Mike.
