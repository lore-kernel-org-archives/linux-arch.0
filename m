Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:44519 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbYAPDiC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jan 2008 22:38:02 -0500
Date: Wed, 16 Jan 2008 04:38:00 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080116033800.GA8890@wotan.suse.de>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de> <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Sun, Jan 13, 2008 at 08:50:23AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 13 Jan 2008, Nick Piggin wrote:
> > 
> > OK, you have to read to the 3rd paragraph.
> 
> That one doesn't actually say what the point is either. It just claims 
> that there *is* a point that isn't actually explained or mentioned 
> further.

OK, right after reading it again I concede it is unclear and doesn't
actually make the point.

My biggest concen is that s390 basically are thinking about doing
something like this:

       if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
                if (vma->vm_flags & VM_MIXEDMAP) {
#ifdef s390
			if (pte_special(pte))
				return NULL;
#else
                        if (!pfn_valid(pfn))
                                return NULL;
#endif
                        goto out;
                } else {
                        unsigned long off = (addr-vma->vm_start) >> PAGE_SHIFT;
                        if (pfn == vma->vm_pgoff + off)
                                return NULL;
                        if (!is_cow_mapping(vma->vm_flags))
                                return NULL;
                }
        }

Of course it is nicely wrapped in arch functions, but that is the
basic logic. Now what happens is that already gives us 2 paths through
that function which needs to be understood by developers, but it also
IMO is more confusing because it mixes the 2 schemes (vma based vs pte
based).

Basically what I want to do is make the pte_special part usable by
all architectures, and bring it out of the vma tests. I think if anything
it actually makes the code clearer to a novice reader because they can
quite easily see the intention of the more complex vma scheme, by
understanding what the pte scheme does (althogh the comments are pretty
good at doing that anyway). My point is just that I don't think it is
too horrible. It isn't like the poor developer who has to understand
the vma scheme will have much problem with the pte scheme...

 
> > Well the immediate improvement from this actual patch is just that
> > it gives better and smaller code for vm_normal_page (even if you
> > discount the debug checks in the existing code).
> 
> It does no such thing, except for the slow-path that doesn't matter.

Well it does do such a thing.

Here is the old one (with the sanity check ifdefed away). 88 bytes or so,
somewhat sparse in icache for the fastpath, which also has a short forward
jump:

vm_normal_page:
        movabsq $70368744177663, %rax   #, tmp66
        andq    %rax, %rdx      # tmp66, pfn
        movq    40(%rdi), %rax  # <variable>.vm_flags, D.23528
        shrq    $12, %rdx       #, pfn
        testl   $268436480, %eax        #, D.23528
        je      .L14    #,
        testl   $268435456, %eax        #, D.23528
        je      .L16    #,
        cmpq    end_pfn(%rip), %rdx     # end_pfn, pfn
        jb      .L14    #,
        jmp     .L18    #
.L16:
        subq    8(%rdi), %rsi   # <variable>.vm_start, addr
        shrq    $12, %rsi       #, addr
        addq    136(%rdi), %rsi # <variable>.vm_pgoff, addr
        cmpq    %rsi, %rdx      # addr, pfn
        je      .L18    #,
        andl    $40, %eax       #, tmp72
        cmpl    $32, %eax       #, tmp72
        jne     .L18    #,
.L14:
        imulq   $56, %rdx, %rax #, pfn, D.23534
        addq    mem_map(%rip), %rax     # mem_map, D.23534
        ret
.L18:
        xorl    %eax, %eax      # D.23534
        ret

The new one looks like this. It has no taken branches in the fastpath so
is dense in icache, is less than half the size, and works out of registers.
vm_normal_page:
        xorl    %eax, %eax      # D.23526
        testb   $2, %dh #, pte$pte
        jne     .L16    #,
        movabsq $70368744177663, %rax   #, tmp66
        andq    %rax, %rdx      # tmp66, pte$pte
        shrq    $12, %rdx       #, pte$pte
        imulq   $56, %rdx, %rax #, pte$pte, D.23526
        addq    mem_map(%rip), %rax     # mem_map, D.23526
.L16:
        ret

I think it is slightly better code even for the fastpath.


> So it may optimize the slow-path (PFNMAP/MIXMAP), but the real path stays 
> exactly the same from a code generation standpoint (just checking a 
> different bit, afaik). 

Well, possibly MIXMAP will become an important path too if you have a lot
of use of these XIP filesystems.


> If those pte_special bits are required for unexplained lockless 
> get_user_pages, is this going to get EVEN WORSE when s390 (again) cannot 
> do it?

Ah, my raising of the lockless get_user_pages was just to demonstrate
that some other architectures (like x86) would also like to have a
pte_special bit in their pte. So it isn't like we'd be using a pte bit
_simply_ to make this little improvement to vm_normal_page(), just that
the path isn't going to be an s390 only thing because we may get other
architectures with a pte_special bit for other good reasons.

lockless get_user_pages won't touch vm_normal_page, or even the existing
get_user_pages. Architectures that don't support it would just fall
through to regular get_user_pages...

