Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268227AbUHKUqF@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268230AbUHKUqF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 16:46:05 -0400
Date: Wed, 11 Aug 2004 13:45:07 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_page_range()
Message-Id: <20040811134507.714f2a38.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408110856080.1839@ppc970.osdl.org>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<20040807080751.GX17188@holomorphy.com>
	<20040811000708.6e31969d.davem@redhat.com>
	<Pine.LNX.4.58.0408110856080.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 09:13:36 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Hmm.. I don't see any of this being arch-dependent, so I wonder why you 
> did it that way. 

I'm trying to achieve two goals.  The first I've demonstrated is
achieveable, the second is still not fully grasped yet.

Firstly, I wanted to get clear_page_tables() out of my profiles.
Secondly, I wanted to abstract out completely the page table
traversing the generic kernel does.

I want the latter so I can experiment with different data structures
for page tables, and the current pgd/pmd/pte array assumptions in
the kernel generic vm code disallow any kind of tinkering in that
area.

If we end up with an interface that says: "walk page tables for vaddr
range 'start' to 'end', and do func() for each pte" then anything can
be experimented with.

You're absolutely right, and I've mentioned this earlier in this thread,
that the current page tables are way too sparse.  On 64-bit a simple
hello world program with a 3-level page table looks roughly like:

PGD_BASE:
   ...
	X --> PMD_BASE1
		...
	              Y --> PTE_BASE1
			... some ptes ...
	        ...
	Z --> PMD_BASE2
	        ...
		      A --> PTE_BASE2
			... some ptes ...
	        ...
	B --> PMD_BASE3
		...
		      C --> PTE_BASE3
			... some ptes ...
		...
  ...

The X-->Y branch is for the program text.
The Z-->A branch is for the dynamic mmap() area (shared libraries,
anonymous mmaps, etc.)
The B-->C branch is for the program stack.

We've got maybe 10 to 20 present pte's in this tree.

On sparc64 pgd_t and pmd_t are both 32-bit (this is in order to
encode the most address space possible, we can encode the full
physical address by simply shifting out the page offset bits)
So each pgd_t table holds 2048 entries as does each pmd_t table.
Therefore, in the above example during clear_page_tables() we'd
scan 2048 pgd's, 3 * 2048 pmd's and 3 * 1024 pte's.

That's 7 * 8192 (PAGE_SIZE) byte worth of pointer derefing.
It's no wonder this shows up in the profiles.  All of that just
for 10 to 20 actual user mappings.  This is broken.

I want to try and use a less sparse data structure on sparc
just for the pgd/pmd level, and use pages of ptes for the pte_t
level as those tend to be well populated.  I also need to retain
the pte_t level as a full page due to the virtual linear page table
stuff I do to speed up TLB miss processing (roughly the same as
what ia64 does).

I can't experiment with all the generic code assuming these things
are arrays.
