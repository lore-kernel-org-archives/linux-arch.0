From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Date: Tue, 20 Aug 2019 16:26:28 +0800
Message-ID: <CAJF2gTQhEHC-PUb0bORu2DLdgPOKh5kG7=mCi7=dMfCMZOUAcA@mail.gmail.com>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
 <20190816070348.GA13766@infradead.org> <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
 <20190818182118.GA30141@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818182118.GA30141@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
