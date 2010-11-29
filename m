From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 07/21] mm: Use refcounts for page_lock_anon_vma()
Date: Mon, 29 Nov 2010 21:41:23 +0100
Message-ID: <1291063283.32004.364.camel@laptop>
References: <20101126143843.801484792@chello.nl>
	 <20101126145410.655255418@chello.nl>
	 <20101129113511.296169c9.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:35860 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab0K2Ult convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2010 15:41:49 -0500
In-Reply-To: <20101129113511.296169c9.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, 2010-11-29 at 11:35 +0900, KAMEZAWA Hiroyuki wrote:
> On Fri, 26 Nov 2010 15:38:50 +0100
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Convert page_lock_anon_vma() over to use refcounts. This is
> > done for each of convertion of anon_vma from spinlock to mutex.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Does this patch affect only page_referenced() and try_to_unmap() ?

git grep page_lock_anon_vma reveals that
mm/memory-failure.c:collect_procs_anon() is also affected.
