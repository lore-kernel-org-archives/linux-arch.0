From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/7] mm/vmalloc: Track which page-table levels were
 modified
Date: Mon, 18 May 2020 15:18:28 -0700
Message-ID: <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
References: <20200515140023.25469-1-joro@8bytes.org>
        <20200515140023.25469-3-joro@8bytes.org>
        <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
        <20200516125641.GK8135@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200516125641.GK8135@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Sat, 16 May 2020 14:56:41 +0200 Joerg Roedel <jroedel@suse.de> wrote:

> Hi Andrew,
> 
> On Fri, May 15, 2020 at 01:01:42PM -0700, Andrew Morton wrote:
> > On Fri, 15 May 2020 16:00:18 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> > Lots of collisions here with Christoph's "decruft the vmalloc API" series
> > (http://lkml.kernel.org/r/20200414131348.444715-1-hch@lst.de).
> > 
> > I attempted to fix things up.
> > 
> > unmap_kernel_range_noflush() needed to be redone.
> > 
> > map_kernel_range_noflush() might need the arch_sync_kernel_mappings() call?
> 
> Yes, map_kernel_range_noflush() needs the arch_sync_kernel_mappings()
> call as well.
> 

This?

--- a/mm/vmalloc.c~mm-vmalloc-track-which-page-table-levels-were-modified-fix
+++ a/mm/vmalloc.c
@@ -309,6 +309,9 @@ int map_kernel_range_noflush(unsigned lo
 			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
 	return 0;
 }
 

It would be nice to get all this (ie, linux-next) retested before we
send it upstream, please.  
