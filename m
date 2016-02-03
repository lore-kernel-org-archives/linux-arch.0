Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:58498 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964815AbcBCQkO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2016 11:40:14 -0500
Date: Wed, 3 Feb 2016 17:39:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] [RFC] ARM: modify pgd_t definition for
 TRANSPARENT_HUGEPAGE_PUD
Message-ID: <20160203163946.GA20360@ravnborg.org>
References: <1773775.QWf7OyDGPh@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1773775.QWf7OyDGPh@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@linux.intel.com>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20160203163946.4LWu-N4WbuppyGqbbldOh8dWnUvJDkI_BStCAaMoDPQ@z>

On Wed, Feb 03, 2016 at 02:21:48PM +0100, Arnd Bergmann wrote:
> I ran into build errors on ARM after Willy's newly added generic
> TRANSPARENT_HUGEPAGE_PUD support. We don't support this feature
> on ARM at all, but the patch causes a build error anyway:
> 
> In file included from ../kernel/memremap.c:17:0:
> ../include/linux/pfn_t.h:108:7: error: 'pud_mkdevmap' declared as function returning an array
>  pud_t pud_mkdevmap(pud_t pud);
> 
> We don't use a PUD on ARM, so pud_t is defined as pmd_t, which
> in turn is defined as
> 
> typedef unsigned long pgd_t[2];
> 
> on NOMMU and on 2-level MMU configurations. There is an (unused)
> other definition using a struct around the array, which happens to
> work fine here.
> 
> There is a comment in the file about the fact the other version
> is "easier on the compiler", and I've traced that version back
> to linux-2.1.80 when ARM support was first merged back in 1998.
> 
> It's probably a safe assumption that this is no longer necessary:
> The same logic existed in asm-i386 at the time but was removed
> a year later in 2.3.23pre3. The STRICT_MM_TYPECHECKS logic
> also ended up getting copied into these files:
> 
> arch/alpha/include/asm/page.h
> arch/arc/include/asm/page.h
> arch/arm/include/asm/pgtable-3level-types.h
> arch/arm64/include/asm/pgtable-types.h
> arch/ia64/include/asm/page.h
> arch/parisc/include/asm/page.h
> arch/powerpc/include/asm/page.h
> arch/sparc/include/asm/page_32.h
> arch/sparc/include/asm/page_64.h

For the sparc32 case we use the simpler variants.
According to the comment this is due to limitation in
the way we pass arguments in the sparc32 ABI.
But I have not tried to compare a kernel for sparc32 with
and without the use of structs.

For sparc64 we use the stricter types (structs).
I did not check other architectures - but just wanted to
tell that the right choice may be architecture dependent.

	Sam
