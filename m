From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 03/20] mm: Rename drop_anon_vma to put_anon_vma
Date: Sat, 28 Aug 2010 18:08:48 +0300
Message-ID: <AANLkTim5Bf3ZL49DKz=eN0y6XPst6L1KkVB3kPzePgY3@mail.gmail.com>
References: <20100828141637.421594670@chello.nl>
	<20100828142455.601189436@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40963 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0H1PIt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 11:08:49 -0400
In-Reply-To: <20100828142455.601189436@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On Sat, Aug 28, 2010 at 5:16 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> The normal code pattern used in the kernel is: get/put.
>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Pekka Enberg <penberg@kernel.org>
