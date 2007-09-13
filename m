Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:24347 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXIMIhW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2007 04:37:22 -0400
Received: by rv-out-0910.google.com with SMTP id k20so328768rvb
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2007 01:37:21 -0700 (PDT)
Message-ID: <8bd0f97a0709130137l55977c28w95cf8527ae8b9e24@mail.gmail.com>
Date: Thu, 13 Sep 2007 04:37:18 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] Blackfin arch: add some missing syscall
In-Reply-To: <20070913081852.GC17367@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1189670203.30686.15.camel@roc-desktop>
	 <20070913081852.GC17367@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Bryan Wu <bryan.wu@analog.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 9/13/07, Matthew Wilcox <matthew@wil.cx> wrote:
> On Thu, Sep 13, 2007 at 03:56:43PM +0800, Bryan Wu wrote:
> > +/* Not relevant on no-mmu */
>
> I thought this list seemed a little long, so I investigated a couple
> of them.  mbind makes sense (it's only implemented for NUMA ... a NUMA
> embedded platform?  not the kind which runs applications that use mbind),

sorry, i dont quite follow ... you're saying it does or doesnt make
sense to have NUMA syscalls on a no-mmu platform ?  my [limited]
understanding of NUMA is that it, by definition, requires a MMU in
order to shunt pages around

> but mremap doesn't -- there's even an implementation in mm/nommu.c.
> Could you check the rest of these over to see if they truly don't need
> to be implemented for no-mmu?

you're right we want mremap, my fault

> I think you'll want the *robust_list syscalls too.

lack of man pages on these made be lazy and dump em into the mmu pile
when in reality they have nothing to do with it ... we do want these

> > +#define __IGNORE_swapon
> > +#define __IGNORE_swapoff

a no brainer -- not usable on no-mmu

> > +#define __IGNORE_msync
> > +#define __IGNORE_remap_file_pages
> > +#define __IGNORE_mlock
> > +#define __IGNORE_munlock
> > +#define __IGNORE_mlockall
> > +#define __IGNORE_munlockall
> > +#define __IGNORE_mincore
> > +#define __IGNORE_madvise

implementation only exists for mmu

> > +#define __IGNORE_mbind
> > +#define __IGNORE_get_mempolicy
> > +#define __IGNORE_set_mempolicy
> > +#define __IGNORE_migrate_pages
> > +#define __IGNORE_move_pages

NUMA only

> > +#define __IGNORE_mremap
> > +#define __IGNORE_set_robust_list
> > +#define __IGNORE_get_robust_list

we want these

> > +#define __IGNORE_getcpu

useful only with SMP so i guess we should do it
-mike
