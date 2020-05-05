From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/hugetlb: Introduce
 HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
Date: Tue, 5 May 2020 13:12:06 -0700
Message-ID: <20200505131206.bee7b103431bff077c2ca0cf@linux-foundation.org>
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
        <1586864670-21799-4-git-send-email-anshuman.khandual@arm.com>
        <20200425175511.7a68efb5e2f4436fe0328c1d@linux-foundation.org>
        <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
        <20200425200124.20d0c75fcaef05d062d3667c@linux-foundation.org>
        <21460cbc-8e9a-b956-5797-57b2e1df9fb1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgEEUMJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 16:12:09 -0400
In-Reply-To: <21460cbc-8e9a-b956-5797-57b2e1df9fb1@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, David S.

On Tue, 5 May 2020 08:21:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> >>> static inline void arch_clear_hugepage_flags(struct page *page)
> >>> {
> >>> 	<some implementation>
> >>> }
> >>> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> >>>
> >>> It's a small difference - mainly to avoid adding two variables to the
> >>> overall namespace where one would do.
> >>
> >> Understood, will change and resend.
> > 
> > That's OK - I've queued up that fix.
> >
> 
> Hello Andrew,
> 
> I might not have searched all the relevant trees or might have just searched
> earlier than required. But I dont see these patches (or your proposed fixes)
> either in mmotm (2020-04-29-23-04) or in next-20200504. Wondering if you are
> waiting on a V2 for this series accommodating the changes you had proposed.

hm.  I think I must have got confused and thought you were referring to
a different patch.  Yes please, let's have v2.
