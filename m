Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40552 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCBLI2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2015 06:08:28 -0500
Date: Mon, 2 Mar 2015 06:06:14 -0500 (EST)
Subject: Re: PMD update corruption (sync question)
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Message-ID: <1172437505.28092883.1425294374323.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20150302105011.GD22541@e104818-lin.cambridge.arm.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org> <54F06636.6080905@redhat.com> <54F3C6AD.50300@redhat.com> <938476184.27970130.1425275915893.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com> <20150302105011.GD22541@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: gary.robertson@linaro.org, Steve Capper <steve.capper@linaro.org>, mark.rutland@arm.com, hughd@google.com, christoffer.dall@linaro.org, akpm@linux-foundation.org, peterz@infradead.org, mgorman@suse.de, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, dann.frazier@canonical.com, anders.roxell@linaro.org
Message-ID: <20150302110614.7FfAGjF_t81T94MbUchzzawSUO9a8OZ-8t2x1JM76YM@z>

64-bit writes are /usually/ atomic but alignment or compiler emiting 32-bit opcodes could also do it. I agree there are a few other pieces to this we will chat about separately and come back to this thread. Time for some zzzz...long weekend!

-- 
Computer Architect | Sent from my #ARM Powered Mobile Device

On Mar 2, 2015 5:50 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Mar 02, 2015 at 12:58:36AM -0500, Jon Masters wrote: 
> > I've pulled aOn Mon, Mar 02, 2015 at 12:58:36AM -0500, Jon Masters wrote:
> I've pulled a couple of all nighters reproducing this hard to trigger
> issue and got some data. It looks like the high half of the (note always
> userspace) PMD is all zeros or all ones, which makes me wonder if the
> logic in update_mmu_cache might be missing something on AArch64.

That's worrying but I can tell you offline why ;).

Anyway, 64-bit writes are atomic on ARMv8, so you shouldn't see half
updates. To make sure the compiler does not generate something weird,
change the set_(pte|pmd|pud) to use an inline assembly with a 64-bit
STR.

One question - is the PMD a table or a block? You mentioned set_pte_at
at some point, which leads me to think it's a (transparent) huge page,
hence block mapping.

> When a kernel is built with 64K pages and 2 levels the PMD is
> effectively updated using set_pte_at, which explicitly won't perform a
> DSB if the address is userspace (it expects this to happen later, in
> update_mmu_cache as an example.
> 
> Can anyone think of an obvious reason why we might not be properly
> flushing the changes prior to them being consumed by a hardware walker?

Even if you don't have that barrier, the worst that can happen is that
you get another trap back in the kernel (from user; translation fault)
but the page table read by the kernel is valid and normally the
instruction restarted.

> Test kernels running with an explicit DSB in all PTE update cases now
> running overnight. Just in case.

It could be hiding some other problems.

-- 
Catalin
