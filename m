Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36722 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab2GZTnD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2012 15:43:03 -0400
Message-ID: <1343331770.32120.6.camel@twins>
Subject: Re: [RFC][PATCH 0/2] fun with tlb flushing on s390
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Jul 2012 21:42:50 +0200
In-Reply-To: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
References: <1343317634-13197-1-git-send-email-schwidefsky@de.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Zachary Amsden <zach@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20120726194250.UihdYx3wP3cBZKtEDGPzkpxHrrzQclQflZLxthp-LCM@z>

On Thu, 2012-07-26 at 17:47 +0200, Martin Schwidefsky wrote:
> A code review revealed another potential race in regard to TLB flushing
> on s390. See patch #2 for the ugly details. To fix this I would like
> to use the arch_enter_lazy_mmu_mode/arch_leave_lazy_mmu_mode but to do
> that the pointer to the mm in question needs to be added to the functions.
> To keep things symmetrical arch_flush_lazy_mmu_mode should grow an mm
> argument as well.
> 
> powerpc 

I have a patch that makes sparc64 do the same thing.

> and x86 have a non-empty implementation for the lazy mmu flush
> primitives and tile calls the generic definition in the architecture
> files (which is a bit strange because the generic definition is empty).
> Comments?

argh.. you're making my head hurt.

I guess my first question is where is lazy_mmu_mode active crossing an
mm? I thought it was only ever held across operations on a single mm.

The second question would be if you could use that detach_mm thing I
proposed a while back ( http://marc.info/?l=linux-mm&m=134090072917840 )
or can we rework the active_mm magic in general to make all this easier?

Your 2/2 patch makes me shiver..
