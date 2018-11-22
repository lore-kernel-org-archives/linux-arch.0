Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33073 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbeKWDbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Nov 2018 22:31:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so6958856lfc.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 08:51:07 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q4-v6sm2954091ljb.4.2018.11.22.08.51.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:51:04 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id c19-v6so8505633lja.5
        for <linux-arch@vger.kernel.org>; Thu, 22 Nov 2018 08:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de>
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Nov 2018 08:50:47 -0800
Message-ID: <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, jdmason@kudzu.us, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, m.szyprowski@samsung.com, robin.murphy@arm.com, the arch/x86 maintainers <x86@kernel.org>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-ID: <20181122165047.ka6YzrLCssyDtX5G7pZ76Ym4c-qPzE7cuEn4noA6UdA@z>

On Thu, Nov 22, 2018 at 6:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The 0 return doesn't work for direct mappings that have ram at address
> zero and a lot of IOMMUs that start allocating bus space from address
> zero, so we can't consolidate on that, but I think we can move everyone
> to all-Fs, which the patch here does.

Hmm. Maybe not limit it to just all ones, but actually use the
(standard, for the kernel) IS_ERR_VALUE()?

That basically reserves the last 4095 values in an unsigned long for
error values.

Then those functions could actually return *what* error they
encountered, using just plain

        return -ENOMEM;

or whatever?

               Linus
