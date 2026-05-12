Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817D3CC7E3;
	Tue, 12 May 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603224; cv=none; b=ibQwdHFdCe9GWIPW5ajHxQHz98hbYTLVgGDJktg6Ba9FwFUfehmwbxwCkPjaouMz7oR3xtuB1/B969T7heZWxxiArihBYTXgIu1e9oTWpUpPTRcBV//l+e2IuFK071Ty+bLdi1hC06UuYRbxcpa0yktFq8eiMwoAazqJdZxZ2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603224; c=relaxed/simple;
	bh=uJvEMd3+CFQDgFue9mq8gmkIH461XMtPWMnIsYpJfSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzQoMIh1JdoJfSxKBkZiN+ShK6bXcKSJQ1MdqxDsBrQ2h1UILBBfwmHj3WsDPe4dsXDVutrvIKvGoJFYySWku9xSTKUEWKtX8cu4bDhH66aO4Od0I02e2g2OmpQSq62fHpj7Th4i3RWmziN/yBpvM3DJ7ExTRC/GKcTrZSvIAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gFMRx3mj1zHnGdH;
	Wed, 13 May 2026 00:26:53 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id A5D4E4058E;
	Wed, 13 May 2026 00:27:01 +0800 (CST)
Received: from localhost.localdomain (10.123.66.205) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 19:27:01 +0300
From: Fedorov Nikita <fedorov.nikita@h-partners.com>
To: <1234567weewee457@gmail.com>
CC: <fedorov.nikita@h-partners.com>, <stepanov.anatoly@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<virtualization@lists.linux.dev>
Subject: [PATCH v3] locking/hqlock_core: restore missing call in contention detection logic
Date: Wed, 13 May 2026 00:25:03 +0800
Message-ID: <20260512162503.1843025-2-fedorov.nikita@h-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512162503.1843025-1-fedorov.nikita@h-partners.com>
References: <20260512144908.610907-1-1234567weewee457@gmail.com>
 <20260512162503.1843025-1-fedorov.nikita@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

A call was accidentally dropped while splitting the hqspinlock patch series.
It did not break the system functionality,
but caused the lock to stay in QSPINLOCK mode.

Restore the missing call.

Sorry for missing this in the previous posting. I rechecked the whole path after fixing.

Signed-off-by: Nikita Fedorov <fedorov.nikita@h-partners.com>
---
 kernel/locking/hqlock_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/hqlock_core.h b/kernel/locking/hqlock_core.h
index 74f92ac3d8ad..226a0bb9a667 100644
--- a/kernel/locking/hqlock_core.h
+++ b/kernel/locking/hqlock_core.h
@@ -580,6 +580,8 @@ static inline void hqlock_clear_tail_handoff(struct qspinlock *lock, u32 val,
 
 		hqlock_handoff(lock, node, next, tail, handoff_info);
 	} else {
+		update_counters_qspinlock(qnode);
+
 		if ((val & _Q_TAIL_MASK) == tail) {
 			if (low_contention_try_clear_tail(lock, val, node))
 				return;
-- 
2.34.1

