Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:38340 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbYAMDIN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 22:08:13 -0500
Date: Sun, 13 Jan 2008 04:08:11 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: [rfc] changes to user memory mapping scheme
Message-ID: <20080113030810.GB22285@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

Hi guys,

I'd like to get some comments about changes to the mm/memory.c code
which determines what to do with user ptes.

Basically, we have a vm_normal_page() to determine whether the page
under the pte is "normal" (has an underlying struct page, which is
refcounted); or "special" (may or may not have a struct page, but
either way we don't want to refcount anything).

Now the first patch should be uncontroversial. It adds a slightly
different special vma mapping that can support COW for arbitrary page and/or
pfn mappings. VM_PFNMAP cannot do this due to its special support for
COW on /dev/mem. We are going to need this to support non-struct page
backed XIP mappings, which is interesting for virtualisation, and for
Jared's (IMO very important) work on hybrid RAM/NVRAM filesystems.

The second patch simplifies a lot of this tricky logic by using an extra
bit in the valid, user pte. Now depending on how s390 goes, this patch
may or may not be required to get all this working on that architecture.
I'm posting it here for comments because firstly, it might be required;
and secondly, it is already written and has some other nice properties
for *any* architecture that implements it.

While we're working out the exact details of the xip stuff, I'd like to
pipeline things by asking for comments on the changes we need to the
memory mapping side of things.

Thanks,
Nick
