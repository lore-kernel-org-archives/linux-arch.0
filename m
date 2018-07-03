From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 02/19] csky: defconfig
Date: Tue, 3 Jul 2018 16:31:59 +0800
Message-ID: <20180703083157.GA29472@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
 <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 02, 2018 at 09:16:27PM -0600, Rob Herring wrote:
> 
> Are these configs mutually exclusive? We try to have one kernel build
> serve many platforms. So you'd probably want to divide things between
> the 2 ABIs.
Yes, they are mutually exclusive, and may I prepare defconfigs like
these:
 abiv1_defconfig
 abiv2_defconfig (ck807 ck810 ck860 are also mutually exclusive in
 -mcpu=ck807/ck810/ck860, you need "make menuconfig" to select correct CPU,
 so they couldn't be determined from DT. just like ARMv5, ARMv7-A and 
 ARMv7-M)

> It looks like you still have lots of options enabled that I wouldn't
> expect you to need. Start with something more minimal for what you
> need to boot and support upstream.
Ok, I'll clean them up in next version patch.
 
> For a full config, you can use allmodconfig at least to build test.
Thx for the tip.

Guo Ren
