From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Sat, 28 Aug 2010 18:19:31 +0300
Message-ID: <AANLkTikhV6PLb_pRmBmjynft4pe4paKogFP-JR7aXXyv@mail.gmail.com>
References: <20100828141637.421594670@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55760 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0H1PTe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 11:19:34 -0400
In-Reply-To: <20100828141637.421594670@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Peter,

On Sat, Aug 28, 2010 at 5:16 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Yanmin ran the last posting through the comprehensive Intel test farm
> and didn't find any regressions.

Is there data somewhere that shows where this helps and how much?

                        Pekka
