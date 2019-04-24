Return-Path: <owner-linux-mm@kvack.org>
Date: Wed, 24 Apr 2019 14:33:53 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423071354.GB12114@infradead.org>
Message-ID: <20190424113352.GA6278@rapoport-lnx>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190424113353.nUEUV7SFb9vgm_7fnTLeiOR_kBECYjAChEskm3pb8XY@z>

On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > between 2004 and 2007. If someone is running a 64-bit capable system in
> > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> 
> Can we mark it as BROKEN to see if someone shouts and then remove it
> a year or two down the road?  Or just kill it off now..

How about making SPARSEMEM default for x86-32?

From ac2dc27414e26f799ea063fd1d01e19d70056f43 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 24 Apr 2019 14:32:12 +0300
Subject: [PATCH] x86/Kconfig: make SPARSEMEM default for X86_32

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fd..77b17af 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1609,10 +1609,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
 	depends on NUMA && X86_32

-config ARCH_DISCONTIGMEM_DEFAULT
-	def_bool y
-	depends on NUMA && X86_32
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
@@ -1621,7 +1617,7 @@ config ARCH_SPARSEMEM_ENABLE

 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on X86_64
+	depends on X86_64 || (NUMA && X86_32)

 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
-- 
2.7.4


-- 
Sincerely yours,
Mike.
