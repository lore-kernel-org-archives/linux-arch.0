Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 07:24:23 -0800
From: Randolph Chung <randolph@tausq.org>
Subject: Re: no-arch-specific-mem_map-init
Message-ID: <20050310152423.GT4645@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
References: <20050310141804.GF21986@parcelfarce.linux.theplanet.co.uk> <20050309225833.6d80fc42.akpm@osdl.org> <14917.1110465046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14917.1110465046@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

> > Something that may not be intuitively obvious to someone with i386 biases
> > is that on PA-RISC (at least in the case of CONFIG_DISCONTIGMEM=n), all
> > memory is in ZONE_DMA.  Does that help divine what the right answer is
> > for parisc?
> 
> It's probably assuming that since ZONE_DMA is zone 0, the DMA capable zone is
> at the bottom of any chunk of memory (node).

All memory on any PARISC boxes (with or without DISCONTIGMEM) falls into
ZONE_DMA, since PARISC boxes have IOMMUs (at last the ones that we care
about for this discussion).

So, 
mem_map = zone_table[ZONE_DMA]->zone_mem_map;
and
mem_map = NODE_DATA(0)->node_mem_map;

should give you the same result on parisc.

Does that help? If you want to change it so we use the latter form of
initialization, that should be ok for us.

randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
