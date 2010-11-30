Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59585 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab0K3BVM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2010 20:21:12 -0500
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 07/21] mm: Use refcounts for page_lock_anon_vma()
In-Reply-To: <20101129113511.296169c9.kamezawa.hiroyu@jp.fujitsu.com>
References: <20101126145410.655255418@chello.nl> <20101129113511.296169c9.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20101130102137.82F2.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Nov 2010 10:21:09 +0900 (JST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kosaki.motohiro@jp.fujitsu.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20101130012109.-v6STWWp_jC7dkTnShpD0COwLP8TiIYmjxg8aB2GS3I@z>

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

I like this conversion too.
	Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>




