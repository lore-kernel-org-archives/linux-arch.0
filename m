Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF57363C57;
	Fri, 20 Mar 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993601; cv=none; b=efdiG6fb4c3d+428YFJAa1j116r8D29rAbJC8pnQXD5SuZ6mAFhVZZYePwdhXQai3xuXhTbNBa3s7jd9LwmWERLmYRjkSL5zqiIF+GRxWJ3De/Q3B3T31k46RImPAx2DTI2zjs5u+bKMwpOwKfjW2sJtHCE7NSb0WGhMwIzdGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993601; c=relaxed/simple;
	bh=tVna36lwdNvRPszSa/aiHWwVarH+I/kxHibJ/x1xtto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g70b3w0BHEJjKeb/J9VJXhR+dWbFSjZkXJamgnOF/TfIsv6BNe+VbxcOsdC30+zfgri2cNFBug4oXJ7hPSKaZhr4mjiFM4mbTHAigTAO749/HAmLD0ofDC6qXS8cqFkUTbHKEoiBjmV86ZGBMFhtPIsb05kxLa27I0vA/VbIRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQBMApEd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQBMApEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993599; x=1805529599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tVna36lwdNvRPszSa/aiHWwVarH+I/kxHibJ/x1xtto=;
  b=VQBMApEdyZuRGEvShgjRGdPiPTjLJE7E3Qe9HwhaHyXAVPOC6sb9iAF1
   UuhygWQoBv70ui6SSfOSxkYHSXlOvc8IYQMC7gOJXXhicow1eh7o675Tz
   yeUrNq0L+BOnAfXbd7HCCK7cn4PC16aT7ustxD683Z1hN2ArRVg6mIWlN
   OR5DH8ivc6w72FZlFgFlWTDQO0j44lyYju6E0zFhdHoYTlfFUsUjuTb7r
   o+Gee9oDiEgtcG/85V7AsyKMDYiTqPlWLA7DNNmapNHE36b1mLb1xxEk9
   ESat2/DNS0i1GGVeyOnjQH0A18KSLk67MN1rJ8+guAZ2jePtldBH2tuVa
   A==;
X-CSE-ConnectionGUID: +x43StMGTe+nt872wg0hQg==
X-CSE-MsgGUID: wb7e+HfMS9mOzzV/5eYhFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74983357"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74983357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:59:58 -0700
X-CSE-ConnectionGUID: qkeYTHrGQ+25iEZ0pO37Wg==
X-CSE-MsgGUID: ftuUbGv8RnOtYRbINWfixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218594622"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:59:52 -0700
From: Kai Huang <kai.huang@intel.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	arnd@arndb.de
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH] asm-generic/bitops: Fix a comment typo in instrumented-atomic.h
Date: Fri, 20 Mar 2026 20:59:38 +1300
Message-ID: <20260320075938.289189-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment after the '#endif' at the end of the instrumented-atomic.h
is a typo.  The "NON_ATOMIC" part should be "ATOMIC".  Fix it.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 include/asm-generic/bitops/instrumented-atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 4225a8ca9c1a..c010d54275e4 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -100,4 +100,4 @@ static __always_inline bool test_and_change_bit(long nr, volatile unsigned long
 	return arch_test_and_change_bit(nr, addr);
 }
 
-#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H */

base-commit: 0e4f8f1a3d081e834be5fd0a62bdb2554fadd307
-- 
2.53.0

