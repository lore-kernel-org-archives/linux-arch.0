From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Date: Wed, 4 Jul 2018 19:40:45 +0800
Message-ID: <20180704114045.GA22857@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
 <CAK8P3a0v2Dq7-FhSmo5sKrU6JZ2kyqX2zveL-CN3PqVSQRmckg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0v2Dq7-FhSmo5sKrU6JZ2kyqX2zveL-CN3PqVSQRmckg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 03, 2018 at 06:03:04PM +0200, Arnd Bergmann wrote:
> It looks like the CK8xx CPUs are basically compatible, so it would
> be nice to have a way to configure a kernel that can run on all
> of them, picking a safe default for options that depend on a
> particular CPU. E.g. when only CK860 supports SMP, you might
> start out by making SMP "depend on !(CPU_CK807 || CPU_CK810)",
> as an alternative to implementing a way for an SMP-enabled kernel
> to run on non-SMP CPUs (arm has that, but it's probably too complex
> for your needs).
> 
> Similarly, you can set L1_CACHE_BYTES to the largest possible
> size, and make things like CPU_TLB_SIZE dynamically detected.
We talked about this topic in the last patchsets. Ck807/810/860 are mutually
incompatible in kernel level but both can run user space programs in
ck807/810.

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

 
> > +menu "C-SKY Debug Options"
> > +config CSKY_DEBUG_INFO
> > +       bool "Compile the kernel with debug info, just add -g"
> > +       depends on !DEBUG_INFO
> > +       help
> > +         DEBUG_INFO and COMPILE_TEST is conflict, so we provide
> > +         another way to support -g.
> > +         Some drivers eg: DW_MMC need COMPILE_TEST for new cpu
> > +         arch :(
> 
> Just send a patch to change those dependencies, there is no reason
> not to apply those. Generally speaking, the kernel should not contain
> workarounds for particular (mis-)features of the kernel, when you can
> just change those.
Ok.

> > +generic-y += atomic.h
> 
> The asm-generic version of atomic.h is a bit inefficient,
> you might want to provide an optimized version for your
> architecture.
Ok.

> > +generic-y += auxvec.h
> 
> You should not need asm/auxvec.h or uapi/asm/auxvec.h
Ok.

> > +generic-y += bug.h
> 
> providing your own bug.h might be helpful too.
> Have a look
Ok.

> > +generic-y += cputime.h
> 
> asm-generic/cputime.h no loinger exists
Ok, remove it.

> > +generic-y += kvm_para.h
> 
> Do you support KVM?
No, remove it, thx.
 
> > +generic-y += sizes.h
> 
> Deprecated and should not be needed
Ok, remove it.

 Guo Ren
