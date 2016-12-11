From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] sys_mmap64()
Date: Sun, 11 Dec 2016 22:48:13 +0800
Message-ID: <201612112221.s0YOV80d%fengguang.wu@intel.com>
References: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35073 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753179AbcLKOtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Dec 2016 09:49:14 -0500
Content-Disposition: inline
In-Reply-To: <1481461003-14361-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: kbuild-all@01.org, Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yury,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8 next-20161209]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/mm-move-argument-checkers-of-mmap_pgoff-to-separated-routine/20161211-211314
config: h8300-h8300h-sim_defconfig (attached as .config)
compiler: h8300-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=h8300 

All errors (new ones prefixed by >>):

>> arch/h8300/kernel/built-in.o:(.data+0x48c): undefined reference to `sys_mmap64'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--C7zPtVaVf+AK4Oqc--
