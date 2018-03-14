Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40279 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeCNSnM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:43:12 -0400
Date: Thu, 15 Mar 2018 02:42:39 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asm-generic:master 3/63] Makefile:505: arch/frv/Makefile: No such
 file or directory
Message-ID: <201803150227.8awZdRDG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   6f0b419290171f99f5d4d52d47920d24010b7744
commit: fd8773f9f544955f6f47dc2ac3ab85ad64376b7f [3/63] arch: remove frv port
config: frv-defconfig
compiler: frv-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fd8773f9f544955f6f47dc2ac3ab85ad64376b7f
        make.cross ARCH=frv  defconfig
        make.cross ARCH=frv 

All errors (new ones prefixed by >>):

>> Makefile:505: arch/frv/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/frv/Makefile'.
   make[1]: Failed to remake makefile 'arch/frv/Makefile'.
>> Kconfig:12: can't open file "arch/frv/Kconfig"
   make[2]: *** [defconfig] Error 1
   make[1]: *** [defconfig] Error 2
   make: *** [sub-make] Error 2
--
   Makefile:636: arch/frv/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/frv/Makefile'.
   make[1]: Failed to remake makefile 'arch/frv/Makefile'.
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/frv/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/frv/Makefile'.
   make[1]: Failed to remake makefile 'arch/frv/Makefile'.
>> Kconfig:12: can't open file "arch/frv/Kconfig"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> Makefile:505: arch/frv/Makefile: No such file or directory
>> make[1]: *** No rule to make target 'arch/frv/Makefile'.
   make[1]: Failed to remake makefile 'arch/frv/Makefile'.
>> Kconfig:12: can't open file "arch/frv/Kconfig"
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
