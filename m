Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 09 Mar 2005 23:38:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <313750000.1110440302@[10.10.2.4]>
In-Reply-To: <20050309225833.6d80fc42.akpm@osdl.org>
References: <20050309225833.6d80fc42.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Cc: haveblue@us.ibm.com
List-ID: <linux-arch.vger.kernel.org>

> Everyone OK with this?

Makes sense to me at least, if it works OK.

> From: Dave Hansen <haveblue@us.ibm.com>
> 
> So, this patch started out with me trying to keep from passing contiguous,
> node-specific mem_map into free_area_init_node() and cousins.  Instead, I
> relied on some calls to pfn_to_page().
> 
> This works fine and dandy when all you need is the pgdat->node_mem_map to
> do pfn_to_page().  However, the non-NUMA/DISCONTIG architectures use the
> real, global mem_map[] instead of a node_mem_map in the pfn_to_page()
> calculation.  So, I ended up effectively trying to initialize mem_map from
> itself, when it was NULL.  That was bad, and caused some very pretty colors
> on someone's screen when he tested it.
> 
> So, I had to make sure to initialize the global mem_map[] before calling
> into free_area_init_node().  Then, I realized how many architectures do
> this on their own, and have comments like this:
> 
>         /* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
>         mem_map = NODE_DATA(0)->node_mem_map;
> 
> The following patch does what my first one did (don't pass mem_map into the
> init functions), incorporates Jesse Barnes' ia64 fixes on top of that, and
> gets rid of all but one of the global mem_map initializations (parisc is
> weird).  It also magically removes more code than it adds.  It could be
> smaller, but I shamelessly added some comments.  
