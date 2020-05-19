From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 2/7] mm/vmalloc: Track which page-table levels were
 modified
Date: Tue, 19 May 2020 17:25:12 +0200
Message-ID: <20200519152512.GO8135@suse.de>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-3-joro@8bytes.org>
 <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
 <20200516125641.GK8135@suse.de>
 <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 18, 2020 at 03:18:28PM -0700, Andrew Morton wrote:
> On Sat, 16 May 2020 14:56:41 +0200 Joerg Roedel <jroedel@suse.de> wrote:
> --- a/mm/vmalloc.c~mm-vmalloc-track-which-page-table-levels-were-modified-fix
> +++ a/mm/vmalloc.c
> @@ -309,6 +309,9 @@ int map_kernel_range_noflush(unsigned lo
>  			return err;
>  	} while (pgd++, addr = next, addr != end);
>  
> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +		arch_sync_kernel_mappings(start, end);
> +
>  	return 0;
>  }

Yes, this is the right call.

> It would be nice to get all this (ie, linux-next) retested before we
> send it upstream, please.

Will do and report back.


Thanks,

	Joerg
