Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513545;
	b=FlE6uHr/Amk9cqSk4lLuo5JD+lex6dez7e/tz6IZrTngpL4/MuE+kWJCkZarI7BlQc8F
	 duKkvq0Vkxsh5C6Z58GhpNWCARz0XAFunDuTKnAuOQhKeFVcKbtvwS74MQOxoFrnrFTNc
	 HkWZzxMbZsGh3zj1kqcVlSCKX8HiFCYHdLcQpM1jU+6jW1EPpq5yUZ9PX6GGt6ulStBLD
	 WmzWiY0C6EZdr7cOLTqkhpQL40Kv+ZCOD8LGyCrXBQ/vhlB0VNxtzhglvQO1daXcBcjEF
	 gYFr7x9btL7FSefJODuxATJvJ0stNbnhRsq6DnJqedMdgTeAOPtZs7E9dlM9Uo9zmTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513545;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=fWzx12TixYcff8w3GuH9mI59qKpAMZC9+3IxTxf0+Oc=;
	b=pE3yyuU1Zg4KUZK6ieZxiax74GdcvkZ8IhtPOBogWRPnv71UWlFEB4rnRuyvXz+LyOfG
	 hZ32Y6hd9+xLVZdUJ2pfUQgw/wavYJcpOyAl70cAXwbC6tHqhoABB2ZM+Tu2kBwPtbE03
	 eXwTDr7QemUGCKK9syeWCs5Q498MV6pwdH9Kb5V3/wmGyWTq+JG4krk/h2yjLWKLbd1Jn
	 A6eEX3NNC+qE+yB1ILevc7s8bX7/WQrEX5yL8lb2UmwRHiwQcmXYV2gW7/LMH4QvXF24p
	 M44wjhnsrh6BbNNLMg6MywpGnze6Chiex4hZ0CPbL4wbTyJWjK9EBGqXDAHt1XnHKaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMxAr5an;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDF606A32E
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 19:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CDF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMxAr5an
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794513543; x=1826049543;
  h=date:from:to:cc:subject:message-id;
  bh=Dx9DjmquyCow4zOKWdVsrkXJHxR0ymwkQnoXrzueSBw=;
  b=AMxAr5anz59+TN55BOD+/Hyx9ykovIqpYWU6RmEUVxLA4z8YJphWWPjb
   WogRZbGHwPF4OfcX8mS16aPxuSvEcwsCrU9V8zg73/1+rv0u0lebV1vQt
   +3bQ7OmB99cLc5xWVd6GkXF/e1ONNjm8fe74kxon24iFPz2p/pgsZitX/
   7DQuwMKamrYmSNYLeDQojiiucKwS7ZJgZcmIJHzwPgjD/Q9KdT0u2XZs3
   hlPXRrN6aKT0dY4ZZ4fgkhluTbfWHfvcB33vCl2f/dbMPz8pa6rjiKj20
   uQ/J6KBG2anFLD6tJjbpzM13UdZBN5D/00QmCdv7YoAydxWwJZ3m+38LD
   g==;
X-CSE-ConnectionGUID: ZzRnraa5RMKYlx6qB/GjCA==
X-CSE-MsgGUID: 821Om+rhSAaPxi0zHz+Hbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3345415"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3345415"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 11:59:03 -0800
X-CSE-ConnectionGUID: SToPpRKLTe2+95ZvCKvT5w==
X-CSE-MsgGUID: nPEwWAtlSXqKuzOSKXUixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="10520098"
Received: from igk-lkp-server01.igk.intel.com (HELO 1073a420ae3a) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 12 Nov 2026 11:59:02 -0800
Received: from kbuild by 1073a420ae3a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRawl-000000000wR-1oW2;
	Thu, 12 Nov 2026 19:58:59 +0000
Date: Thu, 12 Nov 2026 20:58:10 +0100
From: kernel test robot <lkp@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [arnd-asm-generic:master 15/16]
 /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:20: Error:
 unrecognized opcode: `typedef'
Message-ID: <202611122020.g57xOYbP-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   851bce698c6c23e9fee42c0aa0e2c42c11940360
commit: 625b37748a148e51ca888eac172f3a0a8f908ae9 [15/16] treewide: Stop defining __ASSEMBLY__ for assembler files
config: powerpc64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20261112/202611122020.g57xOYbP-lkp@intel.com/config)
compiler: powerpc64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611122020.g57xOYbP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611122020.g57xOYbP-lkp@intel.com/

Note: the arnd-asm-generic/master HEAD 851bce698c6c23e9fee42c0aa0e2c42c11940360 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h: Assembler messages:
>> /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:20: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:21: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:23: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:24: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:26: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:27: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:29: Error: unrecognized opcode: `typedef'
   /usr/powerpc64-linux-gnu/include/asm-generic/int-l64.h:30: Error: unrecognized opcode: `typedef'
>> /usr/powerpc64-linux-gnu/include/asm/types.h:34: Error: unrecognized opcode: `typedef'
>> /usr/powerpc64-linux-gnu/include/asm/types.h:35: Error: unrecognized opcode: `__u32'
>> /usr/powerpc64-linux-gnu/include/asm/types.h:36: Error: junk at end of line, first unrecognized character is `}'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
