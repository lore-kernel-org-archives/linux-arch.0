From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 22/26] x86/mm: add sync_global_pgds() for configuration
 with 5-level paging
Date: Mon, 13 Mar 2017 08:22:27 +0100
Message-ID: <20170313072227.GB28726@gmail.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-23-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35680 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdCMHWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2017 03:22:32 -0400
Content-Disposition: inline
In-Reply-To: <20170313055020.69655-23-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> This basically restores slightly modified version of original
> sync_global_pgds() which we had before foldedl p4d was introduced.

Please read your changelogs, I saw several typos/grammar mistakes in earlier 
patches. The one here is:

	s/foldedl/folded

> +	for (address = start; address <= end && address >= start;
> +			address += PGDIR_SIZE) {

Please don't address col80 checkpatch warnings by breaking the line in such an 
ugly way! Find another method, or just leave it slightly longer than 80 cols.

This one could probably be solved by:

	s/address/addr

... which is the canonical variable name for such iterations anyway.

> +			/* the pgt_lock only for Xen */

Please use whole sentences in comments, and please capitalize them properly.

I.e. here:


			/* We acquire the pgt_lock only for Xen: */

> +				BUG_ON(pgd_page_vaddr(*pgd)
> +						!= pgd_page_vaddr(*pgd_ref));

Ugly col80 artifact ...

Please review the rest of the series for similar patterns as well, and please only 
post 5-10 patches in the next submission - we'll review and apply them step by 
step.

Thanks,

	Ingo
