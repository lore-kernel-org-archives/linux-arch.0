Return-Path: <SRS0=ftPA=6H=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 23 Apr 2020 08:50:22 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 16/21] mm: remove early_pfn_in_nid() and
 CONFIG_NODES_SPAN_OTHER_NODES
Message-ID: <20200423055022.GE14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-17-rppt@kernel.org>
 <20200423011312.GY4247@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423011312.GY4247@MiWiFi-R3L-srv>
Sender: owner-linux-mm@kvack.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200423055022.fqdpp1cunGzl7Qwho6ahCOfx-E_mD6Omm4U6a-HAxgs@z>

On Thu, Apr 23, 2020 at 09:13:12AM +0800, Baoquan He wrote:
> On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions
> 
> This commit id should be a temporary one, will be changed when merged
> into maintainer's tree and linus's tree. Only saying last patch plus the
> patch subject is OK?

Right, the commit id here is not stable. I'll update the changelog.
 
> > rather that check each PFN") made early_pfn_in_nid() obsolete and since
> > CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
> > implementation of early_pfn_in_nid() it is also not needed anymore.
> > 
> > Remove both early_pfn_in_nid() and the CONFIG_NODES_SPAN_OTHER_NODES.
> > 
> > Co-developed-by: Hoan Tran <Hoan@os.amperecomputing.com>
> > Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/powerpc/Kconfig |  9 ---------
> >  arch/sparc/Kconfig   |  9 ---------
> >  arch/x86/Kconfig     |  9 ---------
> >  mm/page_alloc.c      | 20 --------------------
> >  4 files changed, 47 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 5f86b22b7d2c..74f316deeae1 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -685,15 +685,6 @@ config ARCH_MEMORY_PROBE
> >  	def_bool y
> >  	depends on MEMORY_HOTPLUG
> >  
> > -# Some NUMA nodes have memory ranges that span
> > -# other nodes.  Even though a pfn is valid and
> > -# between a node's start and end pfns, it may not
> > -# reside on that node.  See memmap_init_zone()
> > -# for details.
> > -config NODES_SPAN_OTHER_NODES
> > -	def_bool y
> > -	depends on NEED_MULTIPLE_NODES
> > -
> >  config STDBINUTILS
> >  	bool "Using standard binutils settings"
> >  	depends on 44x
> > diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> > index 795206b7b552..0e4f3891b904 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -286,15 +286,6 @@ config NODES_SHIFT
> >  	  Specify the maximum number of NUMA Nodes available on the target
> >  	  system.  Increases memory reserved to accommodate various tables.
> >  
> > -# Some NUMA nodes have memory ranges that span
> > -# other nodes.  Even though a pfn is valid and
> > -# between a node's start and end pfns, it may not
> > -# reside on that node.  See memmap_init_zone()
> > -# for details.
> > -config NODES_SPAN_OTHER_NODES
> > -	def_bool y
> > -	depends on NEED_MULTIPLE_NODES
> > -
> >  config ARCH_SPARSEMEM_ENABLE
> >  	def_bool y if SPARC64
> >  	select SPARSEMEM_VMEMMAP_ENABLE
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 9d3e95b4fb85..37dac095659e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1581,15 +1581,6 @@ config X86_64_ACPI_NUMA
> >  	---help---
> >  	  Enable ACPI SRAT based node topology detection.
> >  
> > -# Some NUMA nodes have memory ranges that span
> > -# other nodes.  Even though a pfn is valid and
> > -# between a node's start and end pfns, it may not
> > -# reside on that node.  See memmap_init_zone()
> > -# for details.
> > -config NODES_SPAN_OTHER_NODES
> > -	def_bool y
> > -	depends on X86_64_ACPI_NUMA
> > -
> >  config NUMA_EMU
> >  	bool "NUMA emulation"
> >  	depends on NUMA
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c43ce8709457..343d87b8697d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1541,26 +1541,6 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
> >  }
> >  #endif /* CONFIG_NEED_MULTIPLE_NODES */
> >  
> > -#ifdef CONFIG_NODES_SPAN_OTHER_NODES
> > -/* Only safe to use early in boot when initialisation is single-threaded */
> > -static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> > -{
> > -	int nid;
> > -
> > -	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
> > -	if (nid >= 0 && nid != node)
> > -		return false;
> > -	return true;
> > -}
> > -
> > -#else
> > -static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> > -{
> > -	return true;
> > -}
> > -#endif
> 
> And macro early_pfn_valid() is not needed either, we may need remove it
> too. 

Ok.

> Otherwise, removing NODES_SPAN_OTHER_NODES in this patch looks good.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> > -
> > -
> >  void __init memblock_free_pages(struct page *page, unsigned long pfn,
> >  							unsigned int order)
> >  {
> > -- 
> > 2.25.1
> > 
> 

-- 
Sincerely yours,
Mike.
