Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DC366DB5;
	Thu,  5 Mar 2026 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698299; cv=none; b=OM82C4DeBJW9kGRnlxjdJ366EVBFWmvxJ/l8FGXYJ7rrQi9OEuQEyrwWIG8qVD9JMEI/2I2MbvjIfbINJPHByutX3AddEhLlC9oe/mDwqL/i7yxJ3eW4h2S1IETsOBsy1C3/gec1TeLGAbU03Isg4EQI3KUC521oW7moQx+EtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698299; c=relaxed/simple;
	bh=P1IxORabMUXtaZRmjronk2GUIU/HlHrlj6R/Sxr623k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iueQcfad8/y3XjocOpbaYoDR0intC9TOgIsal7vXdsijYUmpgZRQFpX1/aYwrGin/L1BPly8T/LkwKcyZEfyqCheD+NAYym4k2hz7SgOuV9dnmzLA5A/VUnP+QK5xnbvGZIoTvByT1jdMJ6Zz2yj/BQQ06MnWmbsbHn90+iJfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxaCKKMg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxaCKKMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772698296; x=1804234296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P1IxORabMUXtaZRmjronk2GUIU/HlHrlj6R/Sxr623k=;
  b=fxaCKKMgwGtfD1/TTboxWcf5CYNFUiqqoiwdBdGQHXvCJJ5+2ctaeTk4
   S60YXOufUcfTR+WijQxnlDYcb6eWM9dW4AgEzeIMD+hiHba5z8/KJZ4Vz
   BDIQxOKq1cRTU5NMDifwJRTOkKJ3t2/FZR9gq/cxNmPft9UO9rw/aMfq2
   GsSyckCzPm0/72ow9MSUtWc16U1N1vLg5oBr5r1aP2OlMLnmQgnnhkOjT
   IzdF9uEUrilOhauwmaYvI/ISw3M23eKQKoNLsXOk0IzSndkFuP/vbTvZA
   Rk6YSxKUZcXUCDizlPQ0ik62GHQ4pjC1gYo3FjI5vFCPfP7oS0A2beejp
   A==;
X-CSE-ConnectionGUID: 4WN9SXRWQYOOioskI0U/yQ==
X-CSE-MsgGUID: Ijae1vrPTb6mQoRzme5eyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77621856"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77621856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 00:11:36 -0800
X-CSE-ConnectionGUID: uZZ54sjjSyuEdp3lo1B8ow==
X-CSE-MsgGUID: 0aR1CYEQR+u40BZ1Fc/Syg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="216418395"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2026 00:11:34 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy3nv-000000000Go-3V2B;
	Thu, 05 Mar 2026 08:11:31 +0000
Date: Thu, 5 Mar 2026 16:10:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] [PATCH]-This patch series completes the
 implementation of do_mq_timedreceive2 new        system calls that provide
 non-destructive peek functionality        on POSIX message queues
Message-ID: <202603051551.UzHTmDax-lkp@intel.com>
References: <20260304135126.77270-3-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304135126.77270-3-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v7.0-rc2 next-20260304]
[cannot apply to arnd-asm-generic/master tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection/20260305-020107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260304135126.77270-3-academic1mathura%40gmail.com
patch subject: [PATCH 3/3] [PATCH]-This patch series completes the implementation of do_mq_timedreceive2 new        system calls that provide non-destructive peek functionality        on POSIX message queues
config: riscv-randconfig-r072-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051551.UzHTmDax-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051551.UzHTmDax-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051551.UzHTmDax-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> ./arch/riscv/include/generated/asm/syscall_table_32.h:475:11: error: array index in initializer exceeds array bounds
     475 | __SYSCALL(474, sys_mq_timedreceive2)
         |           ^~~
   arch/riscv/kernel/compat_syscall_table.c:18:35: note: in definition of macro '__SYSCALL'
      18 | #define __SYSCALL(nr, call)      [nr] = __riscv_##call,
         |                                   ^~
   ./arch/riscv/include/generated/asm/syscall_table_32.h:475:11: note: (near initialization for 'compat_sys_call_table')
     475 | __SYSCALL(474, sys_mq_timedreceive2)
         |           ^~~
   arch/riscv/kernel/compat_syscall_table.c:18:35: note: in definition of macro '__SYSCALL'
      18 | #define __SYSCALL(nr, call)      [nr] = __riscv_##call,
         |                                   ^~
>> arch/riscv/kernel/compat_syscall_table.c:18:41: warning: excess elements in array initializer
      18 | #define __SYSCALL(nr, call)      [nr] = __riscv_##call,
         |                                         ^~~~~~~~
   ./arch/riscv/include/generated/asm/syscall_table_32.h:475:1: note: in expansion of macro '__SYSCALL'
     475 | __SYSCALL(474, sys_mq_timedreceive2)
         | ^~~~~~~~~
   arch/riscv/kernel/compat_syscall_table.c:18:41: note: (near initialization for 'compat_sys_call_table')
      18 | #define __SYSCALL(nr, call)      [nr] = __riscv_##call,
         |                                         ^~~~~~~~
   ./arch/riscv/include/generated/asm/syscall_table_32.h:475:1: note: in expansion of macro '__SYSCALL'
     475 | __SYSCALL(474, sys_mq_timedreceive2)
         | ^~~~~~~~~
--
   In file included from arch/riscv/include/uapi/asm/unistd.h:22,
                    from arch/riscv/include/asm/unistd.h:27,
                    from arch/riscv/kernel/compat_vdso/../vdso/flush_icache.S:7,
                    from arch/riscv/kernel/compat_vdso/flush_icache.S:3:
>> ./arch/riscv/include/generated/uapi/asm/unistd_32.h:322:9: warning: '__NR_mq_timedreceive_time64' redefined
     322 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/riscv/include/generated/uapi/asm/unistd_32.h:269:9: note: this is the location of the previous definition
     269 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/include/uapi/asm/unistd.h:22,
                    from arch/riscv/include/asm/unistd.h:27,
                    from arch/riscv/kernel/compat_vdso/../vdso/getcpu.S:7,
                    from arch/riscv/kernel/compat_vdso/getcpu.S:3:
>> ./arch/riscv/include/generated/uapi/asm/unistd_32.h:322:9: warning: '__NR_mq_timedreceive_time64' redefined
     322 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/riscv/include/generated/uapi/asm/unistd_32.h:269:9: note: this is the location of the previous definition
     269 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/include/uapi/asm/unistd.h:22,
                    from arch/riscv/include/asm/unistd.h:27,
                    from arch/riscv/kernel/compat_vdso/../vdso/rt_sigreturn.S:7,
                    from arch/riscv/kernel/compat_vdso/rt_sigreturn.S:3:
>> ./arch/riscv/include/generated/uapi/asm/unistd_32.h:322:9: warning: '__NR_mq_timedreceive_time64' redefined
     322 | #define __NR_mq_timedreceive_time64 474
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./arch/riscv/include/generated/uapi/asm/unistd_32.h:269:9: note: this is the location of the previous definition
     269 | #define __NR_mq_timedreceive_time64 419
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
