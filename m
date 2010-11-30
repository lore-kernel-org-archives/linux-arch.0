From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 01/21] mm: Revert page_lock_anon_vma() lock annotation
Date: Tue, 30 Nov 2010 10:19:11 +0900 (JST)
Message-ID: <20101130101931.82EC.A69D9226@jp.fujitsu.com>
References: <20101126143843.801484792@chello.nl> <20101126145410.315243256@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58183 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab0K3BTP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2010 20:19:15 -0500
In-Reply-To: <20101126145410.315243256@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Namhyung Kim <namhyung@gmail.com>

> Its beyond ugly and gets in the way.
> 
> Cc: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

+1

/me run away.
