From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v4 33/36] net: faraday add nds32 support.
Date: Wed, 20 Dec 2017 18:34:29 +0800
Message-ID: <CAEbi=3erUo+QV75khdTHmUmZpkK7mHjFfF3A1_zaF9OmJkbCQQ@mail.gmail.com>
References: <95be78502aa406f106ecbe87e751a45333883b1f.1513577007.git.green.hu@gmail.com>
 <201712201744.gsBDa4yK%fengguang.wu@intel.com> <CAMuHMdXp5b-Y79kaKgmDRshnpN2=VEd-f3v-6QW+6mUqv6YW-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXp5b-Y79kaKgmDRshnpN2=VEd-f3v-6QW+6mUqv6YW-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.c>
List-Id: linux-arch.vger.kernel.org

2017-12-20 17:58 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Wed, Dec 20, 2017 at 10:54 AM, kbuild test robot <lkp@intel.com> wrote:
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on tip/timers/core]
>> [cannot apply to linus/master v4.15-rc4 next-20171220]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
>> config: sparc64-allyesconfig (attached as .config)
>> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=sparc64
>>
>> All warnings (new ones prefixed by >>):
>>
>>    drivers/net/ethernet/faraday/ftmac100.c: In function 'ftmac100_rxdes_set_page':
>>>> drivers/net/ethernet/faraday/ftmac100.c:288:18: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>      rxdes->rxdes3 = (unsigned int)page;
>>                      ^
>
> The proper way to casts pointer to integers is to cast to "uintptr_t".
>
> However, the address is stored in a 32-bit descriptor, which means it can
> not work on 64-bit platforms.
>
> Please make the driver depend on "!64BIT || BROKEN"
>
> Cfr. commit 15bfe05c8d6386f1 ("net: ethernet: xilinx: Mark XILINX_LL_TEMAC
> broken on 64-bit")
>
Thanks Geert.

I will apply it like this.

+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_FARADAY
        bool "Faraday devices"
        default y
-       depends on ARM
+       depends on ARM || NDS32 || COMPILE_TEST
        ---help---
          If you have a network (Ethernet) card belonging to this class, say Y.

@@ -18,7 +18,8 @@ if NET_VENDOR_FARADAY

 config FTMAC100
        tristate "Faraday FTMAC100 10/100 Ethernet support"
-       depends on ARM
+       depends on ARM || NDS32 || COMPILE_TEST
+       depends on !64BIT || BROKEN
        select MII
        ---help---
          This driver supports the FTMAC100 10/100 Ethernet controller
@@ -27,7 +28,8 @@ config FTMAC100

 config FTGMAC100
        tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-       depends on ARM
+       depends on ARM || NDS32 || COMPILE_TEST
+       depends on !64BIT || BROKEN
        select PHYLIB
        ---help---
          This driver supports the FTGMAC100 Gigabit Ethernet controller
