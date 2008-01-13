Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45780 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYAMUp4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jan 2008 15:45:56 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m0DKjrZX194224
	for <linux-arch@vger.kernel.org>; Sun, 13 Jan 2008 20:45:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0DKjrwv2969720
	for <linux-arch@vger.kernel.org>; Sun, 13 Jan 2008 21:45:53 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m0DKjqKM030763
	for <linux-arch@vger.kernel.org>; Sun, 13 Jan 2008 21:45:53 +0100
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de>
	 <20080113031013.GD22285@wotan.suse.de>
	 <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
	 <20080113043922.GA22345@wotan.suse.de>
	 <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
	 <20080113050605.GA1340@wotan.suse.de>
	 <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 13 Jan 2008 21:46:00 +0100
Message-Id: <1200257160.17186.70.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Sun, 2008-01-13 at 08:50 -0800, Linus Torvalds wrote: 
> > Well the immediate improvement from this actual patch is just that
> > it gives better and smaller code for vm_normal_page (even if you
> > discount the debug checks in the existing code).
> 
> It does no such thing, except for the slow-path that doesn't matter.
> 
> So it may optimize the slow-path (PFNMAP/MIXMAP), but the real path stays 
> exactly the same from a code generation standpoint (just checking a 
> different bit, afaik). 
> 
> If those pte_special bits are required for unexplained lockless 
> get_user_pages, is this going to get EVEN WORSE when s390 (again) cannot 
> do it?

Neiter is the pte_special bit required for s390 nor can't we implement
pfn_valid in a way that would work with the new VM_MIXMAP vmas and copy
on write. It would be slow though because DCSS segments on s390 can have
different types. For one type the pages are reference counted (hotplug
memory via DCSS), for the other the pages are not reference counted
(read only xip DCSS). I doubt that we will stay alone with the problem,
with KVM you can easily imagine to introduce hot memory add by mapping
an anonymous piece of memory. For s390 the straight forward solution for
pages with a pfn > max_pfn is to walk the list of all DCSS segments. For
a system where /usr lives on a xip DCSS this happens frequently.

It seems reasonable to me to introduce a pte bit to decide between the
two cases, in particular since Nick has some other use for the bit as
well (don't know too much about that features as well). When a non-
reference counting pte is established we know it is special, we just
have forgotten about it in vm_normal_page. What makes this ugly is the
fact that there currently are some architectures like arm that do not
have room for the pte_special bit in the pte. Seems like we need a clean
abstraction to allow each architecture to choose the best way to make
the decision between reference counted or not. It is only two arch
calls, one when a pte is created for a non-refcounting page and another
for the check in vm_normal_page to get the information back. The default
implementation would be a nop for the first call and a pfn_valid check
for the second call. For s390 I would prefer a pte bit if I can get it.
If not then we have to play games with pfn_valid.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


