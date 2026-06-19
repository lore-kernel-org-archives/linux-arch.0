Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863A1E98EF;
	Fri, 19 Jun 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871938; cv=none; b=FirOz/WKVgczjZTtjdg8S6OwhB0UlTnaUUp5Ld8jVpCbumN6YK6cG60ZBt3Rq2raeHa8zE4LieDXEWcmmHXxN3xe/MBIL7+7X0OpL6YvTU4PelMYO5xpF4xiA8Bbtz9/PyepowqF3UzR8zN3neUAwu+Ec2heSgkAd3l1SJapknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871938; c=relaxed/simple;
	bh=ed0uN7i1eEjaMsLqpmegENrI+R0FiaVCazj78TebJTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tr4kBATw6K00tJyIDGvbEtuOkTHiDOQyCzTZlS5zJ4RiK5eI4D5QVCu8GI3ZnrRvRtlAQM9vBEwp89H9F/Sx6xy87FWTPK5Ndl8sdRxbYHNypyxJWvSTvoruKE+bKyJhQyhW5KQcWT402CHW7+VdQNVZXE3inI1c4z2Bp8/aOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e17kKzQa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e17kKzQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IV
	7FTXAAktNTIOVliYO4ZBZ3CTZVDDl4HyRkFvIav7M=; b=e17kKzQaYqXGOfK/t3
	ErMO0NL7h4NEFHBNqabvf99qh98U/vsb9ZjwR8LcLedbeZng46z9G5Tm3UH0EkV8
	mIoI4GnWY2o6XqP6jfv32Jh8omVVbSwSDzQVYIakmeEh7wClH3UFnRqKVfQCWht+
	n/f75QnxTh2fsutt9Pevc26aY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCH7rH1NDVqnm0eDA--.53549S2;
	Fri, 19 Jun 2026 20:24:22 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: pfalcato@suse.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	keescook@chromium.org,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v3] coredump: exit_files() in coredump_wait() if MMF_DUMP_MAPPED_SHARED is not set
Date: Fri, 19 Jun 2026 20:24:19 +0800
Message-Id: <20260619122419.3954581-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCH7rH1NDVqnm0eDA--.53549S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Zr1fXFyUKr1DtF13Jwb_yoW8ur1rpa
	ykWa92k3W5KFy7tFWxAF1fZr1rZw45Jry7uryIqr43AF45ZFyxAFsxta4fXrn7J39aka93
	JFy3t3yDC347tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi2Xd8UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxgzPWo1NPgyCgAA3C

A coredump typically takes some time to complete. If we happen to hold a
write lock with flock just before triggering the coredump, that write lock
will not be released during the entire coredump process. As a result,
other processes attempting to acquire the same write lock may experience
significant delays.

To address this, call exit_files() in the end of coredump_wait(), if
MMF_DUMP_MAPPED_SHARED is not set. Note that early unlocking a flock on a
file allows other processes to lock and modify the mapped data protected
by the flock.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---

Change in v3:
- Add comment and commit-log to explain why do the MMF_DUMP_MAPPED_SHARED
  mm_flags_test() check, note that memory mapped files keep their own
  separate references to the files. The case to work around is that early
  unlocking a flock on a file allows other processes to lock and modify
  the mapped data protected by the flock,
  as suggested by Pedro Falcato.

Change in v2:
- Get rid of the implement of adding new fcntl API, the issue does not
  worth inflicting the cost on everyone,
  as suggested by Al Viro.
- Call exit_files() in coredump_wait(),
  as suggested by Eric W. Biederman.
  Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
  need to dump file-backed shared memory.
- Link to v2: https://lore.kernel.org/lkml/20260618150301.3226517-1-jackzxcui1989@163.com/

v1:
- Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
---
 fs/coredump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f4..70698d06e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -548,6 +548,13 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 		}
 	}
 
+	/*
+	 * Early unlocking a flock on a file allows other processes
+	 * to lock and modify the mapped data protected by the flock.
+	 */
+	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
+		exit_files(tsk);
+
 	return core_waiters;
 }
 
-- 
2.34.1

