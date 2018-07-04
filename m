Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50055 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933596AbeGDL61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jul 2018 07:58:27 -0400
Date: Wed, 4 Jul 2018 19:58:17 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Message-ID: <20180704115817.GA24372@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
 <20180704050822.GA23536@guoren>
 <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180704115817.ECgC4LSrkXbzVUH06ku9IdQEDRFkc_AZ50-XSFwfHgM@z>

On Wed, Jul 04, 2018 at 08:43:29AM +0200, Thomas Gleixner wrote:
> > Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
> > one file eg: irq-csky.c? 
> 
> Yes, but only if there is enough code to share without creating an ifdef
> mess. But that looks doable
Ok, I'll try.

 Guo Ren
