Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41517 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbYBCFxR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Feb 2008 00:53:17 -0500
Date: Sat, 2 Feb 2008 21:53:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] CONFIG_HIGHPTE vs. sub-page page tables.
Message-Id: <20080202215315.3ac6907d.akpm@linux-foundation.org>
In-Reply-To: <1202017020.7208.2.camel@pasglop>
References: <20071112143009.425807965@de.ibm.com>
	<20071112144009.831296895@de.ibm.com>
	<20080201151541.8e3e0359.akpm@linux-foundation.org>
	<1202017020.7208.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Sun, 03 Feb 2008 16:37:00 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Why dropping add-mm-argument-to-pte-pmd-pud-pgd_free.patch though ?

I dropped the whole series.

> It's a sane patch and a helps going further, and a total pain to re-do
> later on. Besides, I may have some use for it on powerpc at some point
> too...

OK, I'll try to reestablish it.

Look: I can't fix *everyone's* stuff.  This was a consequence of ongoing
unbounded churn in the x86 tree.  If we can find a way of preventing those
guys (and everyone else) from trashing everyone else's stuff then we'd have
much smoother sailing.

Feel free to fix up Martin's patches against mmotm and we're good.  Should
take you less than an hour.

