From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 20/20] module.h: remove extable.h include now users have
 migrated
Date: Mon, 23 Jan 2017 06:52:51 +0800
Message-ID: <201701230645.PYFdx082%fengguang.wu@intel.com>
References: <20170122163244.11740-21-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57263 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbdAVWxF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 22 Jan 2017 17:53:05 -0500
Content-Disposition: inline
In-Reply-To: <20170122163244.11740-21-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc5 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Gortmaker/ia64-move-ia64_done_with_exception-out-of-asm-uaccess-h/20170123-004155
config: cris-etraxfs_defconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All error/warnings (new ones prefixed by >>):

   arch/cris/arch-v32/kernel/traps.c: In function 'fixup_BUG':
>> arch/cris/arch-v32/kernel/traps.c:159:11: error: implicit declaration of function 'search_exception_tables' [-Werror=implicit-function-declaration]
      fixup = search_exception_tables(instruction_pointer(regs) - 2);
              ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/cris/arch-v32/kernel/traps.c:159:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      fixup = search_exception_tables(instruction_pointer(regs) - 2);
            ^
   cc1: some warnings being treated as errors

vim +/search_exception_tables +159 arch/cris/arch-v32/kernel/traps.c

51533b61 Mikael Starvik 2005-07-27  143  
9ce1ea75 Jesper Nilsson 2007-12-03  144  void fixup_BUG(struct pt_regs *regs)
51533b61 Mikael Starvik 2005-07-27  145  {
9ce1ea75 Jesper Nilsson 2007-12-03  146  	BUG_regs = *regs;
9ce1ea75 Jesper Nilsson 2007-12-03  147  
9ce1ea75 Jesper Nilsson 2007-12-03  148  #ifdef CONFIG_DEBUG_BUGVERBOSE
9ce1ea75 Jesper Nilsson 2007-12-03  149  	/*
9ce1ea75 Jesper Nilsson 2007-12-03  150  	 * Fixup the BUG arguments through exception handlers.
9ce1ea75 Jesper Nilsson 2007-12-03  151  	 */
9ce1ea75 Jesper Nilsson 2007-12-03  152  	{
9ce1ea75 Jesper Nilsson 2007-12-03  153  		const struct exception_table_entry *fixup;
9ce1ea75 Jesper Nilsson 2007-12-03  154  
9ce1ea75 Jesper Nilsson 2007-12-03  155  		/*
9ce1ea75 Jesper Nilsson 2007-12-03  156  		 * ERP points at the "break 14" + 2, compensate for the 2
9ce1ea75 Jesper Nilsson 2007-12-03  157  		 * bytes.
9ce1ea75 Jesper Nilsson 2007-12-03  158  		 */
9ce1ea75 Jesper Nilsson 2007-12-03 @159  		fixup = search_exception_tables(instruction_pointer(regs) - 2);
9ce1ea75 Jesper Nilsson 2007-12-03  160  		if (fixup) {
9ce1ea75 Jesper Nilsson 2007-12-03  161  			/* Adjust the instruction pointer in the stackframe. */
9ce1ea75 Jesper Nilsson 2007-12-03  162  			instruction_pointer(regs) = fixup->fixup;
9ce1ea75 Jesper Nilsson 2007-12-03  163  			arch_fixup(regs);
51533b61 Mikael Starvik 2005-07-27  164  		}
9ce1ea75 Jesper Nilsson 2007-12-03  165  	}
9ce1ea75 Jesper Nilsson 2007-12-03  166  #else
9ce1ea75 Jesper Nilsson 2007-12-03  167  	/* Dont try to lookup the filename + line, just dump regs.  */

:::::: The code at line 159 was first introduced by commit
:::::: 9ce1ea751f7256b2248321c2427612a295f15137 CRIS v32: Update and improve kernel/traps.c

:::::: TO: Jesper Nilsson <jesper.nilsson@axis.com>
:::::: CC: Jesper Nilsson <jesper.nilsson@axis.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7JfCtLOvnd9MIVvH--
