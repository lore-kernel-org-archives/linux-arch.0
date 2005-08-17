Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BACF61D08A
	for <linux-arch@vger.kernel.org>; Wed, 17 Aug 2005 02:32:45 +0200 (CEST)
Received: from wotan.suse.de (wotan.suse.de [10.10.0.1])
	by Relay1.suse.de (Postfix) with ESMTP id B31A21016C
	for <linux-arch@vger.kernel.org>; Wed, 17 Aug 2005 02:32:45 +0200 (CEST)
Date: Wed, 17 Aug 2005 02:32:45 +0200
From: Andi Kleen <ak@suse.de>
Subject: reordering pgdat list
Message-ID: <20050817003245.GD3996@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hallo,

I had some problems with bootmem allocators who need to allocate memory in
the first 4GB.  On a NUMA system with enough memory alloc_bootmem would
just go over the nodes with a for_each_pgdat and try them in turn. When
the nodes are added in the straight forward order beginning from 0 to
bootmem they end up reversed on the pgdat_list because init_bootmem_node 
always inserts the new node at the head of the list. This results
in alloc_bootmem to look first into the last node and if there
is enough memory there allocate memory. Which can be beyond 4GB.

Anyways, i pondered a few solutions. The best one seems to be to just
reorder the list. I see that IA64 had some magic
code to do the same, but it looked so hackish that I didn't want
to duplicate it. So I just changed init_bootmem to insert at the tail.

I think the generic code doing for_each_pgdat is all ok and doesn't
care about the order, but several architectures do their own
for_each_pgdat() and they might in theory break. 

If your architecture does funky things with for_each_pgdat testing this patch
might good. I plan to submit it when 2.6.14 opens.

-Andi


Index: linux/mm/bootmem.c
===================================================================
--- linux.orig/mm/bootmem.c
+++ linux/mm/bootmem.c
@@ -61,9 +61,17 @@ static unsigned long __init init_bootmem
 {
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
+	static struct pglist_data *pgdat_last;
 
-	pgdat->pgdat_next = pgdat_list;
-	pgdat_list = pgdat;
+	pgdat->pgdat_next = NULL;
+	/* Add new nodes last so that bootmem always starts 
+	   searching in the first nodes, not the last ones */
+	if (pgdat_last)
+		pgdat_last->pgdat_next = pgdat;
+	else {
+		pgdat_list = pgdat; 	
+		pgdat_last = pgdat;
+	}
 
 	mapsize = ALIGN(mapsize, sizeof(long));
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
