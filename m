From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [renesas:topic/rcar-gen3-z-clk-v3 2/6] rcar-gen3-cpg.c:undefined
 reference to `__ffsdi2'
Date: Mon, 9 Oct 2017 10:26:55 +0200
Message-ID: <CAMuHMdX7C-_ueTY5=3_zcfYF9JNOfVeXq-wV6_Xjv5EBh=oj1Q@mail.gmail.com>
References: <201710060047.JNfwlYZq%fengguang.wu@intel.com> <CAMuHMdUrXQO0q1=O2ica6-OmSTWqjkCNxZtTW3eqGVzfVG9F1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUrXQO0q1=O2ica6-OmSTWqjkCNxZtTW3eqGVzfVG9F1Q@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Takeshi Kihara <takeshi.kihara.df@renesas.com>, "kbuild-all@01.org" <kbuild-all@01.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Linux-Arch <linux-arch@vger.kernel.org>, Jakub Kicinski <jakub.kicinski@netronome.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 9, 2017 at 10:02 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Oct 5, 2017 at 6:52 PM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-z-clk-v3
>> head:   4b41ea6e92cdc7fce15ba99b02c40938a134cff7
>> commit: fda8dbe29dd1f04b61c443147a106962cf5d3f14 [2/6] clk: renesas: rcar-gen3: Add Z2 clock divider support
>> config: i386-allmodconfig (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         git checkout fda8dbe29dd1f04b61c443147a106962cf5d3f14
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/clk/renesas/rcar-gen3-cpg.o: In function `cpg_z_clk_set_rate':
>>>> rcar-gen3-cpg.c:(.text+0x289): undefined reference to `__ffsdi2'
>
> This is caused by the use of __builtin_ffsll() in <linux/bitfield.h>.
> On several architectures, gcc generates a call to __ffsdi2().
> This is the case on (non-exhaustive list):
>     alpha
>     arm32
>     avr32
>     bfin
>     cris
>     frv
>     h8300
>     ia32
>     m32r
>     m68k
>     microblaze
>     mn10300
>     mips32
>     mips64
>     openrisc
>     parisc
>     powerpc32
>     s390x
>     sh4
>     sparc32
>     sparc64
>     unicore
>     xtensa
>
> The following are OK:
>     amd64
>     arm64
>     ia64
>     powerpc64
>     tilegx (but tile is the only one exporting the symbol to modules?)

(now I had my morning coffee)

Ah, <linux/bitfield.h> could just use __ffs64() + 1 instead.
Will send a patch...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
