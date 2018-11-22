Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34269 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406221AbeKWDuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Nov 2018 22:50:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so8551485ljd.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 09:10:06 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p186sm7405752lfd.83.2018.11.22.09.10.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:10:04 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id f23so6965311lfc.13
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 09:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
In-Reply-To: <20181122170715.GI30658@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Nov 2018 09:09:47 -0800
Message-ID: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org, the arch/x86 maintainers <x86@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, jdmason@kudzu.us, xen-devel@lists.xenproject.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Message-ID: <20181122170947.7dY2SY8UeTMD2zcNyxuanD-WpgPR2bjIjt5gvf76t0g@z>

On Thu, Nov 22, 2018 at 9:07 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> I'm afraid that won't work very well - 32 bit platforms with 64-bit
> addresses (LPAE) would have dma_addr_t as a 64-bit value, which
> wouldn't fit into an unsigned long.

Good point. So we'd have to have a special IS_DMA_ERR() function that
takes a dma_addr_t and checks the same "is it the top 4095 values".

Because I'd still prefer to allow people to return the _actual_ error,
and to have "return -Exyz" as the error case. That part still DTRT
even with dma_addr_t.

              Linus
