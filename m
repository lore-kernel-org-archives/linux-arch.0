Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j2AFwtLg582960
	for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2005 10:58:55 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j2AFwtVB149826
	for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2005 08:58:55 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j2AFwsVW027049
	for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2005 08:58:55 -0700
Subject: Re: no-arch-specific-mem_map-init
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <320030000.1110468381@[10.10.2.4]>
References: <20050309225833.6d80fc42.akpm@osdl.org>
	 <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk>
	 <320030000.1110468381@[10.10.2.4]>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 07:58:38 -0800
Message-Id: <1110470318.20958.18.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-03-10 at 07:26 -0800, Martin J. Bligh wrote:
> >         mem_map = zone_table[ZONE_DMA]->zone_mem_map;
> ...
> > Something that may not be intuitively obvious to someone with i386 biases
> > is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
> > memory is in ZONE_DMA.  Does that help divine what the right answer is
> > for parisc?
> 
> In which case, you should be fine, you should have
> 
> 	NODE_DATA(0)->node_mem_map == zone_table[ZONE_DMA]->zone_mem_map
> 
> I believe. In free_area_init_core(), we do:
> 
> 	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
> 
> So as long as zone_start_pfn == node_start_pfn, they're equiv. As you say
> all your mem is in ZONE_DMA, that should be true.

Now that I look at it again, mem_init() happens way after
paging_init()->free_area_init_node()->alloc_node_mem_map().  So, mem_map
should already be initialized by the time mem_init() gets called.  It
should be safe to just remove the

	mem_map = zone_table[ZONE_DMA]->zone_mem_map;

line in mem_init().

Now that I have your attention, could you stick a printk in there, and
double check that I'm right?  

-- Dave

P.S.  I do a lot of ppc64 work, too, so I have a bias for that as
well. :)
