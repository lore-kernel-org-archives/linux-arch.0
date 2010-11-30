From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 19/21] mm: Convert i_mmap_lock and anon_vma->lock to mutexes
Date: Tue, 30 Nov 2010 10:28:58 +0900 (JST)
Message-ID: <20101130102933.82F8.A69D9226@jp.fujitsu.com>
References: <20101126143843.801484792@chello.nl> <20101126145411.331356698@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60007 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab0K3B3B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2010 20:29:01 -0500
In-Reply-To: <20101126145411.331356698@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

> Straight fwd conversion of i_mmap_lock and anon_vma->lock to mutexes.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

+1.

I don't think this conversion makes performance hurt.
