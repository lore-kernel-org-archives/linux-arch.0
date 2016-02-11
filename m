Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:58613 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcBKKWe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Feb 2016 05:22:34 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 11 Feb 2016 10:22:32 -0000
Date: Thu, 11 Feb 2016 11:22:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] mm,thp: refactor generic deposit/withdraw routines
 for wider usage
Message-ID: <20160211112223.0acc8237@mschwide>
In-Reply-To: <1455182907-15445-2-git-send-email-vgupta@synopsys.com>
References: <1455182907-15445-1-git-send-email-vgupta@synopsys.com>
	<1455182907-15445-2-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Alex Thorlton <athorlton@sgi.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20160211102223.goQkduyjzSsT3zLqvW0kx-BnHM_aMT3TNxkUhBMm8l0@z>

On Thu, 11 Feb 2016 14:58:26 +0530
Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> Generic pgtable_trans_huge_deposit()/pgtable_trans_huge_withdraw()
> assume pgtable_t to be struct page * which is not true for all arches.
> Thus arc, s390, sparch end up with their own copies despite no special
> hardware requirements (unlike powerpc).

s390 does have a special hardware requirement. pgtable_t is an address
for a 2K block of memory. It is *not* equivalent to a struct page *
which refers to a 4K block of memory. That has been the whole point
to introduce pgtable_t.

> It seems massaging the code a bit can make it reusbale.

Imho the new code for asm-generic looks fine, as long as the override
with __HAVE_ARCH_PGTABLE_DEPOSIT/__HAVE_ARCH_PGTABLE_WITHDRAW continues
to work I do not mind.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

