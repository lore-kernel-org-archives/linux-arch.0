Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:58357 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031194AbXEHTKd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2007 15:10:33 -0400
Date: Tue, 8 May 2007 12:10:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: New slab allocator SLUB
Message-ID: <Pine.LNX.4.64.0705081145360.11368@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

The new slab allocator SLUB was merged and it seems that we are heading 
towards replacing SLAB completely by SLUB. This means that we would like 
to be sure that SLUB runs reliably on all platforms. SLUB is first
available upstream with 2.6.21-git9.

One issue is that SLUB requires the use of the entire page struct for the 
management of its objects. If arch code uses the page struct too the 
disaster strikes. As a result SLUB has been disabled for several platforms 
by setting ARCH_USES_SLAB_PAGE_STRUCT in the Kconfig. These are

i386:
 Uses slab for pgd handling and modifies the page structs of those
 Fix has been in Andrew's tree for awhile now.

PowerPC:
 Uses slab allocator for pte allocation / freeing. The page structs of 
 ptes also are used for splitting the page table lock in large cpu 
 configurations (well more than 4) causing issues. There is a patch
 by Hugh Dickins to address the issues but it seems that the arch 
 maintainers have now decided on a different course of action.

FRV
 Like i386. Also uses slab for pgd handling and modifies page structs.
 Fix sent to David Howell's. Hopefully we get can this working soon.

I would appreciate if you could test SLUB on your platform and make sure 
that everything works the right way. There is a slabinfo tool that allows 
monitoring of SLUB slabs in Documentation/vm/slabinfo.c. If there are 
problems then please boot specifying "slub_debug" which should give you a 
detailed analysis of the issues encountered.

There are a lot of kernel config files around that have CONFIG_SLAB=y. 
This means that the kernel will be build with SLAB and not SLUB. In order 
to build a kernel with SLUB you will need to have CONFIG_SLUB=y in there.

Differences in the treatment of power of two slabs:

SLUB has a higher packing density since the control fields are placed in 
the page struct. There is no need for a control structure in the slab 
itself or have control structures in a separate slab (OFF_SLAB). This is 
only possible since SLUB does not have to maintain a map of all objects 
like SLAB. Instead we use a linked list.

In order to manage objects with linked lists we need to have a pointer to 
the next free object for each object. This is no problem for slab 
configurations where the object state is irrelevant after kfree or before 
kmalloc. However, if the object cannot be touched at all 
(SLAB_DESTROY_BY_RCU or the use of constructors) then SLUB must place the 
free list pointer after the object and therefore increase the object size. 
This is particularly bad if the object is also aligned to the same 
power-of-two because it means that the object size has just doubled.

For page sized allocations quicklists are an alternative. Moving to 
quicklists also allows to continue the use of page struct fields. The 
solution for most of the three platforms above was to switch to quicklists 
instead.

If you have smaller than page sized allocations that are of the power of 
two and which are to be aligned to the same power of two then it may be 
advisable to make sure that the slab does not have a constructor. 
Otherwise there may be some memory wasted.

I would expect that the experimental status of SLUB will be removed 
soon. SLUB then become the default slab allocator. It may not be the 
default when we release 2.6.22 but it is scheduled to be the default for 
2.6.23.

