Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C172DEA7B;
	Thu,  2 Jul 2026 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959969; cv=none; b=SZ//5z5Q3Xmgq0K6UHjN83pV2F1tshqsxiyHNxORae/g20t5HBrTBdqH6ngjtCWjNY56316cTUTYKV2Wgi9hIbFxUwZxTvbO6v16wjGFdzbdmK3O1n6P9NGKcbWrgUmtedF88MI/PqreeAp+Q5MXfCpeE77qH6re+yi3zpTAeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959969; c=relaxed/simple;
	bh=C2IH9lN6ISt8C5qJl7zLutJbyLDuah7mmkj1ow/z4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsM3DP8SOaBurhMouv1fNPyhM9F+Z42/vcGGJ/QJWg5cIzXthg31F75o4uVHuQ87uxmRfbc2ST6g08KX5s/s+P/N/V5ZFvrGu4lQF8aikVgMGs/Y0BL3bcnr9hivMYRoaKwdRpZCsFIswwXBTupgqGRINcf75UWDxkc1Y31iGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hVV8VvlI; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hVV8VvlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R0
	fZk7cw47NM3PZyeQotTKEsd6zLI7x4WIDlkM2CwcM=; b=hVV8VvlIX1epoiqvLO
	rkcAEkdnahtoQfRJZnJ7ohfezWGinVoS27ZsW14hPEqmJ/OrKQFAyZMKlZqlSYhy
	cY8XgfbfXlqbX0JHF4SSeq1zantNsIBjY8/NodcKJxrAy6igppHdf/oLsSaKs1Iz
	wc3nO9jJf372+uINyC7oM7js4=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnr2i3zkVqTx3MCA--.26814S4;
	Thu, 02 Jul 2026 10:36:49 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH 2/2] btrfs: Allow error injection on btrfs_data_csum_ok
Date: Thu,  2 Jul 2026 10:36:38 +0800
Message-ID: <20260702023638.8165-3-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702023638.8165-1-chensong_2000@126.com>
References: <20260702023638.8165-1-chensong_2000@126.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDnr2i3zkVqTx3MCA--.26814S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWfZr4kWFykJw4xJFWrXwb_yoW8Xw4fpr
	WUGw1ruFWDXr97Wrs7Gay09ryFg3yDWa10gFnxZw4YywsIkw1FqrZay3WxGa48KrZrX343
	Z3Z0gw17ZF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8GYJUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBswHPT2pFzsGg7AAA3e

btrfs_data_csum_ok validates the checksum of a data block
after a read I/O completes. A mismatch between the on-disk
checksum and the one computed from the read data indicates
silent data corruption, which can be caused by bit flips due
to DRAM errors, storage media degradation, or bus transmission
faults.

Testing the error handling path that responds to such
corruption, including any warning output and uspace
notification, normally requires reproducing the hardware
fault, which is not always feasible.

Mark btrfs_data_csum_ok with ALLOW_ERROR_INJECTION so that
the fail_function infrastructure can override its return value
to false, simulating a checksum mismatch without requiring
actual data corruption. This enables validation of the full
error detection and reporting path in a controlled environment.

Usage:
        cd /sys/kernel/debug/fail_function
        echo btrfs_data_csum_ok > inject
        echo 0 > btrfs_data_csum_ok/retval
        echo 100 > probability
        echo N > times

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 906d5c21ebc4..6be3e920b954 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3574,6 +3574,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
 	return false;
 }
+ALLOW_ERROR_INJECTION(btrfs_data_csum_ok, FALSE);
 
 /*
  * Perform a delayed iput on @inode.
-- 
2.43.0

