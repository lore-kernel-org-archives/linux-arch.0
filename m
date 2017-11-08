From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/31] Andes(nds32) Linux Kernel Port
Date: Wed, 8 Nov 2017 11:26:37 +0100
Message-ID: <CAK8P3a0tP4NrOzaHnndp2UO_a9swSrqscPM1h5N=Hit3pX_DxA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:
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

I looked at the entire patch series now and commented on anything I noticed
that could be improved, overall this looks very nice, great work!

Most of my comments are about tiny details that are easy to address.

I see two areas that need to be looked at carefully, and that may take a
few more rounds to get right:

- In the user space ABI, you have a couple of things that differ from the
  normal asm-generic definitions, i.e. s few syscall entry points and some
  types in asm/posix-types.h. I guess you did that to remain compatible
  with an older glibc port, but IMHO this compatibility should be broken
  in favor of having the standard ABI before the port gets merged.

- For the boot interface, you need to clearly define what can be expected
  and what cannot. This involves the presence of the l2cc, the physical
  memory address, the built-in dtb, and probably a few more things I
  missed. For long-term maintainability, you probably want to ensure that
  you can build a kernel that runs on as much diverse hardware as possible.

       Arnd
