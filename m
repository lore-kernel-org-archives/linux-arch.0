From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Date: Mon, 16 Apr 2012 09:21:58 +0200
Message-ID: <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: sparclinux-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux@lists.openrisc.net, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 15, 2012 at 11:52 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Rather than requiring architectures that use gpiolib but don't have a=
ny
> need to define anything custom to copy an asm/gpio.h provide a Kconfi=
g
> symbol which architectures must select in order to include gpio.h and
> for other architectures just provide the trivial implementation direc=
tly.
>
> This makes it much easier to do gpiolib updates and is also a step to=
wards
> making gpiolib APIs available on every architecture.
>
> For architectures with existing boilerplate code leave a stub header =
in
> place which warns on direct inclusion of asm/gpio.h and includes
> linux/gpio.h to catch code that's doing this. =A0Direct inclusion of
> asm/gpio.h has long been deprecated.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0arch/alpha/include/asm/gpio.h =A0 =A0 =A0| =A0 59 ++--------------=
--------------
> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/avr32/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/blackfin/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/ia64/include/asm/gpio.h =A0 =A0 =A0 | =A0 59 ++--------------=
--------------
> =A0arch/m68k/Kconfig.cpu =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/microblaze/include/asm/gpio.h | =A0 57 ++--------------------=
-------
> =A0arch/mips/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/openrisc/include/asm/gpio.h =A0 | =A0 69 ++------------------=
---------------
> =A0arch/powerpc/include/asm/gpio.h =A0 =A0| =A0 57 ++----------------=
-----------
> =A0arch/sh/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 =
+
> =A0arch/sparc/include/asm/gpio.h =A0 =A0 =A0| =A0 40 ++--------------=
-----
> =A0arch/unicore32/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/x86/include/asm/gpio.h =A0 =A0 =A0 =A0| =A0 57 ++------------=
---------------
> =A0arch/xtensa/include/asm/gpio.h =A0 =A0 | =A0 60 ++----------------=
-------------
> =A0drivers/gpio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++++
> =A0include/linux/gpio.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 34 ++++++++=
+++++++++
> =A017 files changed, 81 insertions(+), 426 deletions(-)

This looks good but I think we need to page the alpha, ia64, m68k, micr=
oblaze,
openrisc etc subarch maintainers on this patch so they have their say.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
