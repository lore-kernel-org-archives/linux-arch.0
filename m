Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94223D6691;
	Tue, 21 Apr 2026 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776656; cv=none; b=f2Ew5L43okX91aMc/6zZkfzwKEAK/nmW40wfClg9feTRHJfHtlud+qijA3FWB4tJJ0SqqvmYJz8RaH7GWyW3Ri07FxR5063KMrt+Xu8S9EHuox0DgNcx37hmRrMKaiRYpryD1mlb5UQdEDTs1025VUmv1RfA4NWa7da+pPsRXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776656; c=relaxed/simple;
	bh=GRSVMDxq/lPQeAJ/QJN9ueODiDq2JJqCz1XhMZ2gVVg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toegpbXFcAhndwntwUfK+TgCI2yVl5Wn0HNKsLlv0AfZQfXx0EB1+kqH8g45jPs4Z3I03pkVQ3a2qH27ZkkV6xEyjX2BqJMXF9BmfGrLcsASGHEUV5/1hoOcnNq60UbN8Myj077m+xljAN6ASsfmXgMc8gY81pvUYFLNOby3N2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q7Sn0/ol; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q7Sn0/ol"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3Wt4gXH4m4VxYG6Xv0sQjCP7dpdPAwm1RXVyZ7lfv4M=;
	b=Q7Sn0/olTzgL+cfjml101/4jnirmE1O3oT+4uwS6gIPA9lUVIMrlLDh4ssHVZVityUS7JQFOW
	MCSTvoT2zuzABZTM8mMaM796qJv4nxJ/uRmPJbQsr7wQAQDwxExAB/xamg6Mx8lmJeQ8gLut+18
	KMznJM2h0dN6cMfiSt+U5iI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g0MpW4jLDz1T4Hv;
	Tue, 21 Apr 2026 20:57:55 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 004A3201E9;
	Tue, 21 Apr 2026 21:04:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Apr
 2026 21:04:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v5 0/3] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Tue, 21 Apr 2026 21:07:49 +0800
Message-ID: <20260421130752.607500-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Add bitrev.h file to support rev8 and brev8 for riscv.

Tested functionally on riscv64 QEMU with:
	"-M virt,acpi=on,zbkb=true,zbb=true"

Changes in v5:
- Rename NEED_BYTE_REV_TABLE to GENERIC_BITREVERSE.
- Add help text and make GENERIC_BITREVERSE depends on BITREVERSE, and
  use def_bool.
- Split into three patches.
- Add suggested-by.

Changes in v4:
- Update the riscv implementation as David suggested.
- Add new config called NEED_BYTE_REV_TABLE as David suggested to avoid
  bloating the .data section for architectures that have full hardware
  bit-reverse support and don't need the table.

Changes in v3:
- Fix the build issue by remving the CONFIG_HAVE_ARCH_BITREVERSE macro
  for byte_rev_table.
- Update the riscv implementation as David suggested.
- Add Reviwed-by.

Changes in v2:
- Define generic __bitrev8/16/32 for reuse in riscv.

Jinjie Ruan (3):
  lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
  bitops: Define generic __bitrev8/16/32 for reuse
  arch/riscv: Add bitrev.h file to support rev8 and brev8

 arch/riscv/Kconfig                    |  2 ++
 arch/riscv/include/asm/bitrev.h       | 51 +++++++++++++++++++++++++++
 include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++
 include/linux/bitrev.h                | 20 +++--------
 lib/Kconfig                           | 18 ++++++++++
 lib/bitrev.c                          |  4 +--
 6 files changed, 102 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/include/asm/bitrev.h
 create mode 100644 include/asm-generic/bitops/__bitrev.h

-- 
2.34.1

