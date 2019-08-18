Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRCUd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 17 Aug 2019 22:20:33 -0400
MIME-Version: 1.0
References: <1565868537-17753-1-git-send-email-guoren@kernel.org> <20190816070348.GA13766@infradead.org>
In-Reply-To: <20190816070348.GA13766@infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 18 Aug 2019 10:20:18 +0800
Message-ID: <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190818022018.G2P5qWcDhY1xmWBKesa4M2ly0ORa_u2uElgZB9M-so4@z>

Thx Christoph,

On Fri, Aug 16, 2019 at 3:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 15, 2019 at 07:28:57PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Implement the following apis to meet usage in different scenarios.
> >
> >  - ioremap          (NonCache + StrongOrder)
> >  - ioremap_nocache  (NonCache + StrongOrder)
> >  - ioremap_wc       (NonCache + WeakOrder  )
> >  - ioremap_cache    (   Cache + WeakOrder  )
> >
> > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
>
> Looks generally fine, but two comments:
>
>  - do you have a need for ioremap_cache?  We are generally try to
>    phase it out in favour of memremap, and it is generally only used
>    by arch specific code.
Yes, some drivers of our customers use ioremap_cache to map phy_addr
which isn't belong to system memory.

>  - I have a big series pending to clean up the mess with our
>    ioremap_* functions, including adding a generic implementation
>    that csky should be able to use.  Unless this patch is urgent it
>    might make sense to rebase it on top.  Here is my current tree, I
>    plan to post it soon:
>
>         http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
I agree to use GENERIC_IOREMAP, but I want to add csky support
GENERIC_IOREMAP patch by myself.
You could remove "csky: use generic ioremap" in your patchset first
and I'll add support GENERIC_IORMAP patch later.
Then we won't get confilct :)

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
