Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 14:18:04 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk>
References: <20050309225833.6d80fc42.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309225833.6d80fc42.akpm@osdl.org>
Sender: <willy@www.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Randolph Chung <randolph@tausq.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Mar 09, 2005 at 10:58:33PM -0800, Andrew Morton wrote:
> Everyone OK with this?

Since I don't understand VM and he's touching everything except my port,
no ;-P

> From: Dave Hansen <haveblue@us.ibm.com>
> The following patch does what my first one did (don't pass mem_map into the
> init functions), incorporates Jesse Barnes' ia64 fixes on top of that, and
> gets rid of all but one of the global mem_map initializations (parisc is
> weird).  It also magically removes more code than it adds.  It could be
> smaller, but I shamelessly added some comments.  

I'm not quite sure why parisc is 'weird'.  Here's the code block in question:

void __init mem_init(void)
{
        high_memory = __va((max_pfn << PAGE_SHIFT));

#ifndef CONFIG_DISCONTIGMEM
        max_mapnr = page_to_pfn(virt_to_page(high_memory - 1)) + 1;
        mem_map = zone_table[ZONE_DMA]->zone_mem_map;
        totalram_pages += free_all_bootmem();
#else
        {
                int i;

                for (i = 0; i < npmem_ranges; i++)
                        totalram_pages += free_all_bootmem_node(NODE_DATA(i));
        }
#endif

Something that may not be intuitively obvious to someone with i386 biases
is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
memory is in ZONE_DMA.  Does that help divine what the right answer is
for parisc?

Randolph, you touched this code last ... can you help Dave understand it?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
