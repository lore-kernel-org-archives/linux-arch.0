From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 1
Date: Tue, 14 Mar 2017 08:47:29 +0100
Message-ID: <20170314074729.GA23151@gmail.com>
References: <20170313143309.16020-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdCNHre (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2017 03:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20170313143309.16020-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Here's the first bunch of patches of 5-level patchset. Let's see if I'm on
> right track addressing Ingo's feedback. :)
> 
> These patches prepare x86 code to be switched from <asm-generic/5level-fixup>
> to <asm-generic/pgtable-nop4d.h>. It's a stepping stone for adding 5-level
> paging support.
> 
> Please review and consider applying.
> 
> Kirill A. Shutemov (6):
>   x86/mm: Extend headers with basic definitions to support 5-level
>     paging
>   x86/mm: Convert trivial cases of page table walk to 5-level paging
>   x86/gup: Add 5-level paging support
>   x86/ident_map: Add 5-level paging support
>   x86/vmalloc: Add 5-level paging support
>   x86/power: Add 5-level paging support
> 
>  arch/x86/include/asm/pgtable-2level_types.h |  1 +
>  arch/x86/include/asm/pgtable-3level_types.h |  1 +
>  arch/x86/include/asm/pgtable.h              | 26 +++++++++---
>  arch/x86/include/asm/pgtable_64_types.h     |  1 +
>  arch/x86/include/asm/pgtable_types.h        | 30 ++++++++++++-
>  arch/x86/kernel/tboot.c                     |  6 ++-
>  arch/x86/kernel/vm86_32.c                   |  6 ++-
>  arch/x86/mm/fault.c                         | 66 +++++++++++++++++++++++++----
>  arch/x86/mm/gup.c                           | 33 ++++++++++++---
>  arch/x86/mm/ident_map.c                     | 51 +++++++++++++++++++---
>  arch/x86/mm/init_32.c                       | 22 +++++++---
>  arch/x86/mm/ioremap.c                       |  3 +-
>  arch/x86/mm/pgtable.c                       |  4 +-
>  arch/x86/mm/pgtable_32.c                    |  8 +++-
>  arch/x86/platform/efi/efi_64.c              | 13 ++++--
>  arch/x86/power/hibernate_32.c               |  7 ++-
>  arch/x86/power/hibernate_64.c               | 50 ++++++++++++++++------
>  17 files changed, 269 insertions(+), 59 deletions(-)

Much better!

I've applied them, with (very) minor readability edits here and there, and will 
push them out into tip:x86/mm and tip:master after some testing - you can use that 
as a base for the remaining submissions.

I've also applied the GUP patch, with the assumption that you'll address Linus's 
request to switch x86 over to the generic version.

Thanks,

	Ingo
