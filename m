Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46576 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaJPJZi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Oct 2014 05:25:38 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so3223407wgg.25
        for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2014 02:25:37 -0700 (PDT)
Date: Thu, 16 Oct 2014 10:25:30 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATCH 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Message-ID: <20141016092529.GA1524@linaro.org>
References: <1413390888-4934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413390888-4934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>, benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, linux@arm.linux.org.uk
Message-ID: <20141016092530.4hXoMX9o2Tms_Hmxtg35poBMsTRm8lJZ7Uqvuq4oXOQ@z>

On Wed, Oct 15, 2014 at 10:04:47PM +0530, Aneesh Kumar K.V wrote:
> Update generic gup implementation with powerpc specific details.
> On powerpc at pmd level we can have hugepte, normal pmd pointer
> or a pointer to the hugepage directory.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Hi,
This patch causes compiler errors on arm and arm64 due to pgd_huge
being undefined. I've attached a fixup below, this fixup will require
that #define pgd_huge(pgd) 0 be added back into:
arch/powerpc/include/asm/page.h
For the second patch in this series.

Another avenue would be to do something like:
#ifndef pgd_huge
#define pgd_huge(pgd)	(0)
#endif

Then no changes would be required to arm and arm64 (or other
architectures).

To help with bisectability, could we please have a suitable fix applied
to the two patches in the -mm tree:
http://ozlabs.org/~akpm/mmots/broken-out/mm-update-generic-gup-implementation-to-handle-hugepage-directory.patch
http://ozlabs.org/~akpm/mmots/broken-out/arch-powerpc-switch-to-generic-rcu-get_user_pages_fast.patch

rather than applied afterwards?

With pgd_huge(x) defined, this patch passes my futex test on arm
(Arndale platform) and arm64(Juno).

Cheers,
-- 
Steve
