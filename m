From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 20/25] mm: Simplify anon_vma refcounts
Date: Wed, 26 Jan 2011 06:16:08 +1000
Message-ID: <AANLkTikchW7Z6mSgcbt7wn9DWTeEGrKwfMwj1_WjMB5c@mail.gmail.com>
References: <20110125173111.720927511@chello.nl> <20110125174908.262260777@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58261 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101Ab1AYURB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Jan 2011 15:17:01 -0500
In-Reply-To: <20110125174908.262260777@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>

On Wed, Jan 26, 2011 at 3:31 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> This patch changes the anon_vma refcount to be 0 when the object is
> free. It does this by adding 1 ref to being in use in the anon_vma
> structure (iow. the anon_vma->head list is not empty).

Why is this patch part of this series, rather than being an
independent patch before the whole series?

I think this part of the series is the only total no-brainer, ie we
should have done this from the beginning. The preemptability stuff I'm
more nervous about (performance issues? semantic differences?)

             Linus
