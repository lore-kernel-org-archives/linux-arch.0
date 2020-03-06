From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: About commit "io: change inX() to have their own IO barrier overrides"
Date: Fri, 6 Mar 2020 08:54:26 +0100
Message-ID: <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com> <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:39107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCFHyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 02:54:46 -0500
In-Reply-To: <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>

On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 3/3/2020 11:40 AM, Arnd Bergmann wrote:
> >> -          ret = read##bw(PCI_IOBASE + addr);
> >> +          __io_pbr();
> >> +          ret = __raw_read##bw(PCI_IOBASE + addr);
> >> +          __io_pbr();
> > __io_par();
> >
>
> Why do we need to change read##bw above?
>
> read##bw already provides strong ordering guarantees across multiple
> architectures.

The exact semantics of inl() and readl() are slightly different, so they
have distinct sets of barriers in the asm-generic/io.h implementation.

For instance, the arm64 architectures defines in_par() as '__iormb(v)',
but defines __io_ar() as a  '__rmb()'. Similarly, riscv defines them
as "fence i,ior" and "fence i,r".

You could argue that the definitions are wrong (I have not checked the
history of the definitions), but as long as the inb() in asm-generic/io.h
uses those, the implementation in lib/logic_pio.c uses the same ones
to make the two behave the same way.

       Arnd
