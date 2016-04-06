From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 10/10] arch: fix has_transparent_hugepage()
Date: Wed, 6 Apr 2016 23:58:19 +0200
Message-ID: <20160406215819.GA25650@gmail.com>
References: <alpine.LSU.2.11.1604051329480.5965@eggly.anvils>
 <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
 <20160406065806.GC3078@gmail.com>
 <57050111.3070507@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34839 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbcDFV6Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2016 17:58:24 -0400
Content-Disposition: inline
In-Reply-To: <57050111.3070507@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andres Lagar-Cavilla <andreslc@google.com>, Yang Shi <yang.shi@linaro.org>, Ning Qu <quning@gmail.com>, Arnd Bergman <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org


* Chris Metcalf <cmetcalf@mellanox.com> wrote:

> On 4/6/2016 2:58 AM, Ingo Molnar wrote:
> >* Hugh Dickins <hughd@google.com> wrote:
> >
> >>--- a/arch/x86/include/asm/pgtable.h
> >>+++ b/arch/x86/include/asm/pgtable.h
> >>@@ -181,6 +181,7 @@ static inline int pmd_trans_huge(pmd_t p
> >>  	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
> >>  }
> >>+#define has_transparent_hugepage has_transparent_hugepage
> >>  static inline int has_transparent_hugepage(void)
> >>  {
> >>  	return cpu_has_pse;
> >Small nit, just writing:
> >
> >   #define has_transparent_hugepage
> >
> >ought to be enough, right?
> 
> No, since then in hugepage_init() the has_transparent_hugepage() call site
> would be left with just a stray pair of parentheses instead of a call.

Yes, indeed ...

Thanks,

	Ingo
