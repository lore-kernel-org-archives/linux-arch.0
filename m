Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703833C53F;
	Thu, 22 Jan 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044350; cv=none; b=oCTtrYKNPifsJ6WXdIWIzazJLgLjGvF34VOIW+re7ZkRCZzEgx1HxCKF7L96XGQapJjHK4+w8ptWCgSHhP6Cvp+njLxDdSIcaM8rBeHM5oNoEvuGFLZqJtviD338/K1cBBJiVtV3pI/vj4zgjTx7/lz9yN27YSHpluD6k9xkpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044350; c=relaxed/simple;
	bh=QVMUWucKVUo5Jl2bgmDp5wlChrNcG2VDFMqtEXavpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddCsXj+IzBIx4UARfM8xjM9VDBxd1cQjP76cbdCQZ1p6jDSKhmoiExKxkIjInTdsoy/F/FaOawrKs+/H0DIgKsbRNzoXksvA0B6F0SRaUa+1tsarFc8Iiq0CgDdYIc5FzkXguyOIs9WtPSOVmRp15DAilY7gZwwVH+gY+e25Oh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5zU6dGO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5zU6dGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769044349; x=1800580349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QVMUWucKVUo5Jl2bgmDp5wlChrNcG2VDFMqtEXavpPo=;
  b=J5zU6dGOe9jDMp38x9qoZu1AvlWpG5gt45eLXZg3BHTkrL0jB0hazAhc
   d/afRvKQnmQ6eE6NLRjefZBK/YQRlisrfB8bbIDCt0wyL0kWH3TrZgiP6
   GbtBTpaj6epSUQSwbROvd2OwpHqfa3jGKfGwfEU4VhAwXd/5T/6yaWW+b
   9zfuqVGMdXsKCLaGLwkTz+HkL3QST73cV9HxFHXS9ho07GvKYLyfqXSet
   NUrySAYBHDkGyqqzE7wSVLELbG9kgYjckFeWvsDFwcwS6CZoNrSzaAHV7
   pcvm9Z7AK91vubutw6Gup2NE/4+eIDAq4hzMjhINY9YxkH8m/n+D8sHDs
   A==;
X-CSE-ConnectionGUID: ooV/jwKjRcurMOaHpFILjQ==
X-CSE-MsgGUID: WhHhMLc/TUykX0Oa2BpeEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80904733"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="80904733"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:12:28 -0800
X-CSE-ConnectionGUID: TQFW317MQY2Hv0HZmg/W7A==
X-CSE-MsgGUID: L9x4vIJVRNaJJpOZZj8zOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211106979"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Jan 2026 17:12:23 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vijFE-00000000SET-1IMD;
	Thu, 22 Jan 2026 01:12:20 +0000
Date: Thu, 22 Jan 2026 09:11:53 +0800
From: kernel test robot <lkp@intel.com>
To: david.laight.linux@gmail.com, Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <202601220829.MgTMeqqN-lkp@intel.com>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-12-david.laight.linux@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260120]

url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
base:   next-20260120
patch link:    https://lore.kernel.org/r/20260121145731.3623-12-david.laight.linux%40gmail.com
patch subject: [PATCH next 11/14] bit: Strengthen compile-time tests in GENMASK() and BIT()
config: s390-randconfig-001-20260122 (https://download.01.org/0day-ci/archive/20260122/202601220829.MgTMeqqN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220829.MgTMeqqN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220829.MgTMeqqN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from arch/s390/include/asm/cmpxchg.h:11,
                    from arch/s390/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/s390/include/asm/bitops.h:75,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23,
                    from net/core/page_pool.c:10:
   In function 'netmem_clear_pp_magic',
       inlined from 'page_pool_clear_pp_info' at net/core/page_pool.c:721:2:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:120:25: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_on = !!(condition);    \
                            ^~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   net/core/netmem_priv.h:18:52: note: in expansion of macro 'PP_DMA_INDEX_MASK'
     WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
                                                       ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/bitops.h:6,
                    from arch/s390/include/asm/machine.h:25,
                    from arch/s390/include/asm/lowcore.h:13,
                    from arch/s390/include/asm/current.h:13,
                    from arch/s390/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from arch/s390/include/asm/timex.h:13,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from net/core/skbuff.c:37:
   In function 'netmem_get_pp_magic',
       inlined from 'netmem_is_pp' at net/core/netmem_priv.h:25:10,
       inlined from 'napi_pp_put_page' at net/core/skbuff.c:1027:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   net/core/netmem_priv.h:8:47: note: in expansion of macro 'PP_DMA_INDEX_MASK'
     return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
                                                  ^~~~~~~~~~~~~~~~~
   In function 'netmem_is_pp',
       inlined from 'napi_pp_put_page' at net/core/skbuff.c:1027:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   include/linux/mm.h:4650:25: note: in expansion of macro 'PP_DMA_INDEX_MASK'
    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
                            ^~~~~~~~~~~~~~~~~
   net/core/netmem_priv.h:25:40: note: in expansion of macro 'PP_MAGIC_MASK'
     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
                                           ^~~~~~~~~~~~~
   In function 'netmem_get_pp_magic',
       inlined from 'netmem_is_pp' at net/core/netmem_priv.h:25:10,
       inlined from 'napi_pp_put_page' at net/core/skbuff.c:1027:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   net/core/netmem_priv.h:8:47: note: in expansion of macro 'PP_DMA_INDEX_MASK'
     return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
                                                  ^~~~~~~~~~~~~~~~~
   In function 'netmem_is_pp',
       inlined from 'napi_pp_put_page' at net/core/skbuff.c:1027:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   include/linux/mm.h:4650:25: note: in expansion of macro 'PP_DMA_INDEX_MASK'
    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
                            ^~~~~~~~~~~~~~~~~
   net/core/netmem_priv.h:25:40: note: in expansion of macro 'PP_MAGIC_MASK'
     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
                                           ^~~~~~~~~~~~~
   In function 'netmem_get_pp_magic',
       inlined from 'netmem_is_pp' at net/core/netmem_priv.h:25:10,
       inlined from 'skb_pp_frag_ref' at net/core/skbuff.c:1067:7,
       inlined from 'skb_try_coalesce' at net/core/skbuff.c:6203:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   net/core/netmem_priv.h:8:47: note: in expansion of macro 'PP_DMA_INDEX_MASK'
     return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
                                                  ^~~~~~~~~~~~~~~~~
   In function 'netmem_is_pp',
       inlined from 'skb_pp_frag_ref' at net/core/skbuff.c:1067:7,
       inlined from 'skb_try_coalesce' at net/core/skbuff.c:6203:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   include/linux/mm.h:4650:25: note: in expansion of macro 'PP_DMA_INDEX_MASK'
    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
                            ^~~~~~~~~~~~~~~~~
   net/core/netmem_priv.h:25:40: note: in expansion of macro 'PP_MAGIC_MASK'
     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
                                           ^~~~~~~~~~~~~
   In function 'netmem_get_pp_magic',
       inlined from 'netmem_is_pp' at net/core/netmem_priv.h:25:10,
       inlined from 'skb_pp_frag_ref' at net/core/skbuff.c:1067:7,
       inlined from 'skb_try_coalesce' at net/core/skbuff.c:6203:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   net/core/netmem_priv.h:8:47: note: in expansion of macro 'PP_DMA_INDEX_MASK'
     return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
                                                  ^~~~~~~~~~~~~~~~~
   In function 'netmem_is_pp',
       inlined from 'skb_pp_frag_ref' at net/core/skbuff.c:1067:7,
       inlined from 'skb_try_coalesce' at net/core/skbuff.c:6203:6:
>> include/linux/bits.h:35:4: error: call to 'GENMASK_INPUT_CHECK_FAIL' declared with attribute error: Invalid bit numbers
       GENMASK_INPUT_CHECK_FAIL()))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:54:17: note: in expansion of macro 'GENMASK_INPUT_CHECK'
     ((unsigned int)GENMASK_INPUT_CHECK(h, l, BITS_PER_TYPE(t)) + \
                    ^~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:58:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   include/linux/mm.h:4641:27: note: in expansion of macro 'GENMASK'
    #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
                              ^~~~~~~
   include/linux/mm.h:4650:25: note: in expansion of macro 'PP_DMA_INDEX_MASK'
    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
                            ^~~~~~~~~~~~~~~~~
   net/core/netmem_priv.h:25:40: note: in expansion of macro 'PP_MAGIC_MASK'
     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
                                           ^~~~~~~~~~~~~


vim +/GENMASK_INPUT_CHECK_FAIL +35 include/linux/bits.h

    25	
    26	#ifndef KBUILD_EXTRA_WARNc
    27	#define GENMASK_INPUT_CHECK(h, l, width) 0
    28	#else
    29	int GENMASK_INPUT_CHECK_FAIL(void) __compiletime_error("Invalid bit numbers");
    30	#define GENMASK_INPUT_CHECK(h, l, width)				\
    31		(__builtin_choose_expr(__is_constexpr((l) > (h)),		\
    32			sizeof(struct { char low_bit_greater_than_high[-((l) > (h))];}), \
    33			__builtin_constant_p((l) | (h)) &&			\
    34				((l) < 0 || (l) > (h) || (h) >= width) &&	\
  > 35				GENMASK_INPUT_CHECK_FAIL()))
    36	#endif
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
