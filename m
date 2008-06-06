From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 1/5] x86: implement pte_special
Date: Fri, 06 Jun 2008 23:35:40 +0200
Message-ID: <1212788140.19205.76.camel@lappy.programming.kicks-ass.net>
References: <20080529122050.823438000@nick.local0.net>
	 <20080529122602.062780000@nick.local0.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:55976 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576AbYFFVf4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jun 2008 17:35:56 -0400
In-Reply-To: <20080529122602.062780000@nick.local0.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

On Thu, 2008-05-29 at 22:20 +1000, npiggin@suse.de wrote:
> plain text document attachment (x86-implement-pte_special.patch)
> Implement the pte_special bit for x86. This is required to support lockless
> get_user_pages, because we need to know whether or not we can refcount a
> particular page given only its pte (and no vma).
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> Cc: shaggy@austin.ibm.com
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: apw@shadowen.org

Full series:

Reviewed-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
