Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdABIro (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2017 03:47:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Date: Mon, 02 Jan 2017 09:44:46 +0100
Message-ID: <2736959.3MfCab47fD@wuerfel>
In-Reply-To: <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com> <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20170102084446.uWEp3_paRD2USzyXL0vEscWa5hAwGSdv-XXZokC3V9w@z>

On Tuesday, December 27, 2016 4:54:13 AM CET Kirill A. Shutemov wrote:
> This patch introduces new rlimit resource to manage maximum virtual
> address available to userspace to map.
> 
> On x86, 5-level paging enables 56-bit userspace virtual address space.
> Not all user space is ready to handle wide addresses. It's known that
> at least some JIT compilers use high bit in pointers to encode their
> information. It collides with valid pointers with 5-level paging and
> leads to crashes.
> 
> The patch aims to address this compatibility issue.
> 
> MM would use min(RLIMIT_VADDR, TASK_SIZE) as upper limit of virtual
> address available to map by userspace.
> 
> The default hard limit will be RLIM_INFINITY, which basically means that
> TASK_SIZE limits available address space.
> 
> The soft limit will also be RLIM_INFINITY everywhere, but the machine
> with 5-level paging enabled. In this case, soft limit would be
> (1UL << 47) - PAGE_SIZE. It’s current x86-64 TASK_SIZE_MAX with 4-level
> paging which known to be safe
> 
> New rlimit resource would follow usual semantics with regards to
> inheritance: preserved on fork(2) and exec(2). This has potential to
> break application if limits set too wide or too narrow, but this is not
> uncommon for other resources (consider RLIMIT_DATA or RLIMIT_AS).
> 
> As with other resources you can set the limit lower than current usage.
> It would affect only future virtual address space allocations.
> 
> Use-cases for new rlimit:
> 
>   - Bumping the soft limit to RLIM_INFINITY, allows current process all
>     its children to use addresses above 47-bits.
> 
>   - Bumping the soft limit to RLIM_INFINITY after fork(2), but before
>     exec(2) allows the child to use addresses above 47-bits.
> 
>   - Lowering the hard limit to 47-bits would prevent current process all
>     its children to use addresses above 47-bits, unless a process has
>     CAP_SYS_RESOURCES.
> 
>   - It’s also can be handy to lower hard or soft limit to arbitrary
>     address. User-mode emulation in QEMU may lower the limit to 32-bit
>     to emulate 32-bit machine on 64-bit host.
> 
> TODO:
>   - port to non-x86;
> 
> Not-yet-signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: linux-api@vger.kernel.org

This seems to nicely address the same problem on arm64, which has
run into the same issue due to the various page table formats
that can currently be chosen at compile time.

I don't see how this interacts with the existing
PER_LINUX32/PER_LINUX32_3GB personality flags, but I assume you have
either already thought of that, or we can come up with a good way
to define what happens when conflicting settings are applied.

The two reasonable ways I can think of are to either use the
minimum of the two limits, or to make the personality syscall
set the soft rlimit and use whatever limit was last set.

	Arnd
