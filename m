From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] mm, show_mem: suppress page counts in non-blockable
 contexts
Date: Wed, 27 Feb 2013 14:13:37 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302271410230.7155@chino.kir.corp.google.com>
References: <alpine.DEB.2.02.1302261642520.11109@chino.kir.corp.google.com> <512E2B91.6000506@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <512E2B91.6000506@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Wed, 27 Feb 2013, Dave Hansen wrote:

> On 02/26/2013 04:46 PM, David Rientjes wrote:
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -99,6 +99,9 @@ void show_mem(unsigned int filter)
> >  	printk("Mem-info:\n");
> >  	show_free_areas(filter);
> > 
> > +	if (filter & SHOW_MEM_FILTER_PAGE_COUNT)
> > +		return;
> > +
> 
> Won't this just look like a funky truncated warning to the end user?
> 

No, because of the uninhibited call to show_free_areas() above.  This 
still dumps the pcp state, global and per-node page type breakdown, and 
free pages at given order.  The only things suppresses are the total 
pages, pages reserved, pages shared, and pages non-shared counts that are 
quite expensive to determine because it walks all memory while irqs are 
disabled and increases with the amount of RAM a system has.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
