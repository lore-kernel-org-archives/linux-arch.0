From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Tue, 20 Jun 2017 00:52:10 +0300
Message-ID: <20170619215210.2crwjou3sfdcj73d@node.shutemov.name>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
 <20170619152228.GE3024@e104818-lin.cambridge.arm.com>
 <20170619160005.wgj4nymtj2nntfll@node.shutemov.name>
 <20170619170911.GF3024@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36466 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdFSVwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 17:52:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id d17so19330012wme.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 14:52:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170619170911.GF3024@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Jun 19, 2017 at 06:09:12PM +0100, Catalin Marinas wrote:
> On Mon, Jun 19, 2017 at 07:00:05PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Jun 19, 2017 at 04:22:29PM +0100, Catalin Marinas wrote:
> > > On Thu, Jun 15, 2017 at 05:52:22PM +0300, Kirill A. Shutemov wrote:
> > > > We need an atomic way to setup pmd page table entry, avoiding races with
> > > > CPU setting dirty/accessed bits. This is required to implement
> > > > pmdp_invalidate() that doesn't loose these bits.
> > > > 
> > > > On PAE we have to use cmpxchg8b as we cannot assume what is value of new pmd and
> > > > setting it up half-by-half can expose broken corrupted entry to CPU.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > I'll look at this from the arm64 perspective. It would be good if we can
> > > have a generic atomic implementation based on cmpxchg64 but I need to
> > > look at the details first.
> > 
> > Unfortunately, I'm not sure it's possbile.
> > 
> > The format of a page table is defined per-arch. We cannot assume much about
> > it in generic code.
> > 
> > I guess we could make it compile by casting to 'unsigned long', but is it
> > useful?
> > Every architecture manintainer still has to validate that this assumption
> > is valid for the architecture.
> 
> You are right, not much gained in doing this.
> 
> Maybe a stupid question but can we not implement pmdp_invalidate() with
> something like pmdp_get_and_clear() (usually reusing the ptep_*
> equivalent). Or pmdp_clear_flush() (again, reusing ptep_clear_flush())?
> 
> In my quick grep on pmdp_invalidate, it seems to be followed by
> set_pmd_at() or pmd_populate() already and the *pmd value after
> mknotpresent isn't any different from 0 to the hardware (at least on
> ARM). That's unless Linux expects to see some non-zero value here if
> walking the page tables on another CPU.

The whole reason to have pmdp_invalidate() in first place is to never make
pmd clear in the middle. Otherwise we will get race with MADV_DONTNEED.
See ced108037c2a for an example of such race.

-- 
 Kirill A. Shutemov
