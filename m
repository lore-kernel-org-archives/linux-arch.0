Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B10395AD5;
	Wed, 13 May 2026 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652767; cv=none; b=oizS4APztpAQ4aNmmoPBzhaA38Gy+LCxZjlq6Qi8dt7AjXx1552SpfKHJ0FdRXr4VtegQenuhdjfLF05Jur5ruj1CG68AUoqeuSDqPT9iUJaMvHRe/9/hcZx8MnqF8+W0/s3BHSEl3M78Sbaqnhd/2vomvgayaPgRdoJy9Db1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652767; c=relaxed/simple;
	bh=8/g0tgr/8x4vCKR3FY6O1wuKpyVe59KewQCyaI/CkQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDnLeZQwW84qHrMpqCCJ6ktyvP+3BFgZC1oTXZN/hwRL+OH/RGa0a0ZAVUUnRoPnyiXgg3fKlvGSVMs7Gj4Hkaeec7/966XxAnRVN5qAWYcRu4Tgi4PloawSBueMN+gSZWPZhPDLslU69mR8xzlFMkcniJ+M2iZDryAZGk3Hrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEiIp6Qc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEiIp6Qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778652765; x=1810188765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/g0tgr/8x4vCKR3FY6O1wuKpyVe59KewQCyaI/CkQQ=;
  b=FEiIp6QcG8Mv8pahO24twFx7EZUxbuqrNagp49RZmrxkGEX/NXA+EYn/
   hLpsWgr3uAoaLev27s+ABGwoUIxh+Gf9s6IcbjYaHLsgzzHWeALwi+sPH
   732zFZzdlS5Zt2MhjnssP4+5lzyT5J1bYyi+JUbjPXCjJh4QTToCa0Elr
   Yz5kYE0nyH3XMad1e2z38qHVJo6MJ1i6TKFa7oDnziIiToPRTsmhK3Eq1
   s54sKECCeM9hrqj003WfZHQzFWtdpOXDevIqFxFxbk+iA5er04XDQo2+G
   ktL77T1YTZ8wK2SfBC5mCMspp2tdz+1IYv+c3DalhiZ1h6X7KbeS2LQzT
   Q==;
X-CSE-ConnectionGUID: sNc4JDuESJGmuGvYB4OMFQ==
X-CSE-MsgGUID: y71c2/SgT8iiSEeH7KOD1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90955020"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90955020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:12:44 -0700
X-CSE-ConnectionGUID: 2i93/dl6TbWCCX0UwefHBA==
X-CSE-MsgGUID: phmejI5KRIS5n9pT4+TNMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233713261"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2026 23:12:38 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN2pg-000000008UF-2M6L;
	Wed, 13 May 2026 06:12:36 +0000
Date: Wed, 13 May 2026 08:12:05 +0200
From: kernel test robot <lkp@intel.com>
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Dan Carpenter <error27@gmail.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: Re: [PATCH v8 4/4] kunit: Add documentation for warning backtrace
 suppression API
Message-ID: <202605130826.e6Lyyytr-lkp@intel.com>
References: <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>

Hi Alessandro,

kernel test robot noticed the following build errors:

[auto build test ERROR on 80234b5ab240f52fa45d201e899e207b9265ef91]

url:    https://github.com/intel-lab-lkp/linux/commits/Albert-Esteve/bug-kunit-Core-support-for-suppressing-warning-backtraces/20260513-043807
base:   80234b5ab240f52fa45d201e899e207b9265ef91
patch link:    https://lore.kernel.org/r/20260504-kunit_add_support-v8-4-3e5957cdd235%40redhat.com
patch subject: [PATCH v8 4/4] kunit: Add documentation for warning backtrace suppression API
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260513/202605130826.e6Lyyytr-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130826.e6Lyyytr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130826.e6Lyyytr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_buddy.c:6:
>> include/kunit/test-bug.h:90:15: error: unknown type name 'bool'
      90 | static inline bool kunit_is_suppressed_warning(bool count) { return false; }
         |               ^~~~
   include/kunit/test-bug.h:13:1: note: 'bool' is defined in header '<stdbool.h>'; this is probably fixable by adding '#include <stdbool.h>'
      12 | #include <linux/stddef.h> /* for NULL */
     +++ |+#include <stdbool.h>
      13 | 
   include/kunit/test-bug.h:90:48: error: unknown type name 'bool'
      90 | static inline bool kunit_is_suppressed_warning(bool count) { return false; }
         |                                                ^~~~
   include/kunit/test-bug.h:90:48: note: 'bool' is defined in header '<stdbool.h>'; this is probably fixable by adding '#include <stdbool.h>'


vim +/bool +90 include/kunit/test-bug.h

    88	
    89	static inline struct kunit *kunit_get_current_test(void) { return NULL; }
  > 90	static inline bool kunit_is_suppressed_warning(bool count) { return false; }
    91	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
