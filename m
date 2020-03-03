From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: About commit "io: change inX() to have their own IO barrier overrides"
Date: Tue, 3 Mar 2020 17:40:07 +0100
Message-ID: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgCCQk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Mar 2020 11:40:26 -0500
In-Reply-To: <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>

On Tue, Mar 3, 2020 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>
> + linux-arch
>
> For background, see
> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>
> >>
> >> So today only ARM64 uses it for this relevant code, above. But maybe
> >> others in future will want to use it - any arch without native IO port
> >> access is a candidate.
> >
> > I'm looking at Arnd here for help.
> >
> >>
> >>>
> >>> As long as the expectations are set, I see no reason why it shouldn't
> >>> but, I'll let Arnd comment on it too.
> >>
> >> ok, so it looks reasonable consider replicating your change for ***, above.
>
> To be clear, I would make this change in lib/logic_pio.c since
> __io_pbr() can be overridden per-arch:
>
>   #define BUILD_LOGIC_IO(bw, type)
>   type logic_in##bw(unsigned long addr)
>   {
>        type ret = (type)~0;
>        if (addr < MMIO_UPPER_LIMIT) {
> -          ret = read##bw(PCI_IOBASE + addr);
> +          __io_pbr();
> +          ret = __raw_read##bw(PCI_IOBASE + addr);
> +          __io_pbr();

__io_par();

>        } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
>            struct logic_pio_hwaddr *entry = find_io_range(addr);
>
> ...
>
> (forgetting leX_to_cpu for the moment)

Yes, I suppose this is required to get consistent behavior on arm64,
which overrides __io_par() but not __io_ar(), with the current code
the barrier after read is weaker when LOGIC_PIO is enabled than it
is otherwise.

For other architectures, I suppose we would need another indirection
level, as those can also override the default inb() itself to do something
other than readb(PCI_IOBASE + addr), and that is not handled
here either. We can do that if we need LOGIC_PIO on a second
architecture.

       Arnd
