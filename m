Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:56952 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161390AbWJSKyq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Oct 2006 06:54:46 -0400
Message-ID: <45375971.8080707@yahoo.com.au>
Date: Thu, 19 Oct 2006 20:54:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 1/4] mm: arch do_page_fault() vs in_atomic()
References: <20061019101722.805147000@chello.nl> <20061019102309.179968000@chello.nl>
In-Reply-To: <20061019102309.179968000@chello.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Hi Peter,
This patchset looks pretty nice to me.

Acked-by: Nick Piggin <npiggin@suse.de>

One minor nit:

Peter Zijlstra wrote:
> In light of the recent pagefault and filemap_copy_from_user work I've
> gone through all the arch pagefault handlers to make sure the 
> inc_preempt_count() 'feature' works as expected.
> 
> Several sections of code (including the new filemap_copy_from_user) rely
> on the fact that faults do not take locks under increased preempt count.
> 
> arch/x86_64 - good
> arch/powerpc - good
> arch/cris - fixed
> arch/i386 - good
> arch/parisc - fixed
> arch/sh - good
> arch/sparc - good
> arch/s390 - good
> arch/m68k - fixed
> arch/ppc - good
> arch/alpha - fixed
> arch/mips - good
> arch/sparc64 - good
> arch/ia64 - good
> arch/arm - fixed
> arch/um - NA

um does have a fault handler (in kernel/trap.c), but it gets the
in_atomic check correct.

Thanks for doing this.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
