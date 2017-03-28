Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36090 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbdC1JkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 05:40:21 -0400
Date: Tue, 28 Mar 2017 11:39:46 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 6/8] x86/dump_pagetables: Add support 5-level paging
Message-ID: <20170328093946.GA30567@gmail.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-7-kirill.shutemov@linux.intel.com>
 <20170328061259.GC20135@gmail.com>
 <20170328093040.wayhvqxijreps2mq@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328093040.wayhvqxijreps2mq@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170328093946.p4Ml-CUtUZrOT4ZkTWoo-2CAlfq4sN8LBeUerfu2vYQ@z>


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Tue, Mar 28, 2017 at 08:12:59AM +0200, Ingo Molnar wrote:
> > 
> > * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> > 
> > > +#if PTRS_PER_P4D > 1
> > > +
> > > +static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
> > > +							unsigned long P)
> > 
> > Pretty ugly line break. Either don't break the line, or break it in a more logical 
> > place, like:
> > 
> > static void
> > walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr, unsigned long P)
> > 
> > > +	start = (p4d_t *) pgd_page_vaddr(addr);
> > 
> > The space between the type cast and the function invocation is not needed.
> 
> Both style issues you have pointed to are inherited from handling of other
> page table levels.
> 
> Do you want me to adjust them too?

Yes, pre-existing uncleanlinesses are not a reason to replicate them going 
forward. Feel free to do it in a separate preparatory patch if the noise
is too large.

Thanks,

	Ingo
