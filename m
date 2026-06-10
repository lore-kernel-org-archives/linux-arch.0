Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BB2DAFBD
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110070; cv=none; b=hSH31/vtQgfqvX0E2qi4YeU1ZIk/TPDUELPzOPC1/ffpfaOmGEViL6qme/B0AlH7snO+e337TuQK/NMkZYYF3nql2XzG1n1ss02Qflba7EgL3bDvVvkDHDVx2oMtrs9KHv9t547i0x/SqbHJny2xnv6G793PF7EB13fDacKm+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110070; c=relaxed/simple;
	bh=ILSDuGtc/VEwuo1bSt9wGBonzv1A3Qf0CCSzdipLyhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tz7+Jpf7F2CZMRcESL2bAJqyNVFudlNrii/1g5gz0yGCcJWh2aMWPTMhCl3KqlPuX31P3Np2c7Aw2CdFLwNReoCki6FSYFjHaWKezkdj/eK/F8KfsQwQqJydfDGznKfTuS2u780eerMbbUTIMdFvpj7CO16pQ1fUUpiuXPlpTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9wp7CUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9wp7CUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781110067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kba60HHRWHbpiivYYpgncbDPBklbvR35kRBo27vChBU=;
	b=F9wp7CUEQqcbRk21K4IuaKLscS+kEeiIfuDIAJxaTKvGJG8hNMeBjea0y2RYqaxyvGizAP
	H7zjUkP8r1XLdErZQy7BTTbUhwrVTKUKyP7Vj7YFAjY8iCFszkiYhLuOQmfM//9r2WoKyY
	sXVg6teBehsAioxt4HiwJt7vxmnj1t8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-Pd91oeesNIma3-4yU9lgHA-1; Wed,
 10 Jun 2026 12:47:43 -0400
X-MC-Unique: Pd91oeesNIma3-4yU9lgHA-1
X-Mimecast-MFC-AGG-ID: Pd91oeesNIma3-4yU9lgHA_1781110062
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3986A184EB6C;
	Wed, 10 Jun 2026 16:47:42 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 431E9195419F;
	Wed, 10 Jun 2026 16:47:38 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	arnd@arndb.de,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add missing syscalls to PERM class tables
Date: Wed, 10 Jun 2026 13:47:19 -0300
Message-ID: <20260610164719.2668906-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add missing file timestamp and attribute syscalls to the audit PERM
class tables. The most critical gap was the complete absence of
timestamp syscalls from audit_change_attr.h, which meant timestamp
syscalls failed the kernel-side AUDIT_PERM_ATTR class check, so
rules using perm=a did not match those operations.

Changes:
- audit_change_attr.h: Add utime, utimes, futimesat, utimensat,
  utimensat_time64, and file_setattr

- audit_read.h: Add quotactl_fd, file_getattr, stat, lstat, fstat,
  newfstatat, and statx

- audit_write.h: Add quotactl_fd

Architecture-specific and conditionally-compiled syscalls are guarded
with #ifdef.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/asm-generic/audit_change_attr.h | 16 ++++++++++++++++
 include/asm-generic/audit_read.h        | 19 +++++++++++++++++++
 include/asm-generic/audit_write.h       |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index ddd90bbe40df..5cb036695d8a 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -40,3 +40,19 @@ __NR_link,
 #ifdef __NR_linkat
 __NR_linkat,
 #endif
+#ifdef __NR_utime
+__NR_utime,
+#endif
+#ifdef __NR_utimes
+__NR_utimes,
+#endif
+#ifdef __NR_futimesat
+__NR_futimesat,
+#endif
+__NR_utimensat,
+#ifdef __NR_utimensat_time64
+__NR_utimensat_time64,
+#endif
+#ifdef __NR_file_setattr
+__NR_file_setattr,
+#endif
diff --git a/include/asm-generic/audit_read.h b/include/asm-generic/audit_read.h
index fb9991f53fb6..8feebc5b4c50 100644
--- a/include/asm-generic/audit_read.h
+++ b/include/asm-generic/audit_read.h
@@ -3,6 +3,9 @@
 __NR_readlink,
 #endif
 __NR_quotactl,
+#ifdef __NR_quotactl_fd
+__NR_quotactl_fd,
+#endif
 __NR_listxattr,
 #ifdef __NR_listxattrat
 __NR_listxattrat,
@@ -18,3 +21,19 @@ __NR_fgetxattr,
 #ifdef __NR_readlinkat
 __NR_readlinkat,
 #endif
+#ifdef __NR_file_getattr
+__NR_file_getattr,
+#endif
+#ifdef __NR_stat
+__NR_stat,
+#endif
+#ifdef __NR_lstat
+__NR_lstat,
+#endif
+#ifdef __NR_fstat
+__NR_fstat,
+#endif
+#ifdef __NR_newfstatat
+__NR_newfstatat,
+#endif
+__NR_statx,
diff --git a/include/asm-generic/audit_write.h b/include/asm-generic/audit_write.h
index f9f1d0ae11d9..378128dc31e3 100644
--- a/include/asm-generic/audit_write.h
+++ b/include/asm-generic/audit_write.h
@@ -5,6 +5,9 @@ __NR_acct,
 __NR_swapon,
 #endif
 __NR_quotactl,
+#ifdef __NR_quotactl_fd
+__NR_quotactl_fd,
+#endif
 #ifdef __NR_truncate
 __NR_truncate,
 #endif
-- 
2.53.0

