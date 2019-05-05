From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: DISCONTIGMEM is deprecated
Date: Sun, 5 May 2019 11:53:23 +0300
Message-ID: <20190505085322.GH15755@rapoport-lnx>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190419142835.GM18914@techsingularity.net>
 <9e7b80a9-b90e-ac04-8b30-b2f285cd4432@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e7b80a9-b90e-ac04-8b30-b2f285cd4432@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Mel Gorman <mgorman@techsingularity.net>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Fri, Apr 19, 2019 at 10:08:31PM +0200, Helge Deller wrote:
> On 19.04.19 16:28, Mel Gorman wrote:
> > On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> >> On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> >>> DISCONTIG is essentially deprecated and even parisc plans to move to
> >>> SPARSEMEM so there is no need to be fancy, this patch simply disables
> >>> watermark boosting by default on DISCONTIGMEM.
> >>
> >> I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> >> scenarios.  Grepping the arch/ directories shows:
> >>
> >> alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> >> arc (for supporting more than 1GB of memory)
> >> ia64 (looks complicated ...)
> >> m68k (for multiple chunks of memory)
> >> mips (does support NUMA but also non-NUMA)
> >> parisc (both NUMA and non-NUMA)
> >>
> >> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> >> is deprecated.  Adding linux-arch to the cc.
> >
> > Poor wording then -- yes, DISCONTIGMEM is still used but look where it's
> > used. I find it impossible to believe that any new arch would support
> > DISCONTIGMEM or that DISCONTIGMEM would be selected when SPARSEMEM is
> > available.`It's even more insane when you consider that SPARSEMEM can be
> > extended to support VMEMMAP so that it has similar overhead to FLATMEM
> > when mapping pfns to struct pages and vice-versa.
> 
> FYI, on parisc we will switch from DISCONTIGMEM to SPARSEMEM with kernel 5.2.
> The patch was quite simple and it's currently in the for-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=281b718721a5e78288271d632731cea9697749f7

A while ago I've sent a patch that removes ARCH_DISCARD_MEMBLOCK option [1]
so the hunk below is not needed:

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index c8038165b81f..26c215570adf 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -36,6 +36,7 @@ config PARISC
 	select GENERIC_STRNCPY_FROM_USER
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
+	select ARCH_DISCARD_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_RELA


[1] https://lore.kernel.org/lkml/1556102150-32517-1-git-send-email-rppt@linux.ibm.com/
 
> Helge
> 

-- 
Sincerely yours,
Mike.
