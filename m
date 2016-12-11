From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] sys_mmap64()
Date: Sun, 11 Dec 2016 22:56:03 +0800
Message-ID: <201612112204.WvCDlc6y%fengguang.wu@intel.com>
References: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31924 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbcLKO4P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Dec 2016 09:56:15 -0500
Content-Disposition: inline
In-Reply-To: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: kbuild-all@01.org, Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yury,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8 next-20161209]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/mm-move-argument-checkers-of-mmap_pgoff-to-separated-routine/20161211-211314
config: c6x-evmc6457_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

>> arch/c6x/kernel/built-in.o:(.fardata+0xb8c): undefined reference to `sys_mmap64'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k1lZvvs/B4yU6o8G--
