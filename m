Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFB35898;
	Mon, 20 Apr 2026 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690541; cv=none; b=tIXdB3OpH3qjl0e3mplHjn4xKAlGofwJVotpsesbPsTNjHn/uPQYgOM5cT8yKXOuSTHqes4BGRNmVFKChxPYQwTsHG//+SXY8PHFjQlRIUYiXnC7GAVT++W/g7xUWKXE4in8s1QrnUZVAfjjCef/BY1sNwc+pdjDW179uBeehwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690541; c=relaxed/simple;
	bh=snrEPAbPuufICinKwMHfYvvZyDmgNhlZVANFNeYB5Zo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gtbg41/H4QDv0RZPy9Dw1epOnOiYVlLabZ18flDjRWEN20C4XXoPcrKYS6SFOrDkrwbQFXBr3LYmlc/bP0lyF40DLEOgBF1UDm70Id6rMEorIpQvSY2/hd8nylrPE8kSUoFzLZno9lRq8Kty+Sc5l6zSN79s1y+AwBPx9Lxjiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SHsvD0qe; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SHsvD0qe"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GEFGIAcBK6jfrRgMqwmCZQZvh/pfo3Q1T0NyKQWEBd0=;
	b=SHsvD0qe9rAdeDQkIW7JFjRHivOcFJ74ayrpFrDhlJASAC3EQzbKMS6Awtz3rWbFkQlR/JQlL
	xk26HsG6xjH6+gQ2cFNV3LVyZPG3OCO1mXwnX9SV95pRVK/CXj7mX8gseSEFfCG7HbNVbha/Dsa
	Gzz9bOZSZANW1cgIZ01aWmg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fzlyJ34WpzRhR4;
	Mon, 20 Apr 2026 21:02:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E288D40537;
	Mon, 20 Apr 2026 21:08:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Apr
 2026 21:08:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>, <cp0613@linux.alibaba.com>
Subject: [PATCH v4 0/2] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Mon, 20 Apr 2026 21:12:50 +0800
Message-ID: <20260420131252.179729-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Add bitrev.h file to support rev8 and brev8 for riscv.

Tested functionally on riscv64 QEMU with:
	"-M virt,acpi=on,zbkb=true,zbb=true"

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

Jinjie Ruan (2):
  bitops: Define generic __bitrev8/16/32 for reuse
  arch/riscv: Add bitrev.h file to support rev8 and brev8

 arch/riscv/Kconfig                    |  2 ++
 arch/riscv/include/asm/bitrev.h       | 51 +++++++++++++++++++++++++++
 include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++
 include/linux/bitrev.h                | 20 +++--------
 lib/Kconfig                           |  4 +++
 lib/bitrev.c                          |  4 +--
 6 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/include/asm/bitrev.h
 create mode 100644 include/asm-generic/bitops/__bitrev.h

-- 
2.34.1

