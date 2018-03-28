From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Wed, 28 Mar 2018 16:04:53 +0800
Message-ID: <20180328080452.GA12230@guoren>
References: <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren>
 <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
 <20180321124137.GA21320@guoren>
 <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
 <20180327023927.GA11454@guoren>
 <CAK8P3a3A+BEmBnGCSiRdoaiqSJjhC5zaZebcq2GPVaLJatBk8Q@mail.gmail.com>
 <20180328034957.GA4482@guoren>
 <CAK8P3a3NRtqGVrSiUwD0kUL7kC0=P1uTakcbaGtWRSssXs7L8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3NRtqGVrSiUwD0kUL7kC0=P1uTakcbaGtWRSssXs7L8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Wed, Mar 28, 2018 at 09:40:49AM +0200, Arnd Bergmann wrote:
> Ok, thanks for the clarification. Obviously if they are mutually incompatible,
> there is no point in using a common kernel, so your current version is
> absolutely fine, and this is similar to how we cannot have a common kernel
> between ARMv5, ARMv7-A and ARMv7-M, which are all incompatible
> at the kernel level.
Yes.

> One more question for my understanding: Are the three types of ck8xx
> CPUs mutually incompatible in user space as well, or are the differences
> only for the kernel? For the ARM example, ARMv5 and ARMv7
> fundamentally require separate kernels, but both can run user space
> programs built for ARMv5.

 -mcpu=ck807 app could run on ck807, ck810, ck860.
 -mcpu=ck810 app could run on ck807, ck810, ck860.
 -mcpu=ck860 app only  run on ck860.

They are all incompatible at the kernel level.

Best Regards
 Guo Ren
