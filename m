Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88012F9DA1;
	Thu, 18 Jun 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795029; cv=none; b=pLz4drxwcdCrPbTjbl6l6vt8syfdPhe6daOcc0e92o9U6Ws8LOefUw/nvdPfN9XwAqbdwnDCA/Mn1tHU4EQ6h4J+A0uIArnK7nMjS/B4n9MeAegdawScATcGOyOlP52tSTse109Lwa0rC+y2DHhO/lCyAavd2vY4V4UrMCO0A7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795029; c=relaxed/simple;
	bh=APeMQH5xEJCrl02dISFMU5+v7f13IW3k5C2NhCb4cMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqR1k3nSR92OGzoAbsnZ+bUcKYB+ky7Wci+NFlPiRL5l7TN0acdDBoBZQsL7uqOTnPU8wIyMAKJv8kairT3e5KEoHzkwcLev4eBhbJOMzMHAYgDyBgRSk9xaYr4dHcYgmFnMySjAjWY9ct0Sb/WHFB555R9DywGWWQXNYh2w+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j7iQMN9J; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j7iQMN9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OW
	Nf8yNj4gcBNSfOXMcAvRS4ar1KbFJjyp7/7sfOE6U=; b=j7iQMN9JDovbYtKwl0
	+bcqoU+f1McJ5eXlcVk+Ynkme9uM3k2WL5hfXSS6G28jew6YC2uw2jWaqCebCsqs
	JESYcDdmYomc2jUgyqEEyI5GH0vOjXB7ubEhPipphIjU+GJms5OPP6eNjn70KU9T
	aLe65JDy4GBZeNefPjwm35i5Q=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDH8WamCDRqY3cICg--.20323S2;
	Thu, 18 Jun 2026 23:03:04 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	ebiederm@xmission.com,
	keescook@chromium.org,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v2] coredump: exit_files() in coredump_wait() if MMF_DUMP_MAPPED_SHARED is not set
Date: Thu, 18 Jun 2026 23:03:01 +0800
Message-Id: <20260618150301.3226517-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDH8WamCDRqY3cICg--.20323S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Zr1fXFyUKr1DurWrAFb_yoW8Jw4fpa
	1kGa4IkF1jkay2yF4xJ3WfAr1rXw45Jry7ur1Iqw43AF43Aas3AFn0q3W3twnrXrWvkFsa
	y3W5t3yDCFy2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRZXorUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwrT3Wo0CKoJrQAA3j

A coredump typically takes some time to complete. If we happen to hold a
write lock with flock just before triggering the coredump, that write lock
will not be released during the entire coredump process. As a result,
other processes attempting to acquire the same write lock may experience
significant delays.

To address this, call exit_files() in the end of coredump_wait(), if
MMF_DUMP_MAPPED_SHARED is not set.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---

Change in v2:
- Get rid of the implement of adding new fcntl API, the issue does not
  worth inflicting the cost on everyone,
  as suggested by Al Viro.
- Call exit_files() in coredump_wait(),
  as suggested by Eric W. Biederman.
  Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
  need to dump file-backed shared memory.

v1:
- Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
---
 fs/coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f4..e20baf44f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -548,6 +548,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 		}
 	}
 
+	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
+		exit_files(tsk);
+
 	return core_waiters;
 }
 
-- 
2.34.1

