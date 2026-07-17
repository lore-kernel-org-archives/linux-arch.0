Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57710F0;
	Fri, 17 Jul 2026 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324027; cv=none; b=Z5BnSYUw9AS/vd23EcHI+qNCuaPHxJyuhb3GAQqCrMgBoxaY4YqpIza27VdGAQgDGumX8xw9nd7sMAiE7FqcaDmKqRxN8fsxqr1iq8MxJZGPFCCHVIh1fhxPqaY2r9p+Se0o3GBUIy/r6Y4R4/lGMmvDaH82S68DQeO/7pM7hPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324027; c=relaxed/simple;
	bh=Diuy9lnGl99FROkwy4eBrn7DSjl4z6rN59TI3H4EXW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/9EbW5EP2lcBRSRKS06oyy1+PVKFxlEc2C5GWBI3kNkcgXS/5aHa/Y5Ti0cPLIx5W+Fw20isltekEtVOQZAekcW9eCF7MjFQzY/LQPDpMR2qhnQES3xjsWuQ8wh5nvg47YiXasGzfoift6CVqj8RtkIVCL6jbstzZ8GGYODLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/K7sVXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/K7sVXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7583B1F000E9;
	Fri, 17 Jul 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784324025;
	bh=5pFCIT4SNwJq0lXNXSiPb7aTP435Cfu/ZjktQHShKLM=;
	h=From:To:Cc:Subject:Date;
	b=D/K7sVXhBc59xquZXDMKGwBeKv6FrkYIodbLj1iUEz1NKtf69yRoDXTBzJ9Y+ZTcY
	 aGWB2EBUKNnxeniVhT30ykgHaZUCHJzESfHUyWYParABd5y9djnVkiygNO3DvcPnNz
	 8subYepgKLz9kBXV5FruejBVkQ9Pfai8GaQKoEssCsdX54/pIl3RAThV80qeyx2tQo
	 KvRffD0aquZzioQwk3uKSoCE/gqZkh4CH3SE/Zmvtx4/qPBgwpaOB4M/jmbMHJwZEg
	 FdGYzu2cisCROLbnk4pa0XNOYk4XszUQzQ7BE5wxAxCh4HST8nqz2zCEJE+qEcwxMl
	 R/Coy3XT4vdLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linux-mm@kvack.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] percpu: Add missing DECLARE_PER_CPU_DECRYPTED
Date: Fri, 17 Jul 2026 14:33:43 -0700
Message-ID: <20260717213343.200497-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
introduced the DECLARE_ macro as well but it's not defined when
CONFIG_AMD_MEM_ENCRYPT=n.  Let's add it.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/percpu-defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 43c854a273c3aa4c..649f31e34e810eb9 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -184,6 +184,8 @@
 #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
 #else
+#define DECLARE_PER_CPU_DECRYPTED(type, name)	DECLARE_PER_CPU(type, name)
+
 #define DEFINE_PER_CPU_DECRYPTED(type, name)	DEFINE_PER_CPU(type, name)
 #endif
 
-- 
2.55.0.229.g6434b31f56-goog

