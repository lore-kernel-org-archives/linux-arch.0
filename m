Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322D336891;
	Thu,  5 Mar 2026 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772687386; cv=none; b=S9LEl+kJ5eF0sTzYZZifJkRjAcjfurV9Zx/INaXnnqabqp8Xg2sY4N3StIDPSrQ2dKJeG4XlrqbQ8VcUVl62k1C6+sRMxXrwMBSTY7TJwKzHeXzXEUQiJOQzxdJa/03x8GgbEhImYEEkq+IgyoKV6vOU7+De/ZTlTic3MShCWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772687386; c=relaxed/simple;
	bh=iDZUVxgMDx8Gh39EeFZ43bSQrE6YBS+Zyg8WV2jlkE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdEqnkrrvzjYOY7rdrS5IK4XK7alTTJKMCr0VIQCpmfgVmo1mxdLMA7GKTSxjh8sOI0u+9UXCPS+vGxsZpEfegq7l+R0q311Lbe+B6/1YQdLAloJefOGPQwhALvDHjhpUqeHW0LyUDGqd2FikvddacP44uuUCY8r80nKU1Tt6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy5nVaqF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy5nVaqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772687384; x=1804223384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDZUVxgMDx8Gh39EeFZ43bSQrE6YBS+Zyg8WV2jlkE8=;
  b=Vy5nVaqFA9drvovb8UJ87zxyUx5fXH4xO8ETxnSUMuGNsq/TQ8hOzcvp
   6ZqSntmNc0yhVvSfCaIOtJ3+OAhi2nCugPubHlAJvYPtSKjkV+J8d0AB/
   3VWVDa6yQaJUPNA6U0vcSI5j3VbeDxYFg71Qe12S9npU2nmez7o4zEsCs
   BdEG4FTbhIOucnX5Z9jUBEaH2EsdVdanbQyQwYvLeyUQxTZ/FBCcZtO+5
   0nCSrGyrMqZiERRDEc3IatoMWqVAhE84izZopDkyqA/7gJ9zcLqSdkB1q
   +WP32ijl7A2OGw/bVKlxZ9B6UG2UBrTIEX7QtwsqX/HssMMqAcLdeIakS
   Q==;
X-CSE-ConnectionGUID: yaO4SZPeQa+h/MiiiwAg0g==
X-CSE-MsgGUID: 5iwKnzL6RVCKTQq92GqUaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96378862"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="96378862"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 21:09:44 -0800
X-CSE-ConnectionGUID: RSVT9U5zTpui8yYHYQ+JLA==
X-CSE-MsgGUID: Do7Rraw/ROaeeYmWSy8uzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215843922"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 04 Mar 2026 21:09:42 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy0xv-000000001xV-0Xbj;
	Thu, 05 Mar 2026 05:09:39 +0000
Date: Thu, 5 Mar 2026 06:09:09 +0100
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/3] mqueue: introduce new  do_mq_timedreceive2() [
 mq_peek  syscall] for non-destructive receive             and inspection
Message-ID: <202603050617.WQwaYhvS-lkp@intel.com>
References: <20260304135126.77270-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304135126.77270-1-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes next-20260304]
[cannot apply to arnd-asm-generic/master linus/master tip/x86/asm v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection/20260305-020107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260304135126.77270-1-academic1mathura%40gmail.com
patch subject: [PATCH 1/3] mqueue: introduce new  do_mq_timedreceive2() [ mq_peek  syscall] for non-destructive receive             and inspection
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260305/202603050617.WQwaYhvS-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050617.WQwaYhvS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050617.WQwaYhvS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

     122 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   ./include/linux/syscalls.h:124:22: note: in expansion of macro '__MAP5'
     124 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   ./arch/arm64/include/asm/syscall_wrapper.h:58:36: note: in expansion of macro '__MAP'
      58 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))              \
         |                                    ^~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: In function '__se_sys_mq_timedreceive2_time32':
   ./include/linux/syscalls.h:132:25: error: passing argument 2 of '__do_sys_mq_timedreceive2_time32' from incompatible pointer type [-Wincompatible-pointer-types]
     132 | #define __SC_CAST(t, a) (__force t) a
   ./include/linux/syscalls.h:121:27: note: in expansion of macro '__SC_CAST'
     121 | #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
         |                           ^
   ./include/linux/syscalls.h:122:35: note: in expansion of macro '__MAP4'
     122 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   ./include/linux/syscalls.h:124:22: note: in expansion of macro '__MAP5'
     124 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   ./arch/arm64/include/asm/syscall_wrapper.h:60:43: note: in expansion of macro '__MAP'
      60 |                 long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));      \
         |                                           ^~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1745:63: note: expected 'struct compat_mq_timedreceive2_args *' but argument is of type 'struct compat_mq_timedreceive2_args *'
    1745 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   ./include/linux/syscalls.h:126:27: note: in definition of macro '__SC_DECL'
     126 | #define __SC_DECL(t, a) t a
         |                           ^
   ./include/linux/syscalls.h:122:35: note: in expansion of macro '__MAP4'
     122 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   ./include/linux/syscalls.h:124:22: note: in expansion of macro '__MAP5'
     124 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   ./arch/arm64/include/asm/syscall_wrapper.h:53:43: note: in expansion of macro '__MAP'
      53 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));      \
         |                                           ^~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: At top level:
   ipc/mqueue.c:1745:24: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
    1745 |                 struct compat_mq_timedreceive2_args __user *, uargs,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:126:25: note: in definition of macro '__SC_DECL'
     126 | #define __SC_DECL(t, a) t a
         |                         ^
   ./include/linux/syscalls.h:122:35: note: in expansion of macro '__MAP4'
     122 | #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
         |                                   ^~~~~~
   ./include/linux/syscalls.h:124:22: note: in expansion of macro '__MAP5'
     124 | #define __MAP(n,...) __MAP##n(__VA_ARGS__)
         |                      ^~~~~
   ./arch/arm64/include/asm/syscall_wrapper.h:65:43: note: in expansion of macro '__MAP'
      65 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                                           ^~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   In file included from ./include/linux/compat.h:34,
                    from ./arch/arm64/include/asm/ftrace.h:41,
                    from ./include/linux/ftrace.h:23,
                    from ./include/linux/kprobes.h:28,
                    from ./include/linux/kgdb.h:17,
                    from ./arch/arm64/include/asm/cacheflush.h:11,
                    from ./include/linux/cacheflush.h:5,
                    from ./include/linux/highmem.h:8,
                    from ./include/linux/pagemap.h:11,
                    from ipc/mqueue.c:17:
>> ./arch/arm64/include/asm/syscall_wrapper.h:65:28: error: conflicting types for '__do_sys_mq_timedreceive2_time32'; have 'long int(mqd_t,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)' {aka 'long int(int,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)'}
      65 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ./arch/arm64/include/asm/syscall_wrapper.h:53:28: note: previous declaration of '__do_sys_mq_timedreceive2_time32' with type 'long int(mqd_t,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)' {aka 'long int(int,  struct compat_mq_timedreceive2_args *, unsigned int,  const long unsigned int,  const struct old_timespec32 *)'}
      53 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));      \
         |                            ^~~~~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~
   ipc/mqueue.c: In function '__do_sys_mq_timedreceive2_time32':
   ipc/mqueue.c:1753:13: error: implicit declaration of function 'get_compat_mq_args'; did you mean 'get_compat_msghdr'? [-Wimplicit-function-declaration]
    1753 |         if (get_compat_mq_args(pargs, uargs))
         |             ^~~~~~~~~~~~~~~~~~
         |             get_compat_msghdr
   ipc/mqueue.c: At top level:
>> ./arch/arm64/include/asm/syscall_wrapper.h:53:28: warning: '__do_sys_mq_timedreceive2_time32' used but never defined
      53 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));      \
         |                            ^~~~~~~~
   ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   ./include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     229 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1744:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    1744 | SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
         | ^~~~~~~~~~~~~~~


vim +65 ./arch/arm64/include/asm/syscall_wrapper.h

4378a7d4be30ec Mark Rutland 2018-07-11  48  
4378a7d4be30ec Mark Rutland 2018-07-11  49  #define __SYSCALL_DEFINEx(x, name, ...)						\
4378a7d4be30ec Mark Rutland 2018-07-11  50  	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
4378a7d4be30ec Mark Rutland 2018-07-11  51  	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
4378a7d4be30ec Mark Rutland 2018-07-11  52  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
4378a7d4be30ec Mark Rutland 2018-07-11 @53  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
4378a7d4be30ec Mark Rutland 2018-07-11  54  	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)		\
4378a7d4be30ec Mark Rutland 2018-07-11  55  	{									\
4378a7d4be30ec Mark Rutland 2018-07-11  56  		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
4378a7d4be30ec Mark Rutland 2018-07-11  57  	}									\
4378a7d4be30ec Mark Rutland 2018-07-11  58  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
4378a7d4be30ec Mark Rutland 2018-07-11  59  	{									\
4378a7d4be30ec Mark Rutland 2018-07-11  60  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
4378a7d4be30ec Mark Rutland 2018-07-11  61  		__MAP(x,__SC_TEST,__VA_ARGS__);					\
4378a7d4be30ec Mark Rutland 2018-07-11  62  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
4378a7d4be30ec Mark Rutland 2018-07-11  63  		return ret;							\
4378a7d4be30ec Mark Rutland 2018-07-11  64  	}									\
4378a7d4be30ec Mark Rutland 2018-07-11 @65  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
4378a7d4be30ec Mark Rutland 2018-07-11  66  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
