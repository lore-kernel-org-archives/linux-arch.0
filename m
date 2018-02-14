From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 00/36] Andes(nds32) Linux Kernel
Date: Wed, 14 Feb 2018 15:56:56 +0100
Message-ID: <CAK8P3a29LyG9erZ0L4vF-JNxirCyhrYb98ujDaV-P3R_r-B5Cg@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This is the 4th version patchset to add the Linux kernel port for Andes(nds32)
> processors. Almost all of the feedbacks from v3 patchseries has been addressed.
> Thanks to everyone who provided feedback on the previous version.
>
>
> This patchset adds core architecture support to Linux for Andestech's
> N13, N15, D15, N10, D10 processor cores.
>
> Based on the 16/32-bit AndeStar RISC-like architecture, we designed the
> configurable AndesCore series of embedded processor families. AndesCores
> range from highly performance-efficient small-footprint cores for
> microcontrollers and deeply-embedded applications to 1GHz+ cores running
> Linux, covering general-purpose N-series cores for a wide range of computing
> need, DSP-capable D-series cores for digital signal control,
> instruction-extensible E-series cores for application-specific acceleration,
> and secure S-series cores for best protection of the most valuable.
>
> The patches are based on v4.14-rc8, and can also be found in the
> following git tree:
>   https://github.com/andestech/linux.git nds32-4.14-rc8-v4
>
> The build script and toolchain repositories are able to be found here:
>   https://github.com/andestech/build_script.git
>
> Freely available instruction set and architecture overview documents can
> be found on the following page:
>   http://www.andestech.com/product.php?cls=9
>
>
> Vincent Ren-Wei Chen and I will maintain this port. Thanks to everyone who
> helped us and contributed to it. :) Any feedback is welcome.

Aside from the missing Ack on the sparc patch, everything looks good to
get merged from my side this time.

I would suggest as next steps:

- ask Daniel to include the clocksource driver patches in his tree
- Provide a git tree with all the patches you plan to send for inclusion,
  based on v4.16-rc1.
- Add any further changes on top of that branch, without rebasing
  any further.
- give Stephen the git URL for inclusion in linux-next

      Arnd
