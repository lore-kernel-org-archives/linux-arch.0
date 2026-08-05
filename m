Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D69371D11;
	Wed,  5 Aug 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939478; cv=none; b=UqQvaed1v4dfs+3EtErOL+hIz6anV3M8RvrXZf/KjnhbprK8A1rn012WP7hMACEIceXQlu2b/dk8O86bqw0iqHMq/yYSOUnGXmqbMC+Tux+2pcqmAIdZviTw6ghi2V7GSIpYtfYTo5kaL+YzOVjc5yNW1mSm+7wj59MsJNxJmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939478; c=relaxed/simple;
	bh=uWC9e7LcKH/SlN+YSHDFxYtxskKsbo31CBg9gUK67yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCr2AQAJx1c3csrCNhBG4Likoqz9rqayxry+q4zV5cZm2ZYMvVm1EPRziyuPd0DXWD3GUXsBrA0fdhcHVjOUFqvFNUtM7ROJue9jbX/kW+racVpOx1RqyqrbhtRxQrHLL6Udv4UK1m9qVdUwqAhvkElL3HjYdqCMTIJ0igV5/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1ylVzt6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1ylVzt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785939477; x=1817475477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uWC9e7LcKH/SlN+YSHDFxYtxskKsbo31CBg9gUK67yU=;
  b=Y1ylVzt6ziUb8Ep38X5FsWUIoWSSV9K+gmEGx9gGur04KE8HD/uO27lC
   2YlFhnzy3tLGbM9YF+OGw03RmUIspu6aYTxVrfSfiQ+Kw9IFsXOW/7n8H
   HN0yPw/qzC7E872vNEsLlKiLG4Xx9V5VRE1wbvS6svg76YELuVMAngBVG
   3NtBEE7Uu8D8U8EPQS/3jJmw+gfWE76fMfBJGOjPirTrIqsb2O3ZyHawx
   WSc03TX3EEfGdo62uhLJjssFn0FjSwI5NyVOC8y25rH4PsBJ2dVJxhuXg
   4icKivuX/p/iCL4P67jYO1zExkLZYfK8oEeAWnxUFfNYPxNGwESiu90Hs
   g==;
X-CSE-ConnectionGUID: JuxU8lG1Qj6crnwShbU8rA==
X-CSE-MsgGUID: iBkqexDtS6eP5J6aWrr8Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97875329"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97875329"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 07:17:56 -0700
X-CSE-ConnectionGUID: uhPcnlB8SFqqLvbJguNq6A==
X-CSE-MsgGUID: /GQAli+DQdyZv3raUxNCyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265663189"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 07:17:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrcRJ-00000000Ch7-19zB;
	Wed, 05 Aug 2026 14:17:49 +0000
Date: Wed, 5 Aug 2026 22:17:21 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, arnd@arndb.de, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	peterz@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, mhiramat@kernel.org, atomlin@atomlin.com,
	neelx@suse.com, da.anzani@gmail.com, sean@ashe.io,
	chjohnst@mail.com, steve@abita.co, mproche@mail.com,
	nick.lane@mail.com, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Extend module_blacklist parameter to built-in
 modules
Message-ID: <202608052234.AvJ5oSvK-lkp@intel.com>
References: <20260622140259.2974-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622140259.2974-1-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master arnd-asm-generic/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/module-Extend-module_blacklist-parameter-to-built-in-modules/20260805-123559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20260622140259.2974-1-atomlin%40atomlin.com
patch subject: [PATCH v2] module: Extend module_blacklist parameter to built-in modules
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260805/202608052234.AvJ5oSvK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608052234.AvJ5oSvK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608052234.AvJ5oSvK-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/main.c: In function 'do_one_initcall':
>> init/main.c:1364:24: error: implicit declaration of function 'module_is_blacklisted' [-Wimplicit-function-declaration]
    1364 |         if (modname && module_is_blacklisted(modname)) {
         |                        ^~~~~~~~~~~~~~~~~~~~~


vim +/module_is_blacklisted +1364 init/main.c

  1355	
  1356	int __init_or_module do_one_initcall(initcall_t fn)
  1357	{
  1358		int count = preempt_count();
  1359		char msgbuf[64];
  1360		const char *modname;
  1361		int ret;
  1362	
  1363		modname = initcall_get_modname(fn);
> 1364		if (modname && module_is_blacklisted(modname)) {
  1365			pr_info("Skipping initcall for blacklisted built-in module %s\n",
  1366				modname);
  1367			return 0;
  1368		}
  1369	
  1370		if (initcall_blacklisted(fn))
  1371			return -EPERM;
  1372	
  1373		do_trace_initcall_start(fn);
  1374		ret = fn();
  1375		do_trace_initcall_finish(fn, ret);
  1376	
  1377		msgbuf[0] = 0;
  1378	
  1379		if (preempt_count() != count) {
  1380			sprintf(msgbuf, "preemption imbalance ");
  1381			preempt_count_set(count);
  1382		}
  1383		if (irqs_disabled()) {
  1384			strlcat(msgbuf, "disabled interrupts ", sizeof(msgbuf));
  1385			local_irq_enable();
  1386		}
  1387		WARN(msgbuf[0], "initcall %pS returned with %s\n", fn, msgbuf);
  1388	
  1389		add_latent_entropy();
  1390		return ret;
  1391	}
  1392	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
