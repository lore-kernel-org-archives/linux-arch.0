Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40952 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753041AbeDZIWr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Apr 2018 04:22:47 -0400
Date: Thu, 26 Apr 2018 10:24:29 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-ID: <20180426082429.GA15580@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de> <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <20180424191640.GA32495@lst.de> <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com> <20180425064055.GA11460@lst.de> <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com> <20180426064239.GA13895@lst.de> <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180426082429.gVhgEa_gOY2wCVTJ_WGMs_eQr7u15x2loquoZMDK44o@z>

On Thu, Apr 26, 2018 at 04:06:34PM +0800, Greentime Hu wrote:
> It works!!!

Thanks!

Can you retest the updated tree here with all the fixes and give me
your Tested-by: for the generic and nds32 patches?

git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent
