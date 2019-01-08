Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:63041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfAHEP4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jan 2019 23:15:56 -0500
Date: Tue, 8 Jan 2019 12:15:42 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] c6x: generate uapi and kapi headers
Message-ID: <201901081216.dL5x4R5h%fengguang.wu@intel.com>
References: <1546872766-3354-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1546872766-3354-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: kbuild-all@01.org, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-c6x-dev@linux-c6x.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20190108041542.Z4sx_UP6EWtAsKA9E88DPlmEF6-zEJfJY0pDMiUwOwE@z>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Firoz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.0-rc1]
[cannot apply to next-20190107]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Firoz-Khan/c6x-system-call-table-generation-for-asm-generic/20190108-100353
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'scripts/syscalls/syscall.tbl', needed by 'arch/c6x/include/generated/asm/syscall_table.h'.
>> make[2]: *** No rule to make target 'scripts/syscalltbl.sh', needed by 'arch/c6x/include/generated/asm/syscall_table.h'.
>> make[2]: *** No rule to make target 'scripts/syscallhdr.sh', needed by 'arch/c6x/include/generated/uapi/asm/unistd_32.h'.
   make[2]: Target 'all' not remade because of errors.
   make[1]: *** [archheaders] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
88m9E5ElHpdZhMr5ttVeqR/x+v8D0lqhQYpGAAA=

--VbJkn9YxBvnuCH5J--
