Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EC23B61B;
	Thu,  2 Jul 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959969; cv=none; b=IajMCWa641drJ/gunRlQOpbIWh/3E32c19cpH3yOeO1YsLvyqyoXVY5kf1Pcq8zBERJnvpRV+wRty9BwaP8+PrQtXCt1ya4+iX107W2qi4Owhqbz8UO/BHKoZPXm2gv1ir5wZU8dy9CL459nTOw037lYlehVynCu2JI9FBWYgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959969; c=relaxed/simple;
	bh=rwRg529y05peA/WWTMCXEBfX3q0s9gAsSrO8arvTDhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA9KLzaOzwq9Hl1CWtxFNJQWf9SfYemEV4Awh/m44k9MKcEcMxSh1Xt9YtGm/9yUgkkNKjzNJRiIqI0k4WPYQ0pCn2OVUwa2pyDPCd7A5zy3aEktXoqz4jfpdYS6EkcbfjliCzArhr0gYXaPPw7FHYiFOOuSackF6YWlGGQoqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dQvqA7qi; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dQvqA7qi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L/
	SZp0vPqZ6bgIHdMlwc9563CUsJkyQzIo7rI6wG1fs=; b=dQvqA7qinCQMnbXwe1
	493Ms+eGeG5sCYDYcqfv8w+gsgKEJRfB/Ks41En2pt8rx7TwLhxi1cQ+bQ29wXCQ
	0a47KSfcrKTpsl09WD4SnAJoUy5DmBLuG03dhKONkrv/9K4+nHbsqyxMC323MMj7
	Hb2KN6px84/XLvT4/YKEqVe6I=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnr2i3zkVqTx3MCA--.26814S3;
	Thu, 02 Jul 2026 10:36:47 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH 1/2] error-injection: Introduce EI_ETYPE_FALSE for fail_function
Date: Thu,  2 Jul 2026 10:36:37 +0800
Message-ID: <20260702023638.8165-2-chensong_2000@126.com>
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
X-CM-TRANSID:PykvCgDnr2i3zkVqTx3MCA--.26814S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr4DJw4kKF1xCrWkZFW8JFb_yoW8JF1DpF
	1q9r9rury8K348Cry8AFZ2yr1F9rsrGrZxKasxWws7Zw17tF4kt39FgrWUXrykGrW8uayj
	va9rWFZ0yr45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ub6pPUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpR-OTmpFzr-wtQAA3h

Introduce EI_ETYPE_FALSE for functions which need false as return
value in their error-injections, like btrfs_data_csum_ok.

EI_ETYPE_NULL can return 0 too but its readability is not good
enough.

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 include/asm-generic/error-injection.h | 1 +
 kernel/fail_function.c                | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa..6c399121ab7a 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -8,6 +8,7 @@ enum {
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
 	EI_ETYPE_TRUE,		/* Return true if failure */
+	EI_ETYPE_FALSE,		/* Return false if failure */
 };
 
 struct error_injection_entry {
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 2eaf55005f49..90cdad0412cd 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -48,6 +48,8 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
 		break;
 	case EI_ETYPE_TRUE:
 		return 1;
+	case EI_ETYPE_FALSE:
+		return 0;
 	}
 
 	return retv;
-- 
2.43.0

