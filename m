Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 16:21:14 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <20050310162114.GJ21986@parcelfarce.linux.theplanet.co.uk>
References: <20050309225833.6d80fc42.akpm@osdl.org> <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk> <320030000.1110468381@[10.10.2.4]> <1110470318.20958.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110470318.20958.18.camel@localhost>
Sender: <willy@www.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 10, 2005 at 07:58:38AM -0800, Dave Hansen wrote:
> Now that I look at it again, mem_init() happens way after
> paging_init()->free_area_init_node()->alloc_node_mem_map().  So, mem_map
> should already be initialized by the time mem_init() gets called.  It
> should be safe to just remove the
> 
> 	mem_map = zone_table[ZONE_DMA]->zone_mem_map;
> 
> line in mem_init().
> 
> Now that I have your attention, could you stick a printk in there, and
> double check that I'm right?  

Yep, I checked, both pointers have value 0x10bbb000, so I just took out
the assignment and committed that to our tree.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
