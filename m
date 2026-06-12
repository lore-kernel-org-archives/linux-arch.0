Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A26317155
	for <linux-arch@vger.kernel.org>; Fri, 12 Jun 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273692; cv=none; b=Awpb9SOJobs8dWdUEDA8BAa+TnIpL3nIPomEHfsI5RGVf+WZn+QG52vrq3WeNVYnXFvGJE+YlTqm8yVoHm9T4w1wOpyAIXNlSP+eYD4k6Jpv2M950npfyZO561VR1BAtiWEg4tGKLqFllS4EwSPQCFQG/nhntoET/d9qNrB8DFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273692; c=relaxed/simple;
	bh=Zebk62J7NRpW3SkTs8pUMwqkT3NgzSOMLPjiXRd9KWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpBVwhC6JPMv7Tbd1+5+W3uwRcycAVHcavoZJK+3lEqf/aMBvDb83Zt1rnJfdv4zVCj3mNziE3NJt9AJ+DJtp9GGSxzZB35K0RHok/y8XeYk1SddD1Jo4Y6Ay6fpG/AhAvLFs+3QB69txyfpQVEA7x2a4jsxUxPm7NaFnm7xNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d603jt0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d603jt0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781273688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y3MQpKCShTW8JvaRHAcnH0u3oKwnRUmD7ODT7NaGVxs=;
	b=d603jt0BkgvgaeSQVA17nCgXwzBh/hwf7cyztSNuzK4+xWOqW4ByF+8mEbpMEskdfcjajD
	m4AvtrXgAmTuEejmDXgKnRVtF8sJn2lxO078joqG8Nhd8LY15Dr3ONhdiYfj81LKi1wXl9
	nh3xn+5o3dxEktUactBwXUDg6SnuSSI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-VTRz5LQ4MK2Xfrq9ZN01EQ-1; Fri,
 12 Jun 2026 10:14:44 -0400
X-MC-Unique: VTRz5LQ4MK2Xfrq9ZN01EQ-1
X-Mimecast-MFC-AGG-ID: VTRz5LQ4MK2Xfrq9ZN01EQ_1781273683
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62160195DE10;
	Fri, 12 Jun 2026 14:14:43 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.108])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8315C36917;
	Fri, 12 Jun 2026 14:14:40 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	arnd@arndb.de,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2] audit: add missing syscalls to PERM class tables
Date: Fri, 12 Jun 2026 11:14:36 -0300
Message-ID: <20260612141436.3137694-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add missing file metadata syscalls to the audit PERM class tables,
addressing gaps where certain file operations were not properly
classified for audit rule matching.

Changes:
- audit_change_attr.h: Add file_setattr

- audit_read.h: Add quotactl_fd, file_getattr, stat, stat64, lstat,
  lstat64, fstat, fstat64, newfstatat, fstatat64, and statx

- audit_write.h: Add quotactl_fd

Architecture-specific and conditionally-compiled syscalls are guarded
with #ifdef.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Added stat64 family syscalls (stat64, lstat64, fstat64, fstatat64) to
  audit_read.h for 32-bit architecture support.
- Dropped timestamp-related syscalls (utime, utimes, utimensat, etc.)
  due to potential audit log volume increase impact. Those will be
  addressed in a separate patch after closer investigation.

 include/asm-generic/audit_change_attr.h |  3 +++
 include/asm-generic/audit_read.h        | 31 +++++++++++++++++++++++++
 include/asm-generic/audit_write.h       |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index ddd90bbe40df..94388da3490c 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -40,3 +40,6 @@ __NR_link,
 #ifdef __NR_linkat
 __NR_linkat,
 #endif
+#ifdef __NR_file_setattr
+__NR_file_setattr,
+#endif
diff --git a/include/asm-generic/audit_read.h b/include/asm-generic/audit_read.h
index fb9991f53fb6..d8dc3dd6bf63 100644
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
@@ -18,3 +21,31 @@ __NR_fgetxattr,
 #ifdef __NR_readlinkat
 __NR_readlinkat,
 #endif
+#ifdef __NR_file_getattr
+__NR_file_getattr,
+#endif
+#ifdef __NR_stat
+__NR_stat,
+#endif
+#ifdef __NR_stat64
+__NR_stat64,
+#endif
+#ifdef __NR_lstat
+__NR_lstat,
+#endif
+#ifdef __NR_lstat64
+__NR_lstat64,
+#endif
+#ifdef __NR_fstat
+__NR_fstat,
+#endif
+#ifdef __NR_fstat64
+__NR_fstat64,
+#endif
+#ifdef __NR_newfstatat
+__NR_newfstatat,
+#endif
+#ifdef __NR_fstatat64
+__NR_fstatat64,
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

