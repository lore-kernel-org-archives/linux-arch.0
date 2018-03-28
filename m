From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Wed, 28 Mar 2018 09:40:49 +0200
Message-ID: <CAK8P3a3NRtqGVrSiUwD0kUL7kC0=P1uTakcbaGtWRSssXs7L8w@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren> <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
 <20180321124137.GA21320@guoren> <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
 <20180327023927.GA11454@guoren> <CAK8P3a3A+BEmBnGCSiRdoaiqSJjhC5zaZebcq2GPVaLJatBk8Q@mail.gmail.com>
 <20180328034957.GA4482@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328034957.GA4482@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 28, 2018 at 5:49 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> Hi Arnd,
>
> On Tue, Mar 27, 2018 at 09:38:56AM +0200, Arnd Bergmann wrote:
>> Usually the way gcc handles this, either each CPU is a strict superset
>> of another
>> one, so you just need to specify the one with the smallest instruction set,
>> or you have an option like -mcpu=generic that produces the common subset.
>>
> ck807 ck810 ck860 are diffrent architecture, so they can not be strict
> superset and there is no option like '-mcpu=generic' in our gcc and
> binutils.
>
> I know you want one vmlinux which could run on all ck807 ck810 ck860 with
> different dts-setting. But now, may I keep current design for abiv1&abiv2?
>
> In abiv3, we will take your advice seriously.

Ok, thanks for the clarification. Obviously if they are mutually incompatible,
there is no point in using a common kernel, so your current version is
absolutely fine, and this is similar to how we cannot have a common kernel
between ARMv5, ARMv7-A and ARMv7-M, which are all incompatible
at the kernel level.

One more question for my understanding: Are the three types of ck8xx
CPUs mutually incompatible in user space as well, or are the differences
only for the kernel? For the ARM example, ARMv5 and ARMv7
fundamentally require separate kernels, but both can run user space
programs built for ARMv5.

      Arnd
