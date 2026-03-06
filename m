Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994A3EB7EA;
	Fri,  6 Mar 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835132; cv=none; b=EtEUCzumSBoZM/h2iOhcbSRoehgWLyWgk6FKL5vo1fXf9QpTAoD5ML5T8VSSyTGYDNEc24LIolDVuqmxts/xczbeaz5ie83DPo7IlnDgQa1tZns9Gu45xiKgPxnRfFyd4NSdndrUQSDveFXAKwahh9MVW87Zhl+O7a2E/FUK2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835132; c=relaxed/simple;
	bh=SCjRlmQ0F+1R3xcmeAb4gNlB7Gv62cxe0g2AGwVlT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtnrJsNpeldamWqn+Wq3pHpymi3lUTq251ndOTqwOLnD56prUSIE9bVWchHLt28SJ70u8bvaOI/bpUPGgT0UW56ewH81MFHfI5qH6OlLzBswvso3toXZYm9IvoRp9iBFNzbmZeoBzcMogjDuDl/b0CRIfoPJ1lxtWq9PsAosIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEIzwXp6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEIzwXp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772835130; x=1804371130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SCjRlmQ0F+1R3xcmeAb4gNlB7Gv62cxe0g2AGwVlT+k=;
  b=ZEIzwXp6tyJNDoGrYU1GCdZiVul7dshEKqmOTfJvO4d+YqSXtZkA906J
   gPlAcB4/R4dis0JWzEyt08ELgZkqqHfZqNbm2tnrZres4xW+T1NhwBikB
   kJsVvP2CsKlMzf5Lq7o53O2aiDk1rTDRYy+e5bKCV/dAfAQYBd6WQ4MG7
   DHPB9bWL0g8O2j6LMLAGjTPJcb9KwxjQqKO4obpYiRkarJeDUBF9AEAOk
   qTpXp8rcc0mf1SUsJtD9Qf99KAGVGi9Xov78qEWWz9Nyn6J9+c++ri2lq
   mXAiIt9RqS99It6FMUFh/EeB6NBxMnHhG8JKg6kJA6EgLBi12n9v88h+C
   w==;
X-CSE-ConnectionGUID: xrKDf5XnQo+phbbkqmzERA==
X-CSE-MsgGUID: goMpmVKbT2yySLMnPeVydA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="77551161"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="77551161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:12:10 -0800
X-CSE-ConnectionGUID: VOPlizh2QvqnJ5pP16schg==
X-CSE-MsgGUID: CKouNqgyQnSIlUhEeBJo/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="219250180"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Mar 2026 14:12:08 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vydOv-000000001QH-2I0D;
	Fri, 06 Mar 2026 22:12:05 +0000
Date: Sat, 7 Mar 2026 06:11:39 +0800
From: kernel test robot <lkp@intel.com>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, academic1mathura@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
 mq_peek syscall] for non-destructive receive and inspection,fix minor
 issue,prepared doc.
Message-ID: <202603070636.7HA192z4-lkp@intel.com>
References: <20260306075009.83723-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306075009.83723-1-academic1mathura@gmail.com>

Hi Mathura_Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes brauner-vfs/vfs.all linus/master v7.0-rc2 next-20260306]
[cannot apply to tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathura_Kumar/mqueue-introduce-new-do_mq_timedreceive2-mq_peek-syscall-for-non-destructive-receive-and-inspection-fix-minor-issue-prep/20260306-155240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20260306075009.83723-1-academic1mathura%40gmail.com
patch subject: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [ mq_peek syscall] for non-destructive receive and inspection,fix minor issue,prepared doc.
config: powerpc-randconfig-r053-20260307 (https://download.01.org/0day-ci/archive/20260307/202603070636.7HA192z4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070636.7HA192z4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070636.7HA192z4-lkp@intel.com/

All errors (new ones prefixed by >>):

   include/linux/syscalls.h:122:27: note: in expansion of macro '__SC_LONG'
    #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
                              ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
   arch/powerpc/include/asm/syscall_wrapper.h:27:29: note: in expansion of macro '__MAP'
     static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
                                ^~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   In file included from ipc/mqueue.c:29:
   ipc/mqueue.c: In function '__se_sys_mq_timedreceive2_time32':
   include/linux/syscalls.h:133:25: error: passing argument 2 of '__do_sys_mq_timedreceive2_time32' from incompatible pointer type [-Werror=incompatible-pointer-types]
    #define __SC_CAST(t, a) (__force t) a
   include/linux/syscalls.h:122:27: note: in expansion of macro '__SC_CAST'
    #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
                              ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
   arch/powerpc/include/asm/syscall_wrapper.h:29:29: note: in expansion of macro '__MAP'
      long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__)); \
                                ^~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1748:49: note: expected 'struct compat_mq_timedreceive2_args *' but argument is of type 'struct compat_mq_timedreceive2_args *'
      struct compat_mq_timedreceive2_args __user *, uargs,
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/syscalls.h:127:27: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                              ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
   arch/powerpc/include/asm/syscall_wrapper.h:22:36: note: in expansion of macro '__MAP'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                                       ^~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   ipc/mqueue.c: At top level:
   ipc/mqueue.c:1748:10: warning: 'struct compat_mq_timedreceive2_args' declared inside parameter list will not be visible outside of this definition or declaration
      struct compat_mq_timedreceive2_args __user *, uargs,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:127:25: note: in definition of macro '__SC_DECL'
    #define __SC_DECL(t, a) t a
                            ^
   include/linux/syscalls.h:123:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^~~~~~
   include/linux/syscalls.h:125:22: note: in expansion of macro '__MAP5'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^~~~~
   arch/powerpc/include/asm/syscall_wrapper.h:34:36: note: in expansion of macro '__MAP'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                                       ^~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   In file included from include/linux/compat.h:34,
                    from include/net/compat.h:8,
                    from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from ipc/mqueue.c:28:
>> arch/powerpc/include/asm/syscall_wrapper.h:34:21: error: conflicting types for '__do_sys_mq_timedreceive2_time32'
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                        ^~~~~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/syscall_wrapper.h:22:21: note: previous declaration of '__do_sys_mq_timedreceive2_time32' was here
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                        ^~~~~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   ipc/mqueue.c: In function '__do_sys_mq_timedreceive2_time32':
   ipc/mqueue.c:1756:6: error: implicit declaration of function 'get_compat_mq_args'; did you mean 'get_compat_msghdr'? [-Werror=implicit-function-declaration]
     if (get_compat_mq_args(pargs, uargs))
         ^~~~~~~~~~~~~~~~~~
         get_compat_msghdr
   In file included from include/linux/compat.h:34,
                    from include/net/compat.h:8,
                    from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from ipc/mqueue.c:28:
   ipc/mqueue.c: At top level:
   arch/powerpc/include/asm/syscall_wrapper.h:22:21: warning: '__do_sys_mq_timedreceive2_time32' used but never defined
     static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
                        ^~~~~~~~
   include/linux/syscalls.h:237:2: note: in expansion of macro '__SYSCALL_DEFINEx'
     __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
     ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:36: note: in expansion of macro 'SYSCALL_DEFINEx'
    #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
                                       ^~~~~~~~~~~~~~~
   ipc/mqueue.c:1747:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
    ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__do_sys_mq_timedreceive2_time32 +34 arch/powerpc/include/asm/syscall_wrapper.h

7e92e01b724526 Rohan McLure     2022-09-21  12  
7e92e01b724526 Rohan McLure     2022-09-21  13  #define SC_POWERPC_REGS_TO_ARGS(x, ...)				\
7e92e01b724526 Rohan McLure     2022-09-21  14  	__MAP(x,__SC_ARGS					\
7e92e01b724526 Rohan McLure     2022-09-21  15  	      ,,regs->gpr[3],,regs->gpr[4],,regs->gpr[5]	\
7e92e01b724526 Rohan McLure     2022-09-21  16  	      ,,regs->gpr[6],,regs->gpr[7],,regs->gpr[8])
7e92e01b724526 Rohan McLure     2022-09-21  17  
7e92e01b724526 Rohan McLure     2022-09-21  18  #define __SYSCALL_DEFINEx(x, name, ...)						\
94746890202cf1 Michael Ellerman 2022-10-06  19  	long sys##name(const struct pt_regs *regs);			\
94746890202cf1 Michael Ellerman 2022-10-06  20  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
7e92e01b724526 Rohan McLure     2022-09-21  21  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
7e92e01b724526 Rohan McLure     2022-09-21  22  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
94746890202cf1 Michael Ellerman 2022-10-06  23  	long sys##name(const struct pt_regs *regs)			\
7e92e01b724526 Rohan McLure     2022-09-21  24  	{									\
7e92e01b724526 Rohan McLure     2022-09-21  25  		return __se_sys##name(SC_POWERPC_REGS_TO_ARGS(x,__VA_ARGS__));	\
7e92e01b724526 Rohan McLure     2022-09-21  26  	}									\
7e92e01b724526 Rohan McLure     2022-09-21  27  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
7e92e01b724526 Rohan McLure     2022-09-21  28  	{									\
7e92e01b724526 Rohan McLure     2022-09-21  29  		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
7e92e01b724526 Rohan McLure     2022-09-21  30  		__MAP(x,__SC_TEST,__VA_ARGS__);					\
7e92e01b724526 Rohan McLure     2022-09-21  31  		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
7e92e01b724526 Rohan McLure     2022-09-21  32  		return ret;							\
7e92e01b724526 Rohan McLure     2022-09-21  33  	}									\
7e92e01b724526 Rohan McLure     2022-09-21 @34  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
7e92e01b724526 Rohan McLure     2022-09-21  35  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
