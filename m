Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 07:26:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <320030000.1110468381@[10.10.2.4]>
In-Reply-To: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk>
References: <20050309225833.6d80fc42.akpm@osdl.org> <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

>         mem_map = zone_table[ZONE_DMA]->zone_mem_map;
...
> Something that may not be intuitively obvious to someone with i386 biases
> is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
> memory is in ZONE_DMA.  Does that help divine what the right answer is
> for parisc?

In which case, you should be fine, you should have

	NODE_DATA(0)->node_mem_map == zone_table[ZONE_DMA]->zone_mem_map

I believe. In free_area_init_core(), we do:

	zone->zone_mem_map = pfn_to_page(zone_start_pfn);

So as long as zone_start_pfn == node_start_pfn, they're equiv. As you say
all your mem is in ZONE_DMA, that should be true.

M.
