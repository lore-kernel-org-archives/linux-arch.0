Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39983 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeCNSiL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:38:11 -0400
Date: Thu, 15 Mar 2018 02:37:08 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asm-generic:master 8/63] Kconfig:12: can't open file
 "arch/cris/Kconfig"
Message-ID: <201803150204.JELU97YN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesper Nilsson <jesper@jni.nu>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   6f0b419290171f99f5d4d52d47920d24010b7744
commit: 77b0b77f781222c0a804682cb4d6699d8f42f5d6 [8/63] CRIS: Drop support for the CRIS port
config: cris-allmodconfig
compiler: cris-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 77b0b77f781222c0a804682cb4d6699d8f42f5d6
        make.cross ARCH=cris  allmodconfig
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [allmodconfig] Error 1
   make[1]: *** [allmodconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:497: arch/cris/Makefile: No such file or directory
   make[1]: *** No rule to make target 'arch/cris/Makefile'.
   make[1]: Failed to remake makefile 'arch/cris/Makefile'.
>> Kconfig:12: can't open file "arch/cris/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +12 Kconfig

838a2e55 Arnaud Lacombe 2010-09-04   7  
838a2e55 Arnaud Lacombe 2010-09-04   8  config SRCARCH
838a2e55 Arnaud Lacombe 2010-09-04   9  	string
838a2e55 Arnaud Lacombe 2010-09-04  10  	option env="SRCARCH"
838a2e55 Arnaud Lacombe 2010-09-04  11  
838a2e55 Arnaud Lacombe 2010-09-04 @12  source "arch/$SRCARCH/Kconfig"

:::::: The code at line 12 was first introduced by commit
:::::: 838a2e55e6a4e9e8a10451ed2ef0f7a08dabdb04 kbuild: migrate all arch to the kconfig mainmenu upgrade

:::::: TO: Arnaud Lacombe <lacombar@gmail.com>
:::::: CC: Arnaud Lacombe <lacombar@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
