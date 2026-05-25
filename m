Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA614E2F2
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714424; cv=none; b=lTLMCWUD4fFyOyXl12SNmTUCiUwiQH5c03wNFhv+pZM7D7qKosSFuxN+loLpCBJMxxC/cJ21YEMVUd58wcrHTlwpGlNS80oE5t6v42FPmMaKHRCmP9hnJj7yWhgLC6G7QW7mlCtdFclhWJ94u+0Nrrp6yQMnXFMVBfTFG6bz6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714424; c=relaxed/simple;
	bh=8zGagWSJMx0s2KNlByt4w+wFeH+942Vp1v2W6vlrFCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLuyyAYXhBaN4tUGaLZZvxf1RNa5x8pt7vn3/CS5a4onm41OtFQQvrrCqzWF2N+NSmgMdcg+pLynJCIrl/bRORhxrJMPrlAnR+5fcHqyrS/DcVPmQJVRRkz07q2zvwnFL2Om9LWnf4+WE2DB1z/yLJlY/3jR0JGm8aVgl3RUl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi/NyxIG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi/NyxIG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bab82d75fdso47589885ad.2
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779714423; x=1780319223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoOg9JfgXq9ByleBW2o6gzfTbj4C0gQx9Ye/j1VCDx0=;
        b=Hi/NyxIGwvshOGF3IO3jAjnVaV3EWz1kJECX+w1/0pjm1xf0mALUneC2k2KpvqAdTa
         dTjzLHFYiNC3moBrL0829ndr7mKLhkcBonmFjOtYrrtkLhjp3X9QrKFl3YBm0VKcBkDP
         7L+ZkGQGpqd4I60VUO8MaEW9H/6Qg6ZuMCGnIwpfvRlAYlkMT7sjurNPvx/F27opYr7D
         Z107H/kNRfQc6hOIjXITqVrDPJbREIoC/YOCg1Am0sfWWHVeQj0XHLBR9pbj1Frs9Hwg
         Pe4isa2mWb8u89jWMSa0lWfyHtjlK02CAEfnu6o+qv3fw/JXRQY6Si5AaQFEmmO/b5b+
         suxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714423; x=1780319223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoOg9JfgXq9ByleBW2o6gzfTbj4C0gQx9Ye/j1VCDx0=;
        b=jvYHf0a7AaOMFQNQmCvWHydfFM2Q4V6RC64YpoTxCMYbzy8JQMHkbxG80Og0n68bcX
         IDCODw3fU0QZZ9WUa1QW7AwRooQ3q4votKA3ts+uI4c0AWFhm3ML2YJ+bjkanQgFX7ua
         0DM2yEXff0YFncsDVVl2FdmeHK+lOVB1//UlIqmdpdfBP+en7g1yIUEaLbL862QUEDXD
         BkvzIjAi5WcsaVsgJgfKLdTz1cM8lxaJbSRm/8OAQVdXi8pnx4epjWrrtBCtvYjz9eDE
         NvfI7+E32QL259GdwavI6ug5tRbGkq3pgSCce6ntYKlGo3uK+yamwOAJJ5jI2pqOIPgG
         m3iA==
X-Forwarded-Encrypted: i=1; AFNElJ/sgivDScJj79uWJtZ3yR9ukysV0pR7Jw4ZBz9GrDoe9aF3VIqqU+pP0LJuxzPkSTpXsGj3BV/txYin@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOlREYkw3QkZlfmABoQhj/2PcId2aDJpEYPb6YhNAYGeKT82P
	q/LZjR7G+6ce/FuruRJ3GiYTc5xrIu34kmp2q8yQpB/5aBqQXNYWGKPV
X-Gm-Gg: Acq92OGcmvM5msTY/uSU54B8YoE6MHzmJ+R+kD5wzS4knHWp+WW5jO1Ea6ipjNzUiKT
	BzadIxbWttV99IzVIUHf4s85x/wPUI25PYBnHKWT2m9yy1bu1hlgJPeMBqqnZ0mMYFgKFURmwUh
	tz22XdqJYoS8kV2ZSpk2S8MsOe4nLxKVEbaRnN4gA7jl186kfbF/dlh1AWRZ4xhLbQc6SVeEmmm
	5/DPj/fGYSHFIXh2bWYnspxSlLHzF9xsfYKSqlJp5MvfYU73O4YLYsbKTwm+X05FQf5D+yJ9WXH
	G4aWs1eQ/H+e+OKhghnKEeQbgD+xPy7BtTSnrZpon4ivqQ18GbCZ4k1wjO4FQHUhRUEzI6C+4mi
	LxmsYXZFVra/2Ee5zZr6G5Blad55tpAzyHs5GOaootHUzDOPKSRsxYOKw0OZt2NvoVFnavVKVGC
	4i/dK8V4pGGz2t3zzd238eGzlVCTE6sXIjiPTWFr/ZwM2SBLcx
X-Received: by 2002:a17:902:fc86:b0:2b9:ea53:4cfc with SMTP id d9443c01a7336-2beb07b7847mr161177895ad.19.1779714422740;
        Mon, 25 May 2026 06:07:02 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9ce4sm92823055ad.64.2026.05.25.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:07:02 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheng-Han Wu <hank20010209@gmail.com>,
	"WEI-HONG, YE" <1234567weewee457@gmail.com>
Subject: [PATCH] locking/qspinlock: Clarify pending field layout
Date: Mon, 25 May 2026 13:04:50 +0000
Message-ID: <20260525130450.723937-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For CONFIG_NR_CPUS < 16K, _Q_PENDING_BITS is 8 and the pending
field occupies bits 8-15 of the lock word. The current comment
documents bit 8 as pending and bits 9-15 as unused, which describes
the pending flag value rather than the field layout.

Describe bits 8-15 as the pending byte so the layout description
is consistent with the lock byte.

Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
---
 include/asm-generic/qspinlock_types.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 2fd1fb89ec36..7d17b9bb069c 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -53,8 +53,7 @@ typedef struct qspinlock {
  *
  * When NR_CPUS < 16K
  *  0- 7: locked byte
- *     8: pending
- *  9-15: not used
+ *  8-15: pending byte
  * 16-17: tail index
  * 18-31: tail cpu (+1)
  *
-- 
2.48.1

