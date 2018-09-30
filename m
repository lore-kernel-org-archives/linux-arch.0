Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45326 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbeI3RnY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Sep 2018 13:43:24 -0400
Date: Sun, 30 Sep 2018 19:10:36 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Message-ID: <20180930111036.GA5395@guoren>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
 <20180928162116.GF19827@infradead.org>
 <20180929150840.GA9311@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929150840.GA9311@guoren-Inspiron-7460>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180930111036.oWiW6JV2F8-38KRhJVS3UhLUzTuHByYK4eIbMhoohSQ@z>

On Sat, Sep 29, 2018 at 11:08:41PM +0800, Guo Ren wrote:
> On Fri, Sep 28, 2018 at 09:21:16AM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 28, 2018 at 08:51:17AM +0800, Guo Ren wrote:
> > > The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
> > > broken for some combinations that end up in a BUG() instead of performing
> > > the necessary flushes.
> > 
> > This should be folded into the original patch adding this code.
> Ok, I'll rebase it.
Sorry, my git-tree has been included in linux-next. I really don't want to rebase
it.
