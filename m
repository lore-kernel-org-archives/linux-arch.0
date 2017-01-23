From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 20/20] module.h: remove extable.h include now users have
 migrated
Date: Sun, 22 Jan 2017 23:16:50 -0500
Message-ID: <20170123041650.GQ29778@windriver.com>
References: <20170122163244.11740-21-paul.gortmaker@windriver.com>
 <201701230645.PYFdx082%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201701230645.PYFdx082%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

[Re: [PATCH 20/20] module.h: remove extable.h include now users have migrated] On 23/01/2017 (Mon 06:52) kbuild test robot wrote:

> Hi Paul,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.10-rc5 next-20170120]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Paul-Gortmaker/ia64-move-ia64_done_with_exception-out-of-asm-uaccess-h/20170123-004155
> config: cris-etraxfs_defconfig (attached as .config)

Thanks (once again) for the build coverage.  I'd actually built cris
(allmodconfig) but strangely enough it didn't show this particular
defconfig issue.  I'll fix it to ensure this file includes extable.h 

Paul.
--

> compiler: cris-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=cris 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/cris/arch-v32/kernel/traps.c: In function 'fixup_BUG':
> >> arch/cris/arch-v32/kernel/traps.c:159:11: error: implicit declaration of function 'search_exception_tables' [-Werror=implicit-function-declaration]
>       fixup = search_exception_tables(instruction_pointer(regs) - 2);
>               ^~~~~~~~~~~~~~~~~~~~~~~
> >> arch/cris/arch-v32/kernel/traps.c:159:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>       fixup = search_exception_tables(instruction_pointer(regs) - 2);
>             ^
>    cc1: some warnings being treated as errors
> 
> vim +/search_exception_tables +159 arch/cris/arch-v32/kernel/traps.c
> 
> 51533b61 Mikael Starvik 2005-07-27  143  
> 9ce1ea75 Jesper Nilsson 2007-12-03  144  void fixup_BUG(struct pt_regs *regs)
> 51533b61 Mikael Starvik 2005-07-27  145  {
> 9ce1ea75 Jesper Nilsson 2007-12-03  146  	BUG_regs = *regs;
> 9ce1ea75 Jesper Nilsson 2007-12-03  147  
> 9ce1ea75 Jesper Nilsson 2007-12-03  148  #ifdef CONFIG_DEBUG_BUGVERBOSE
> 9ce1ea75 Jesper Nilsson 2007-12-03  149  	/*
> 9ce1ea75 Jesper Nilsson 2007-12-03  150  	 * Fixup the BUG arguments through exception handlers.
> 9ce1ea75 Jesper Nilsson 2007-12-03  151  	 */
> 9ce1ea75 Jesper Nilsson 2007-12-03  152  	{
> 9ce1ea75 Jesper Nilsson 2007-12-03  153  		const struct exception_table_entry *fixup;
> 9ce1ea75 Jesper Nilsson 2007-12-03  154  
> 9ce1ea75 Jesper Nilsson 2007-12-03  155  		/*
> 9ce1ea75 Jesper Nilsson 2007-12-03  156  		 * ERP points at the "break 14" + 2, compensate for the 2
> 9ce1ea75 Jesper Nilsson 2007-12-03  157  		 * bytes.
> 9ce1ea75 Jesper Nilsson 2007-12-03  158  		 */
> 9ce1ea75 Jesper Nilsson 2007-12-03 @159  		fixup = search_exception_tables(instruction_pointer(regs) - 2);
> 9ce1ea75 Jesper Nilsson 2007-12-03  160  		if (fixup) {
> 9ce1ea75 Jesper Nilsson 2007-12-03  161  			/* Adjust the instruction pointer in the stackframe. */
> 9ce1ea75 Jesper Nilsson 2007-12-03  162  			instruction_pointer(regs) = fixup->fixup;
> 9ce1ea75 Jesper Nilsson 2007-12-03  163  			arch_fixup(regs);
> 51533b61 Mikael Starvik 2005-07-27  164  		}
> 9ce1ea75 Jesper Nilsson 2007-12-03  165  	}
> 9ce1ea75 Jesper Nilsson 2007-12-03  166  #else
> 9ce1ea75 Jesper Nilsson 2007-12-03  167  	/* Dont try to lookup the filename + line, just dump regs.  */
> 
> :::::: The code at line 159 was first introduced by commit
> :::::: 9ce1ea751f7256b2248321c2427612a295f15137 CRIS v32: Update and improve kernel/traps.c
> 
> :::::: TO: Jesper Nilsson <jesper.nilsson@axis.com>
> :::::: CC: Jesper Nilsson <jesper.nilsson@axis.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
