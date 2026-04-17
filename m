Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E913AE6EB;
	Fri, 17 Apr 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418042; cv=none; b=VMbMWqcZIx25ZifiDdx9CGEvSmn55k2II+AFvXoa+675z3ouJPX6Zs2Uyv4LSMQM1qrWH/BMRlLjTjF4dVFJ1Op13EVImukqRcDbwdXpmYQUkbTGKvuC4zk08+FtnvYp+hObhu/6mBE23erizk0VnRRmIXuv2b0mVrXTzfR5gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418042; c=relaxed/simple;
	bh=/GZ1eJ+ljLg3ct7J0IVsFZ9WNgRtvQBIg+Mj9cxw8jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDtu3pMyB30S2Kom7CswRNa6DaMatEdVIGEl3riw/tjQqrCQcMaOa4FGz+3uHnFeA0VpvORRYpz052FRuBtDuhrHUOa0Avjz/8uyPYC5Vjta6iHIugb0Ji20KIGWKZc5EoK4Jmxr4+ZNUpSsAigKDDJFB+2EE0mixNcRIAJQOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I1e6q0Cw; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I1e6q0Cw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EtIc7q3V6qNXESO1LHnLl1hUghAJRlwCvg1Ur/lCRC8=;
	b=I1e6q0Cwtg9FNqISTXXmYiYoyVEfqrktA60qhkps+zKka7CV4QpM+YavzTYpQkafllKzSB+Ye
	cxX32++4Im0VoYmnOmdDWVOM1ungHosFl2LKji1yo7qk77AmYmJfY3OwgncHrao+L73nyNwxbZj
	+jT44jOi5k4ZJSufk01TrlI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fxq9k69yfzcbN4;
	Fri, 17 Apr 2026 17:20:42 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9962940561;
	Fri, 17 Apr 2026 17:27:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 17:27:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <ruanjinjie@huawei.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <david.laight.linux@gmail.com>,
	<nathan@kernel.org>
Subject: [PATCH v3 0/2] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Fri, 17 Apr 2026 17:31:00 +0800
Message-ID: <20260417093102.3812978-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Add bitrev.h file to support rev8 and brev8 for riscv.

Tested functionally on riscv64 QEMU with:
	"-M virt,acpi=on,zbkb=true,zbb=true"

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

 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/bitrev.h       | 55 +++++++++++++++++++++++++++
 include/asm-generic/bitops/__bitrev.h | 22 +++++++++++
 include/linux/bitrev.h                | 20 ++--------
 lib/bitrev.c                          |  3 --
 5 files changed, 82 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/include/asm/bitrev.h
 create mode 100644 include/asm-generic/bitops/__bitrev.h

-- 
2.34.1

