Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:43113 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeDZJkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Apr 2018 05:40:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180426082429.GA15580@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de>
 <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
 <20180424191640.GA32495@lst.de> <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com>
 <20180425064055.GA11460@lst.de> <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com>
 <20180426064239.GA13895@lst.de> <CAEbi=3e3gM_WpQOtKZXP4Xj2Az4bLf_u6BjDELqXy6-d9HurMQ@mail.gmail.com>
 <20180426082429.GA15580@lst.de>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 26 Apr 2018 17:39:20 +0800
Message-ID: <CAEbi=3dnduyq3k8hkoLu180EtwCQ5-Hz0jc1iviv70WXp7yUJg@mail.gmail.com>
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180426093920.mwBwPhazzq7J08_yORwF6zewXNi4lnAuVYO3zcSsccA@z>

2018-04-26 16:24 GMT+08:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Apr 26, 2018 at 04:06:34PM +0800, Greentime Hu wrote:
>> It works!!!
>
> Thanks!
>
> Can you retest the updated tree here with all the fixes and give me
> your Tested-by: for the generic and nds32 patches?
>
> git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent

Sorry Christoph. I found the previous mail I said it works was wrong
because I used a wrong vmlinux.
It still failed. >,<
