From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 00/26] C-SKY(csky) Linux Kernel Port
Date: Thu, 6 Sep 2018 16:35:17 +0200
Message-ID: <CAK8P3a3rACZHeSUm5Tct2PxfY4_GfkFEjb2hCwLWSpvNc2qDtg@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> Thanks to everyone who provided feedback on the previous version.
>
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.18.4

I looked at all patches again, overall this seems well done, thanks
for addressing
all the prior feedback.

Most of my comments are are for fairly unimportant issues, the one thing
I found that needs to be properly addressed is the asm/io.h header, which
should implement the I/O accessors as your hardware requires them.

       Arnd
