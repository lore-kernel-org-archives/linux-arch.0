Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44287 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLAGx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Dec 2018 01:53:59 -0500
Received: by mail-lf1-f44.google.com with SMTP id z13so4926200lfe.11
        for <linux-arch@vger.kernel.org>; Fri, 30 Nov 2018 11:43:37 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c14sm973166lfb.40.2018.11.30.11.43.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 11:43:35 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id l10so4935827lfh.9
        for <linux-arch@vger.kernel.org>; Fri, 30 Nov 2018 11:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20181130132231.16512-1-hch@lst.de>
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Nov 2018 11:43:18 -0800
Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, jdmason@kudzu.us, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, robin.murphy@arm.com, the arch/x86 maintainers <x86@kernel.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-ID: <20181130194318.aBPiuEYWyyMmBYd4PR3lCvK7IVqWqTSJvH2EwkRIGtc@z>

On Fri, Nov 30, 2018 at 5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess. [..]

I don't see anything objectionable there, but it's not like I checked
any of the context of the patches. For all I know there are odd corner
cases where some zero vs DMA_MAPPING_ERROR confusion lurks, but I
guess we'll find out..

So you can add my acked-by, fwiw.

                Linus
