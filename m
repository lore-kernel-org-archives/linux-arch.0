Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268374AbUHLC61@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:1707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268373AbUHLC61 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:58:27 -0400
Date: Wed, 11 Aug 2004 19:57:22 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811195722.5e0e6460.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040812004654.GX11200@holomorphy.com>
	<Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 19:18:18 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I really do believe (but can't back it up with any real numbers) that we 
> want to try to keep pages in cache as long as possible. That means keeping 
> the pages close to the last CPU that used them, btw.

This reminded me of something.

One place where things fall apart is for situations like a fork+exit
benchmark such as lmbench's "lat_proc fork".  Here is what happens:

	CPU	1		CPU	2

parent:	alloc local cpu pagetable
parent:	init child page table
parent:	wait on child
child:				tlb miss, ref page tables
child:				exit_mmap
child:				free page tables to local cpu

It is exactly the most sub-optimal sequence of page table
usage possible.  CPU 1's cache empties constantly, while
CPU 2's grows constantly.  CPU 2 goes over it's limit
and starts feeding excess page table per-cpu cache pages
into the generic page pool (and actually in 2.6.x into
the per cpu hot/cold page lists).

Meanwhile CPU 1 is constantly going to the page allocator
for page table pages since the per-cpu pgtable cache is empty.

It's amusing, and just wanted to bring it up to light while
we're discussing things of this nature.
