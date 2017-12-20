Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44406 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbdLTJ6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Dec 2017 04:58:20 -0500
MIME-Version: 1.0
In-Reply-To: <201712201744.gsBDa4yK%fengguang.wu@intel.com>
References: <95be78502aa406f106ecbe87e751a45333883b1f.1513577007.git.green.hu@gmail.com>
 <201712201744.gsBDa4yK%fengguang.wu@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Dec 2017 10:58:19 +0100
Message-ID: <CAMuHMdXp5b-Y79kaKgmDRshnpN2=VEd-f3v-6QW+6mUqv6YW-A@mail.gmail.com>
Subject: Re: [PATCH v4 33/36] net: faraday add nds32 support.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Greentime Hu <green.hu@gmail.com>, kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, devicetree@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Philippe Ombredanne <pombredanne@nexb.com>
Message-ID: <20171220095819.FqqQ7NlcIP-cGGrc0hBTNgZ_iWxJbO4VNg-fPXuvqKE@z>

On Wed, Dec 20, 2017 at 10:54 AM, kbuild test robot <lkp@intel.com> wrote:
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/timers/core]
> [cannot apply to linus/master v4.15-rc4 next-20171220]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64
>
> All warnings (new ones prefixed by >>):
>
>    drivers/net/ethernet/faraday/ftmac100.c: In function 'ftmac100_rxdes_set_page':
>>> drivers/net/ethernet/faraday/ftmac100.c:288:18: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      rxdes->rxdes3 = (unsigned int)page;
>                      ^

The proper way to casts pointer to integers is to cast to "uintptr_t".

However, the address is stored in a 32-bit descriptor, which means it can
not work on 64-bit platforms.

Please make the driver depend on "!64BIT || BROKEN"

Cfr. commit 15bfe05c8d6386f1 ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC
broken on 64-bit")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
