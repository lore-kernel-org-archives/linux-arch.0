From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Date: Fri, 7 Sep 2018 14:07:30 +0800
Message-ID: <20180907060730.GB16834@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
 <20180906022322.GA30251@guoren-Inspiron-7460>
 <CAK8P3a0qRKEfdyQ5V0JcukTG+e0vSLycoBkC4YxRM_os9_jUcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qRKEfdyQ5V0JcukTG+e0vSLycoBkC4YxRM_os9_jUcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 03:03:16PM +0200, Arnd Bergmann wrote:
> >         INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);
> 
> It that reliable? I remember a similar situation with some registers on ARM
> that are usually identified through a special CPU register, but in some
> cases the SoC integrator put the wrong address in there, so we need to
> look up the address in DT anyway.
Yes, it's reliable. This interrupt is combined with CPU and not on AXI
or APB. Soc just give a hole in the address space and tell the CPU where
the address is with 20 wire-signals.

 Guo Ren
