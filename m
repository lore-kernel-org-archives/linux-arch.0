Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.178.41.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411271;
	b=lToBvruOVxrRa/a+fLdae+d0TmsQD98YEcHbsMX6lxY2E3ooLpoDR58gjxSoeJ4uPILk
	 Ah5TG8clQr5D28cbqKOALknFKa6UP02/FJmrRz5UPKcqRY8gEtuDo3UW472UrBgASh0TJ
	 uQTlmxqzhns26gBxTZsgt+BnbsYUZ8lEiSn5x/3l8QcrN2+h8yKJMd8MzMMLBjFjqN+70
	 +ov2+AUEqWou7Csr1EJ9A7I1PqWwLcTFx63BcYqnrZWrmxouTcPIN2QwaUkz7AhC+x5JV
	 O8wyqJK3cixgx+GuZGQoVwuoer2yvYgC5Me/PLsLBk4K4/XrlWGrWr3LrxoUD/NR/qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411271;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MC35NwvYHbQmTMFdIYuy0TI1TVZGM/Iyjc/cBErfQM4=;
	b=IeO24YXFpv1TpVTNP5G26ubEX76qYW6TkuYf6M13QzVBXW5HQleMEHBS6FubilwN8RUZ
	 QbI7wDAP+Y7rz/34LgU8rWCcVTliXui0g+Obi8odoDBmrgNPCdJclINas9oGHzej2A3LH
	 +dfwRkLWiFX31HA+1RRIXbnuxE+AtneA5nyQneNg7sK3TbnJlOlH86TcwxY3KjIlNuK8i
	 YAn6NcarPbugKgjUrptC9c5cKpjVWf29diOLQw4fxgXitxOLeWtYtLJ/FMRCekDYF1iCq
	 K/KeOBXAE70/2tcdDC5Xo6ji8vs3JMb2zAx6wQc+8ULWb9WzV0o07qpphDLfsrGvZXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bencteux.fr;
	spf=pass smtp.mailfrom=bencteux.fr;
	dkim=pass header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=uI0l03g5;
	arc=none smtp.remote-ip=51.178.41.114
Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3E606A321;
	Wed, 11 Nov 2026 15:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=uI0l03g5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1794411088; bh=gXW8SyVARUoohB2SsNyiHx3TvB4I/8N9VeiFAUqba0w=;
	h=From:To:Cc:Subject:Date:From;
	b=uI0l03g5k++BJxlUcQmhttMm2ydWQ/DRfvZB0v8KvXsKf6jX3Jesx6NkQw0ehPiME
	 7lPZPBBaaU+ACrAmw04wR64q5e4Xgceh1tfxvc16OBSSqM6vOwl7OYSY4hSoiKa10M
	 Zur8SkpovVpvPitlnNfVBQYnxgKPWnFdG83KrJ+Y=
Received: from localhost (unknown [146.70.188.209])
	by beta.bencteux.fr (Postfix) with ESMTPSA id B654C4029F;
	Wed, 11 Nov 2026 16:31:28 +0100 (CET)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: paul@paul-moore.com,
	eparis@redhat.com,
	arnd@arndb.de,
	audit@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeff@bencteux.fr,
	rrobaina@redhat.com
Subject: [PATCH v2] audit: add missing syscalls to signal class
Date: Wed, 11 Nov 2026 16:20:51 +0100
Message-ID: <20261111152057.59798-2-jeff@bencteux.fr>
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
Changes in v2:
- Removal of unneeded #ifdef guards

 include/asm-generic/audit_signal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/audit_signal.h b/include/asm-generic/audit_signal.h
index 6feab7f18a53..c02edbee3311 100644
--- a/include/asm-generic/audit_signal.h
+++ b/include/asm-generic/audit_signal.h
@@ -1,3 +1,6 @@
 __NR_kill,
 __NR_tgkill,
 __NR_tkill,
+__NR_rt_sigqueueinfo,
+__NR_rt_tgsigqueueinfo,
+__NR_pidfd_send_signal,

base-commit: 6614d4c05c7a661a925b3d8dbf9c70faac3bd2da
-- 
2.56.0

