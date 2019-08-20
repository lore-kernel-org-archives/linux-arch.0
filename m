Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTI0n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 04:26:43 -0400
MIME-Version: 1.0
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
 <20190816070348.GA13766@infradead.org> <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
 <20190818182118.GA30141@infradead.org>
In-Reply-To: <20190818182118.GA30141@infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Aug 2019 16:26:28 +0800
Message-ID: <CAJF2gTQhEHC-PUb0bORu2DLdgPOKh5kG7=mCi7=dMfCMZOUAcA@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190820082628.gGuaPo80xaglJOmEUuH2Xma-0qndZWkuAhDw0MsXoeo@z>

On Mon, Aug 19, 2019 at 2:21 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Aug 18, 2019 at 10:20:18AM +0800, Guo Ren wrote:
> > > > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
> > >
> > > Looks generally fine, but two comments:
> > >
> > >  - do you have a need for ioremap_cache?  We are generally try to
> > >    phase it out in favour of memremap, and it is generally only used
> > >    by arch specific code.
> > Yes, some drivers of our customers use ioremap_cache to map phy_addr
> > which isn't belong to system memory.
>
> Which driver?  We should move it over to memremap instead of adding
> a new ioremap_cache.
The driver hasn't been upstreamed. OK, just remove ioremap_cache and
seems it's not a big problem.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
