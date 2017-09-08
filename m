From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary include of
 linux/vmalloc.h
Date: Fri, 8 Sep 2017 10:22:29 +0200
Message-ID: <20170908082228.GD5028@distanz.ch>
References: <20170905112727.13668-1-tklauser@distanz.ch>
 <201709080336.iO3VHdeU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:58098 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754657AbdIHIWc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Sep 2017 04:22:32 -0400
Content-Disposition: inline
In-Reply-To: <201709080336.iO3VHdeU%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017-09-07 at 21:36:45 +0200, kbuild test robot <lkp@intel.com> wrote:
> Hi Tobias,
> 
> [auto build test ERROR on v4.13]
> [also build test ERROR on next-20170907]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tobias-Klauser/asm-generic-io-h-remove-unnecessary-include-of-linux-vmalloc-h/20170908-012111
> config: arm-shmobile_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm/mach-shmobile/pm-r8a7779.c:24:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'r8a7779_sysc_init'
>     static void __init r8a7779_sysc_init(void)
>                        ^~~~~~~~~~~~~~~~~
> >> arch/arm/mach-shmobile/pm-r8a7779.c:35:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'r8a7779_pm_init'
>     void __init r8a7779_pm_init(void)
>                 ^~~~~~~~~~~~~~~

This warning/error is fixed by Arnd's patch posted in
https://marc.info/?l=linux-kernel&m=150464459009788&w=2
