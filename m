Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F018D636;
	Thu,  2 Jul 2026 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959970; cv=none; b=FT52Zb+hYSwAUiRKAxveBJ36W3e0HGTCbbz4qydjsIDtMs7xnkhITwP8fN4dhXXQ45gULdExUmMfuuh13OCclSlomQ8KWmCOf6BcQX8Of/mqY3PfpISSiWSbINb4rD/vJ31laY2xh3rzoPVATWj6f1Hf73CY0X3f7HBr2C8NTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959970; c=relaxed/simple;
	bh=5Yc36cFlRDeEt0w9k+afmK3vtvI3VFO93Rkf8PYmFPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmsskLpwcaF3M4mW8Wj6bjQhbMt+CtuAaTvbH3TUA1XXB8rLaX6toEeRfpAd2hTm0bze0WBux21LmaJmE1rS6t0ccgOnGSWPdWb8XG9Yp85wu/jlbCBs8/kIm0n8Jywkze/Qh/DQoBtSh2WHG4d5kmX5GWwaLuZjTMJldtZY3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nqVk4CgK; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nqVk4CgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fo
	SVsAG7FhEiHEqJg6LX4tAMVGZgYKYg/ODwQYy2tps=; b=nqVk4CgKlNAnE3H9yU
	6f1nDc6jbODqCwzEFesD7w67qZqNlIO+pr4fzKWwhTXT9hcf4joXHbHhifJAEQ++
	4SU01l7a1v8/XkTokrNNxpJsVkxw8veCiemcGagRCS4Kp/6d+57NNuukuj28I83m
	aVSxKw+Tdz2Kms9QjSQdL71q4=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnr2i3zkVqTx3MCA--.26814S2;
	Thu, 02 Jul 2026 10:36:41 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH 0/2] btrfs: add error injection support for checksum verification
Date: Thu,  2 Jul 2026 10:36:36 +0800
Message-ID: <20260702023638.8165-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDnr2i3zkVqTx3MCA--.26814S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4xGr47ArWkWr17WF4Uurg_yoW3Xwc_u3
	yvqayfXrW3Xa1UGF4xur4xtrZ3K34Ygryjv34rtr4ktFyavws0kw4qqr1Yvr4kWw42qFnI
	vrn8Cr13J343ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjMa0JUUUUU==
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxnNTWpFzrmglQAA3H

This patchset adds fault injection support for btrfs_data_csum_ok,
enabling controlled simulation of checksum mismatches to test btrfs
silent data corruption detection and reporting paths.

The first patch extends the error injection framework with a new type,
EI_ETYPE_FALSE, which allows bool-returning functions to be overridden
with a false return value directly.

The second patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION
using this new type.

Song Chen (2):
  error-injection: Introduce EI_ETYPE_FALSE for fail_function
  btrfs: Allow error injection on btrfs_data_csum_ok

 fs/btrfs/inode.c                      | 1 +
 include/asm-generic/error-injection.h | 1 +
 kernel/fail_function.c                | 2 ++
 3 files changed, 4 insertions(+)

-- 
2.43.0

