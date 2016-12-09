From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCHv1 00/28] 5-level paging
Date: Fri, 09 Dec 2016 11:24:12 +0100
Message-ID: <13962749.Q2mLWEctkQ@wuerfel>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com> <20161209050130.GC2595@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53474 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbcLIK1H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2016 05:27:07 -0500
In-Reply-To: <20161209050130.GC2595@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, maxim.kuvyrkov@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, broonie@kernel.org, schwidefsky@de.ibm.com

On Friday, December 9, 2016 6:01:30 AM CET Ingo Molnar wrote:
> >   - Handle opt-in wider address space for userspace.
> > 
> >     Not all userspace is ready to handle addresses wider than current
> >     47-bits. At least some JIT compiler make use of upper bits to encode
> >     their info.
> > 
> >     We need to have an interface to opt-in wider addresses from userspace
> >     to avoid regressions.
> > 
> >     For now, I've included testing-only patch which bumps TASK_SIZE to
> >     56-bits. This can be handy for testing to see what breaks if we max-out
> >     size of virtual address space.
> 
> So this is just a detail - but it sounds a bit limiting to me to provide an 'opt 
> in' flag for something that will work just fine on the vast majority of 64-bit 
> software.
> 
> Please make this an opt out compatibility flag instead: similar to how we handle 
> address space layout limitations/quirks ABI details, such as ADDR_LIMIT_32BIT, 
> ADDR_LIMIT_3GB, ADDR_COMPAT_LAYOUT, READ_IMPLIES_EXEC, etc.

We've had a similar discussion about JIT software on ARM64, which has a wide
range of supported page table layouts and some software wants to limit that
to a specific number.

I don't remember the outcome of that discussion, but I'm adding a few people
to Cc that might remember.

There have also been some discussions in the past to make the depth of the
page table a per-task decision on s390, since you may have some tasks that
run just fine with two or three levels of paging while another task actually
wants the full 64-bit address space. I wonder how much extra work this would
be on top of the boot-time option.

	Arnd
