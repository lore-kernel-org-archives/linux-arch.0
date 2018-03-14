Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:20925 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeCNSlM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:41:12 -0400
Date: Thu, 15 Mar 2018 02:40:57 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asm-generic:master 2/63] Makefile:505: arch/mn10300/Makefile: No
 such file or directory
Message-ID: <201803150252.4af3iy14%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   6f0b419290171f99f5d4d52d47920d24010b7744
commit: 739d875dd6982618020d30f58f8acf10f6076e6d [2/63] mn10300: Remove the architecture
config: mn10300-asb2364_defconfig
compiler: am33_2.0-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 739d875dd6982618020d30f58f8acf10f6076e6d
        make.cross ARCH=mn10300  asb2364_defconfig
        make.cross ARCH=mn10300 

All errors (new ones prefixed by >>):

>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [asb2364_defconfig] Error 1
   make[1]: *** [asb2364_defconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:636: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/mn10300/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/mn10300/Makefile'.
   make[1]: Failed to remake makefile 'arch/mn10300/Makefile'.
>> Kconfig:12: can't open file "arch/mn10300/Kconfig"
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +505 Makefile

^1da177e Linus Torvalds  2005-04-16  501  
^1da177e Linus Torvalds  2005-04-16  502  # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
^1da177e Linus Torvalds  2005-04-16  503  # KBUILD_DEFCONFIG may point out an alternative default configuration
^1da177e Linus Torvalds  2005-04-16  504  # used for 'make defconfig'
a436bb7b Masahiro Yamada 2015-03-27 @505  include arch/$(SRCARCH)/Makefile
61bee204 Al Viro         2008-08-25  506  export KBUILD_DEFCONFIG KBUILD_KCONFIG
^1da177e Linus Torvalds  2005-04-16  507  

:::::: The code at line 505 was first introduced by commit
:::::: a436bb7b806383ae0593cab53d17fc9676270cd3 kbuild: use relative path more to include Makefile

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
