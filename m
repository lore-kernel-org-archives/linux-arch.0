Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5223372C;
	Wed, 15 Apr 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245699; cv=none; b=aOMQby5DhGtqPb3z1ZDC+6jmHby140JTlXr/MjF9aWQSwTOx2+H6TKHHec3n5cHBumEaJgL3C/3+ompjINLyisbriT3YJDtmQ24PZO9PnedlBYlhdo3i/yVKNbO3nSlWv5NlZhi4Vg6ZWxhIxryjXozS8mzx0FpXwXIDARMOEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245699; c=relaxed/simple;
	bh=HGb6eYQnH7HckRUAFofykFX5yLZUaS1+gjCDO4Dmt4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+9Xdcy4oHNqzFkmQk2VkyilmBQDno2i7ANkfAkdT6k50Ycb1QDNi54jywo2NYG1riBiMXTmE83P3FSKzKcfSb369gBYFsAVW+RCEP8WeYwV0WgFfCBkJD33GaTO/Cw6r9MYb2N/GbIx041Wtd4Xtgxdq0MQAEXeBoT7ilUGR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fL6P+7av; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fL6P+7av"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YQ0HES9M608BC3CtTS0uLReOlu+ttpsb3HMn3ebyh0g=;
	b=fL6P+7avLF9Gwlf76dJA0YWKk8yY3fXXLnJaFWRPaQCWD74J7xF7JJxu0ZzT+3pHEG0lZxZx9
	+k7BiB4EO5QUk8v7twbew8WykqNIYnJ+q6vyyJYZOy5ZPgU/XwGITuwAiVmcbO8SL6w3Wtfyz23
	ZF4byK4pfmq6gBtfalGXt/I=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fwbRl5lsSzLlSv;
	Wed, 15 Apr 2026 17:28:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6387740565;
	Wed, 15 Apr 2026 17:34:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Apr
 2026 17:34:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <cp0613@linux.alibaba.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 0/2] arch/riscv: Add bitrev.h file to support rev8 and brev8
Date: Wed, 15 Apr 2026 17:38:25 +0800
Message-ID: <20260415093827.2776328-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Add bitrev.h file to support rev8 and brev8 for riscv.

Changes in v2:
- Define generic __bitrev8/16/32 for reuse in riscv.

Jinjie Ruan (2):
  bitops: Define generic __bitrev8/16/32 for reuse
  arch/riscv: Add bitrev.h file to support rev8 and brev8

 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/bitrev.h       | 41 +++++++++++++++++++++++++++
 include/asm-generic/bitops/__bitrev.h | 22 ++++++++++++++
 include/linux/bitrev.h                | 20 +++----------
 4 files changed, 68 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/bitrev.h
 create mode 100644 include/asm-generic/bitops/__bitrev.h

-- 
2.34.1

