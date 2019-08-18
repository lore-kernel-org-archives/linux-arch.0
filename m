Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Aug 2019 14:21:20 -0400
Date: Sun, 18 Aug 2019 11:21:18 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Message-ID: <20190818182118.GA30141@infradead.org>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
 <20190816070348.GA13766@infradead.org>
 <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190818182118.PkNohX0Qt7dwwSN3_c9SRYrUE8dfCrOCK5Q4ybrh56M@z>

On Sun, Aug 18, 2019 at 10:20:18AM +0800, Guo Ren wrote:
> > > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
> >
> > Looks generally fine, but two comments:
> >
> >  - do you have a need for ioremap_cache?  We are generally try to
> >    phase it out in favour of memremap, and it is generally only used
> >    by arch specific code.
> Yes, some drivers of our customers use ioremap_cache to map phy_addr
> which isn't belong to system memory.

Which driver?  We should move it over to memremap instead of adding
a new ioremap_cache.

> I agree to use GENERIC_IOREMAP, but I want to add csky support
> GENERIC_IOREMAP patch by myself.
> You could remove "csky: use generic ioremap" in your patchset first
> and I'll add support GENERIC_IORMAP patch later.
> Then we won't get confilct :)

Ok.
