From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Wed, 4 Jul 2018 19:58:17 +0800
Message-ID: <20180704115817.GA24372@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
 <20180704050822.GA23536@guoren>
 <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 04, 2018 at 08:43:29AM +0200, Thomas Gleixner wrote:
> > Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
> > one file eg: irq-csky.c? 
> 
> Yes, but only if there is enough code to share without creating an ifdef
> mess. But that looks doable
Ok, I'll try.

 Guo Ren
