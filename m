Return-Path: <SRS0=lzY1=6F=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 21 Apr 2020 11:39:46 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 02/21] mm: make early_pfn_to_nid() and related defintions
 close to each other
Message-ID: <20200421083946.GA14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-3-rppt@kernel.org>
 <20200421033114.GA29658@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421033114.GA29658@MiWiFi-R3L-srv>
Sender: owner-linux-mm@kvack.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200421083946.J8aDD6wrbiz6l-KeAkrNqoXZYobS_q9i8L_n_-e6sCA@z>

On Tue, Apr 21, 2020 at 11:31:14AM +0800, Baoquan He wrote:
> On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
> > around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.
> > 
> > Drop unused stub for __early_pfn_to_nid() and move its actual generic
> > implementation close to its users.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  include/linux/mm.h     |  4 ++--
> >  include/linux/mmzone.h |  9 --------
> >  mm/page_alloc.c        | 51 +++++++++++++++++++++---------------------
> >  3 files changed, 27 insertions(+), 37 deletions(-)
 
...

> >  int __meminit early_pfn_to_nid(unsigned long pfn)
> >  {
> >  	static DEFINE_SPINLOCK(early_pfn_lock);
> > @@ -6298,32 +6323,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
> >  	zone->initialized = 1;
> >  }
> >  
> > -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> 
> Here it's apparently removing CONFIG_HAVE_MEMBLOCK_NODE_MAP too early,
> it should be done in patch 3, and its #end is kept there. I just found
> it when I almost became dizzy in reviewing patch 3.

Right, thanks for catching!

> > -#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
> > -

-- 
Sincerely yours,
Mike.
