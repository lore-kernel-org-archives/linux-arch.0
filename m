Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:13806 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCNSsL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:48:11 -0400
Date: Thu, 15 Mar 2018 02:47:50 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asm-generic:master 7/63] Makefile:628: arch/tile/Makefile: No such
 file or directory
Message-ID: <201803150236.QcfcVsA1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   6f0b419290171f99f5d4d52d47920d24010b7744
commit: 0373506fe580da081c4f1f8ea8d0bdb5a48c1296 [7/63] arch: remove tile port
config: tile-tilegx_defconfig
compiler: tilegx-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0373506fe580da081c4f1f8ea8d0bdb5a48c1296
        make.cross ARCH=tile  tilegx_defconfig
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

>> Makefile:628: arch/tile/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/tile/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
   Kconfig:12: can't open file "arch/tile/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/tile/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
   Kconfig:12: can't open file "arch/tile/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/tile/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/tile/Makefile'.
   make[1]: Failed to remake makefile 'arch/tile/Makefile'.
   Kconfig:12: can't open file "arch/tile/Kconfig"
   make[2]: *** [tilegx_defconfig] Error 1
   make[1]: *** [tilegx_defconfig] Error 2
   make: *** [sub-make] Error 2

vim +628 Makefile

433dc2eb Masahiro Yamada    2017-10-12  622  
6dd3f13e Michal Marek       2015-07-16  623  # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
6dd3f13e Michal Marek       2015-07-16  624  # values of the respective KBUILD_* variables
6dd3f13e Michal Marek       2015-07-16  625  ARCH_CPPFLAGS :=
6dd3f13e Michal Marek       2015-07-16  626  ARCH_AFLAGS :=
6dd3f13e Michal Marek       2015-07-16  627  ARCH_CFLAGS :=
a436bb7b Masahiro Yamada    2015-03-27 @628  include arch/$(SRCARCH)/Makefile
a1c48bb1 Geert Uytterhoeven 2014-05-27  629  

:::::: The code at line 628 was first introduced by commit
:::::: a436bb7b806383ae0593cab53d17fc9676270cd3 kbuild: use relative path more to include Makefile

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
