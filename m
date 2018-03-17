From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] earlycon: Fix __earlycon_table stride... again
Date: Sat, 17 Mar 2018 19:31:29 +0800
Message-ID: <201803171959.hpjvOMQR%fengguang.wu@intel.com>
References: <20180315014817.142930-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180315014817.142930-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, adurbin@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Kurtz/earlycon-Fix-__earlycon_table-stride-again/20180317-180525
config: h8300-h8300h-sim_defconfig (attached as .config)
compiler: h8300-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=h8300 

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bitops/le.h:6:0,
                    from arch/h8300/include/asm/bitops.h:177,
                    from include/linux/bitops.h:38,
                    from include/linux/kernel.h:11,
                    from include/linux/clk.h:16,
                    from drivers/tty/serial/sh-sci.c:24:
   arch/h8300/include/asm/byteorder.h:5:0: warning: "__BIG_ENDIAN" redefined
    #define __BIG_ENDIAN __ORDER_BIG_ENDIAN__
    
   In file included from <command-line>:0:0:
   include/linux/kconfig.h:8:0: note: this is the location of the previous definition
    #define __BIG_ENDIAN 4321
    
>> drivers/tty/serial/sh-sci.c:3278:29: error: port_cfg causes a section type conflict with __UNIQUE_ID___earlycon_hscif28
    static struct plat_sci_port port_cfg __initdata;
                                ^~~~~~~~
   In file included from include/linux/serial_sci.h:6:0,
                    from drivers/tty/serial/sh-sci.c:45:
   include/linux/compiler-gcc.h:193:45: note: '__UNIQUE_ID___earlycon_hscif28' was declared here
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/serial_core.h:366:34: note: in definition of macro '_OF_EARLYCON_DECLARE'
     static const struct earlycon_id unique_id   \
                                     ^~~~~~~~~
   include/linux/compiler_types.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:193:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^~~~~~~
   include/linux/compiler_types.h:53:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^~~~~~~~
   include/linux/compiler-gcc.h:193:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^~~~~~~
   include/linux/serial_core.h:377:9: note: in expansion of macro '__UNIQUE_ID'
            __UNIQUE_ID(__earlycon_##_name))
            ^~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:3330:1: note: in expansion of macro 'OF_EARLYCON_DECLARE'
    OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
    ^~~~~~~~~~~~~~~~~~~

vim +3278 drivers/tty/serial/sh-sci.c

^1da177e drivers/serial/sh-sci.c     Linus Torvalds    2005-04-16  3272  
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3273  #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3274  early_platform_init_buffer("earlyprintk", &sci_driver,
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3275  			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3276  #endif
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato    2015-12-24  3277  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
dd076cff drivers/tty/serial/sh-sci.c Matthias Kaehlcke 2017-10-09 @3278  static struct plat_sci_port port_cfg __initdata;
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato    2015-12-24  3279  

:::::: The code at line 3278 was first introduced by commit
:::::: dd076cffb8cd675a8973fc9b6cea0c04be6f0111 serial: sh-sci: Fix init data attribute for struct 'port_cfg'

:::::: TO: Matthias Kaehlcke <mka@chromium.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AxOdgar+5gMm94gtAzbYez3qxv4feXmURHdAAAA=

--M9NhX3UHpAaciwkO--
