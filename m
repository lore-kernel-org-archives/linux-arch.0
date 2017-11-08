From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
Date: Wed, 8 Nov 2017 10:46:10 -0600
Message-ID: <CAL_JsqKLbDWcwcgotnQAO2FeFp55SZRd0z9r2Dr0ZsK0LKZMLw@mail.gmail.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbdKHQqd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Nov 2017 11:46:33 -0500
In-Reply-To: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Nov 1, 2017 at 9:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> We need to add "clean-files" in Makfiles to clean up DT blobs, but we
> often miss to do so.
>
> Since there are no source files that end with .dtb or .dtb.S, so we
> can clean-up those files from the top-level Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Remove clean-files

Applied this and the 2 prerequisite patches.

>
>  Documentation/kbuild/makefiles.txt               | 1 -
>  Makefile                                         | 2 +-
>  arch/arc/boot/dts/Makefile                       | 1 -
>  arch/arm/boot/dts/Makefile                       | 1 -
>  arch/arm64/boot/dts/actions/Makefile             | 1 -
>  arch/arm64/boot/dts/al/Makefile                  | 1 -
>  arch/arm64/boot/dts/allwinner/Makefile           | 1 -
>  arch/arm64/boot/dts/altera/Makefile              | 1 -
>  arch/arm64/boot/dts/amd/Makefile                 | 1 -
>  arch/arm64/boot/dts/amlogic/Makefile             | 1 -
>  arch/arm64/boot/dts/apm/Makefile                 | 1 -
>  arch/arm64/boot/dts/arm/Makefile                 | 1 -
>  arch/arm64/boot/dts/broadcom/Makefile            | 1 -
>  arch/arm64/boot/dts/broadcom/northstar2/Makefile | 1 -
>  arch/arm64/boot/dts/broadcom/stingray/Makefile   | 1 -
>  arch/arm64/boot/dts/cavium/Makefile              | 1 -
>  arch/arm64/boot/dts/exynos/Makefile              | 1 -
>  arch/arm64/boot/dts/freescale/Makefile           | 1 -
>  arch/arm64/boot/dts/hisilicon/Makefile           | 1 -
>  arch/arm64/boot/dts/lg/Makefile                  | 1 -
>  arch/arm64/boot/dts/marvell/Makefile             | 1 -
>  arch/arm64/boot/dts/mediatek/Makefile            | 1 -
>  arch/arm64/boot/dts/nvidia/Makefile              | 1 -
>  arch/arm64/boot/dts/qcom/Makefile                | 1 -
>  arch/arm64/boot/dts/realtek/Makefile             | 1 -
>  arch/arm64/boot/dts/renesas/Makefile             | 1 -
>  arch/arm64/boot/dts/rockchip/Makefile            | 1 -
>  arch/arm64/boot/dts/socionext/Makefile           | 1 -
>  arch/arm64/boot/dts/sprd/Makefile                | 1 -
>  arch/arm64/boot/dts/xilinx/Makefile              | 1 -
>  arch/arm64/boot/dts/zte/Makefile                 | 1 -
>  arch/c6x/boot/dts/Makefile                       | 2 --
>  arch/cris/boot/dts/Makefile                      | 2 --
>  arch/h8300/boot/dts/Makefile                     | 1 -
>  arch/metag/boot/dts/Makefile                     | 1 -
>  arch/microblaze/boot/Makefile                    | 2 +-
>  arch/mips/boot/dts/Makefile                      | 1 -
>  arch/mips/boot/dts/brcm/Makefile                 | 1 -
>  arch/mips/boot/dts/cavium-octeon/Makefile        | 1 -
>  arch/mips/boot/dts/img/Makefile                  | 1 -
>  arch/mips/boot/dts/ingenic/Makefile              | 1 -
>  arch/mips/boot/dts/lantiq/Makefile               | 1 -
>  arch/mips/boot/dts/mti/Makefile                  | 1 -
>  arch/mips/boot/dts/netlogic/Makefile             | 1 -
>  arch/mips/boot/dts/ni/Makefile                   | 1 -
>  arch/mips/boot/dts/pic32/Makefile                | 1 -
>  arch/mips/boot/dts/qca/Makefile                  | 1 -
>  arch/mips/boot/dts/ralink/Makefile               | 1 -
>  arch/mips/boot/dts/xilfpga/Makefile              | 1 -
>  arch/nios2/boot/Makefile                         | 2 --
>  arch/openrisc/boot/dts/Makefile                  | 2 --
>  arch/powerpc/boot/Makefile                       | 2 +-
>  arch/sh/boot/dts/Makefile                        | 2 --
>  arch/xtensa/boot/dts/Makefile                    | 2 --
>  54 files changed, 3 insertions(+), 60 deletions(-)
