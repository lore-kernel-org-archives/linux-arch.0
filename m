Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHUDoG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 23:44:06 -0400
MIME-Version: 1.0
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
 <1566304469-5601-3-git-send-email-guoren@kernel.org> <20190821021741.GB32710@infradead.org>
In-Reply-To: <20190821021741.GB32710@infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 21 Aug 2019 11:43:51 +0800
Message-ID: <CAJF2gTSXZB4r6_BdNZ+8p_Z2A-AVLyz00o2qdRUMjzZ3b7z6iA@mail.gmail.com>
Subject: Re: [PATCH 3/3] csky: Support kernel non-aligned access
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190821034351.Kvd60MUw-GTOs_9buaN8j0nQyPQlVIp6MKty0kez8YA@z>

Thx Christoph

On Wed, Aug 21, 2019 at 10:17 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Aug 20, 2019 at 08:34:29PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > We prohibit non-aligned access in kernel mode, but some special NIC
> > driver needs to support kernel-state unaligned access. For example,
> > when the bus does not support unaligned access, IP header parsing
> > will cause non-aligned access and driver does not recopy the skb
> > buffer to dma for performance reasons.
> >
> > Added kernel_enable & user_enable to control unaligned access and
> > added kernel_count  & user_count for statistical unaligned access.
>
> If the NIC drivers requires this it is buggy.
Yes, you are right, but I've no control on their non-upstreamed
drivers. Every time kernel version updated I need to take care of that
issue for them. So just give them a back door in arch/csky and they
could disable it by manual.

> Kernel code must
> use the get_unaligned* / put_unaligned* helpers for that.
Most of ethernet drivers use netdev_alloc_skb_ip_align() to let
hardware deal with unaligned access,
but some NICs couldn't and we may modify kernel's skb_ip_header
parsing code with get_unaligned*/put_unaligned* ?

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
