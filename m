Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261230AbVABCuW@vger.kernel.org>
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:46686 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261223AbVABCuW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 1 Jan 2005 21:50:22 -0500
Message-ID: <41D7616C.1070100@yahoo.com.au>
Date: Sun, 02 Jan 2005 13:50:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Converting architectures to 4 level page tables
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Hello arch maintainers,

Linus has just merged the 4 level page tables patch into -bk.
However, this is slightly modified from the pml4 version you
would have seen. Which means fewer architectures have been
tested at this stage.

Fortunately, nobody should need to immediately do any fixups on
their architectures, because we have introduced a compatibility
header that should get things working for all archs.

* Testing on all architectures would be very welcome though! *


The advantages of moving away from the compatibility header is
that you'll get better static type checking when compiling the
generic mm code; and that we'll eventually be able to simplify
some small complexities in generic code that currently handle
the compatibility scheme.

I don't think continued use of the compatibility header is any
problem for a 2.6.11 release, provided some testing gets done.
But for those who want to move from the compatibility header to
the generic 'folding' headers (**), there are a few changes you'll
need to do the following:


* replace
     #include <asm-generic/4level-fixup.h>
   in asm/pgtable.h with
     #include <asm-generic/pgtable-nopud.h>

* rename
   pgd_none, pgd_bad, pgd_present, pgd_clear, pgd_page, pgd_populate
   to pud_*. Parameter types, etc should be changed as well.

* pmd_offset takes an argument of type pud_t * instead of pgd_t *.

* Add a pud_free_tlb function if you're not using asm-generic/tlb.h
   This can be a noop, but for simplicity I've used the same definition
   as the generic one for ia64 (which will basically turn into a noop).

* Add in the pud stage to your arch/ code that walks page tables.
   You should be able to just follow compiler warnings/errors to
   track these down.

* Look at the ia64 conversion for hints.

* Architectures with 2-level page tables may alternatively use
   pgtable-nopmd.h rather than -nopud.h, however that will mean more
   work to remove the existing 3 into 2 folding stuff. It would be
   nice to get this done one day though. Look at the 2-level i386
   conversion for ideas (actually i386 isn't the best example of
   this because it has some code mixed in to handle 3 levels as well.
   I've tried to clean this up a bit though).


(**) We have introduced asm-generic/ 'folding' headers, for 2 and
3 level architectures, rather than have them do the page table
folding in their own headers. This is just a bit of cleanup and
consolidation work, no functional changes, and no reason why you
*must* use these headers (but you should!).

Please CC me on replies.

Thanks,
Nick
