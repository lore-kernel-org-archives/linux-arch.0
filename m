Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.178.41.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395686;
	b=CqEkuEZnK9h9zxnG+5PEn80fAYRwGCPWiPVa2uP8A3EBgphMnqmQYoW3++R0HeDgrUYf
	 sSEpkZXXMO/oGt8pQ+CWXpwq4FZd/7m3TzE2MDTI5kP7Z3Kvj7/DrlqjQNfqWIyUJAWQi
	 Ad4OSQfcmOLcqC8CI4Hbr++W+nkfFgAcZ++Ivp+9xeZU8hNBVizxdH1em9OQxoJxLmfXH
	 xMEdzzUuaqNsVxxPujqwdRgvE1xENx4JRABLsyzjQTC9zp+iCSUCSqPFdWgCg3UQMK/LN
	 Xz3vBkugTqrhbgluOHbMMmpV4KmqWmUXpRXtigU6chZ/hWxgnMWxzB4qX7ABXjVscgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395686;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IUS094t/EG0Nqjx5FbPVKURk9CJm5VD7S7UnCo9K22s=;
	b=yUdktr97cH8V30SvukJ4JYMym5gkZ/YEpBcqt+rhQ0l3ADQ8h0INCGPhfVp45kTzmTNz
	 F85mwwWwG2vh3W8efPN1Q8uRE7MH0f9hKytwp8kPIANYCp7ktstTiW6D1fj+P7yiZl9Fh
	 vqNnP3BGArDxLHH7/HRNz8bjSVL4UjnQRsXarr37dX0ODY/1oKQgT6/vzJFtEQK8l37Hm
	 x7d06Nnq1Hs4UMwAKQihTuv/+UuKWF3Q7S+zNLnb4IC8pt30CAaI2vCnG831IqO1wpiOi
	 xbfMRaQQ+hQHFTCr4XypOEa2ESzGDSk+H7I1agJiCPvHf4fcwjNRHyPY2DofbrqEpCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bencteux.fr;
	spf=pass smtp.mailfrom=bencteux.fr;
	dkim=pass header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=GaQVSnNt;
	arc=none smtp.remote-ip=51.178.41.114
Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C12606A31C;
	Wed, 11 Nov 2026 11:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=GaQVSnNt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1794395498; bh=Sr1DZRwa7vdnE6C7z7QEYbMUy3pFbSOLd4oJHfOm+80=;
	h=From:To:Cc:Subject:Date:From;
	b=GaQVSnNtmiX/3XnbMpzbSLKBnYhn6TAAfXAwHHQ8mIBj0GHL85omy4s09WM/1AElk
	 DA0cV+Q34siywIYIGuYE1gkBeX8aKe1Lu0rKpW8GFkoAMpWSvEaI3NgbhVCVL3DoXb
	 CipeccpiGAu3Mve2xH0Jh/Il3Ij9+zfC1uKrZNcY=
Received: from localhost (88-178-48-87.subs.proxad.net [88.178.48.87])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 1443B4029F;
	Wed, 11 Nov 2026 12:11:38 +0100 (CET)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: paul@paul-moore.com,
	eparis@redhat.com,
	arnd@arndb.de,
	audit@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH] audit: add missing syscalls to signal class
Date: Wed, 11 Nov 2026 12:01:54 +0100
Message-ID: <20261111110200.30415-1-jeff@bencteux.fr>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd_send_signal(), rt_sigqueueinfo() and rt_tgsigqueueinfo()
system calls are missing from the AUDIT_CLASS_SIGNAL* class. It seems
to be used only in kernel/auditfilter.c to increment the audit_signals
counter.

This counter is used to determine if information related to a target
process of a syscall audit rule using signals, such as its pid,
should be logged (e54dc2431d740a79a6bd013babade99d71b1714f).

Information related to signals sent via these system calls are
currently not correctly logged. The current patch adds it to the
AUDIT_CLASS_SIGNAL* class.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 include/asm-generic/audit_signal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/asm-generic/audit_signal.h b/include/asm-generic/audit_signal.h
index 6feab7f18a53..65336a9aef7b 100644
--- a/include/asm-generic/audit_signal.h
+++ b/include/asm-generic/audit_signal.h
@@ -1,3 +1,12 @@
 __NR_kill,
 __NR_tgkill,
 __NR_tkill,
+#ifdef __NR_rt_sigqueueinfo
+__NR_rt_sigqueueinfo,
+#endif
+#ifdef __NR_rt_tgsigqueueinfo
+__NR_rt_tgsigqueueinfo,
+#endif
+#ifdef __NR_pidfd_send_signal
+__NR_pidfd_send_signal,
+#endif

base-commit: 6614d4c05c7a661a925b3d8dbf9c70faac3bd2da
-- 
2.56.0

