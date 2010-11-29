Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59135 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab0K2D2S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Nov 2010 22:28:18 -0500
Date: Mon, 29 Nov 2010 12:22:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 21/21] mm: Optimize page_lock_anon_vma() fast-path
Message-ID: <20101129122229.9e18169e.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20101126145411.441498352@chello.nl>
References: <20101126143843.801484792@chello.nl>
	<20101126145411.441498352@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20101129032229.S4GK773Am5s4MFZcMKyatIYX3p5dEpG7QFIbrBf9SPs@z>

On Fri, 26 Nov 2010 15:39:04 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Optimize the page_lock_anon_vma() fast path to be one LOCKed op,
> instead of two.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

The reference count seems to make things easier :)


