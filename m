From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Wed, 21 Jun 2017 15:04:12 +0300
Message-ID: <20170621120412.cdmg76jy2zby56cx@node.shutemov.name>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
 <20170619152228.GE3024@e104818-lin.cambridge.arm.com>
 <20170619160005.wgj4nymtj2nntfll@node.shutemov.name>
 <20170619170911.GF3024@e104818-lin.cambridge.arm.com>
 <20170619215210.2crwjou3sfdcj73d@node.shutemov.name>
 <20170620155438.GC21383@e104818-lin.cambridge.arm.com>
 <20170621095303.q5fqt5a3ao5smko6@node.shutemov.name>
 <20170621112702.GC10220@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35186 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUMEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 08:04:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id n136so9199650lfn.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2017 05:04:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170621112702.GC10220@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jun 21, 2017 at 12:27:02PM +0100, Catalin Marinas wrote:
> On Wed, Jun 21, 2017 at 12:53:03PM +0300, Kirill A. Shutemov wrote:
> > > > > > > On Thu, Jun 15, 2017 at 05:52:22PM +0300, Kirill A. Shutemov wrote:
> > > > > > > > We need an atomic way to setup pmd page table entry, avoiding races with
> > > > > > > > CPU setting dirty/accessed bits. This is required to implement
> > > > > > > > pmdp_invalidate() that doesn't loose these bits.
> [...]
> > Any chance you could help me with arm too?
> 
> On arm (ARMv7 with LPAE) we don't have hardware updates of the
> access/dirty bits, so a generic implementation would suffice. I didn't
> find one in your patches, so here's an untested version:
> 
> static inline pmd_t pmdp_establish(struct mm_struct *mm, unsigned long address,
> 				   pmd_t *pmdp, pmd_t pmd)
> {
> 	pmd_t old_pmd = *pmdp;
> 	set_pmd_at(mm, address, pmdp, pmd);
> 	return old_pmd;
> }

Thanks, I'll integrate this into the patchset.

-- 
 Kirill A. Shutemov
