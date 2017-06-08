From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 03/17] base: fix order of OF initialization
Date: Thu, 8 Jun 2017 10:05:08 +0100
Message-ID: <20170608090507.GA5765@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-4-palmer@dabbelt.com>
 <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
 <20170607093523.GB29370@leverpostej>
 <CAMgXwTiE48KLCJe6TD6VCd5rYASyw0L+pYh8yfvGjhohAfo2dg@mail.gmail.com>
 <5938C957.2030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdFHJF4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jun 2017 05:05:56 -0400
Content-Disposition: inline
In-Reply-To: <5938C957.2030005@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wesley Terpstra <wesley@sifive.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, Jun 07, 2017 at 08:49:43PM -0700, Frank Rowand wrote:
> On 06/07/17 11:39, Wesley Terpstra wrote:
> > It was a while ago that I debugged this. I already reported this bug
> > to Benjamin Herrenschmidt (now in CC), and I believe he has a patch of
> > his own to fix the same issue.
> > 
> > As I understand it, of_core_init sets up the OF entries in
> > /sys/firmware/devicetree. During platform bringup, when the system
> > describes the cpu + cache hierarchy, it also makes an of_node symlink
> > into that directory. However, if it doesn't exist yet, you get the
> > warning.
> > 
> > # ls -l /sys/devices/system/cpu/cpu3/of_node
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:00
> > /sys/devices/system/cpu/cpu3/of_node ->
> > ../../../../firmware/devicetree/base/cpus/cpu@3
> > 
> > On Wed, Jun 7, 2017 at 2:35 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Wed, Jun 07, 2017 at 09:07:20AM +0200, Geert Uytterhoeven wrote:
> >>> CC devicetree folks
> >>>
> >>> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>>> From: "Wesley W. Terpstra" <wesley@sifive.com>
> >>>>
> >>>> This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
> >>>> ... which you get for every CPU on all architectures with a OF cpu/ node.
> >>
> >> I take it this means a /cpus node? Or the /cpus/cpu@* nodes?
> >>
> >> I'm not seeing this on arm64 when booting v4.12-rc4 with DT, so clearly
> >> this doesn't affect all such architectures.
> >>
> >> What path are these errors happening in?
> 
> On the surface, the patch looks reasonable.  But it is not obvious to me why
> the error message is occurring.  I would like to understand the cause before
> saying the patch is good.
> 
> What kernel version is showing the error?  For a specific architecture
> (the patch lists 'riscv, nios, etc'), which config and device tree source?
> 
> And again, what is the calling path?

From having grepped around, I think this affects architectures which
select CONFIG_GENERIC_CPU_DEVICES, which includes nios2.

In that case, driver_init() calls cpu_dev_init() before calling
of_core_init(). Then we get the callchain:

   cpu_dev_init()
-> cpu_dev_register_generic()
-> register_cpu(cpu, i)
-> device_register(&cpu->dev)
-> device_add(dev)
-> device_add_class_symlinks(dev)

... in device_add_class_symlinks, we we dev->of_node, and call
sysfs_create_link(), which fails because we haven't called
of_core_init() to register the sysfs devicetree directory yet.

Given that, this patch makes sense to me.

FWIW, with the commit message updated to describe the particular
ordering problem:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
