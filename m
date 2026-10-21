Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596333;
	b=x929ovilwtRY4vJ8ICH4TDeWZM+MVp07ziPfyG/1zuQB+fNop9086z3ADMRkus0it6Zy
	 Ka9SsKKKpKcJhqFoSyQdrZJch+4YVYdXuQ0+sTCh2xjxM7Ff1Icsbk1k0EXdOjVwIwOQ1
	 iHYrcVTYE/Zi2asqYntBlrIx0yCc6S71WBT1u+8P+YgHxbD2Q1W89GznqXfdrN6J17B2i
	 gWdaKlbXIMs9d/9PGcRvTYY1G+zsCTqoGqxSpAmzRpqcbUupp8Go6xNbiSCH2p6mqCpFz
	 YiIPWSytnAELHkyOmEwEX/r0M2I91BimP5VosGBkjN+JhUTmE/pHe58cwsd0c12D0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
	b=FZkgThlibLsqJLh47ogjHi2UU5kETSXtTTNgbwpt4FWkMN2z9OIVwt+pPs+KL4Fu6NFf
	 X+ZsJu4A/UgutlhlBkRi0hUgn5Big/ywZApKP7KYwHNkJczPQJVOEIXA7VhX09n244H7b
	 W4oL67pi3PfvWgXokgyxSmDeMRQz2TQd2a1u/7IZ79QD4x4tqTArqHQXK/uB/8eOoCiw6
	 cneNfHzMNWad6WfYI30vp8UF+U4phHeKQ3cZ+jR7RUxupLsYI1GqcRYi7WApaoew5eLjW
	 rkRH56K1pD5AaOVVHQI/xTmR2T4gXFbKhDbNA0H1NAQ+JofAmBu0+Rnf58/7ZQc/4Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkqpyNqp;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE60A2616
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1EE60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dkqpyNqp
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c42f98f354fso82487166b.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596332; x=1793201132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=dkqpyNqp41yY7/oxMCemumRID+Op7bhjYa83BNB22tRP/ttHyCTy9bq6BK2iKbrgr6
         TxeyBGCA7iVLdQfRFMqPXYT5vmRhkcWMpZ7lMXpYn6qNa4xyXZqNrkICHgMmcQHgUALV
         +4qnks/hU3ZiFuTSid9pYkwc8rQXgwxtGwedi6BhtTmXVUk22QcSzoXuCSek4paD0wAi
         EHCuEfSmg0+YnU3NH5fFmWFCNNjovUZtr9hjdHdQtLcyQ2uxcUIGZrf1mIXmWSyi9wTS
         oMSjyFfhmhSQaSfLVXRHf3xpSO7mo/tAzB0bzuifh5SAi+7hqXuyBhSEQ771B9bjI2Zb
         D7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596332; x=1793201132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eF6EuxU5y/OwYzc2Wn37QAO5vY1XkAXoeRxwHLACs2w=;
        b=PPEfdYnpy7G0iLyzkRYFaik+xSETjbs7ZdRoNMnXjU6Ril1djBOJgEgQc8hCuc6rgn
         zLBnSpywWzwime9zd8JcpuNcqsbIOYOgrhXf8PM4m1cx7QbB1FWFfu65wSbHMRl81n3B
         CJ/7xi3M5fvVO1hBxfGrMEE+9X/V/CbwABmkhZvYmh9wBgT9H5je2sIxfcntl6WB+x/q
         l7gIH7QyTVsP0mVE4YxqBAS7px4OPYzdwu54v38TvGwEXhr7c6yzkBGgKavzTRbZNLWX
         sNmHKlzypBjYT8jezgsiJhobKXcILmQ40lBLxft0zFtDYtp5aZOdPsH7OxEPhlGDu9Ud
         Ogvw==
X-Forwarded-Encrypted: i=1; AKwUvBz6Bf8B6T7t06BtGOgLJ50CnYYbFiDF6LJN6EGi1m3KBXD1GSSCb21lTRGRIghwa8r+gYYYbxHd4UTJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKnzeIm5TXGoRF/GMGrZgrQFghu+BlxVVkTJPZs/Sr7YpZyGGKE
	7xZ27kqQWKxKwGS5wWi0zby8idqrSAfy3By9vh85pv/VkVYO237ml4Q/4tpCwjM+j4ng2M/Av/G
	0fqoua+GsIVGfgy4jGQ==
X-Received: from ejbgw26.prod.google.com ([2002:a17:906:f15a:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d40a:b0:c45:d8aa:6ae5 with SMTP id a640c23a62f3a-c46799bdbb7mr204058966b.42.1792596331473;
 Wed, 21 Oct 2026 08:25:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:25 +0000
In-Reply-To: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-3-tarunsahu@google.com>
Subject: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently luo_preserve_file() iterates over luo_file_handler_list and
picks the first registered handler whose .can_preserve() callback
returns true. When a subsystem introduces a new, backwards-incompatible
file handler alongside an existing one for the same file type, userspace
has no way to choose which handler preserves a file descriptor, nor can
the kernel keep the existing rollback-safe handler as the default while
allowing callers to opt into the new handler.

Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
liveupdate_session_preserve_fd immediately after token, keeping
IOCTL_OP min_size at offsetofend(..., token) so callers passing the
original 16-byte structure continue to work:
- When handler is empty (all-zero, or zero-filled when userspace
  passes the 16-byte structure), luo_preserve_file() selects the first
  registered handler whose .can_preserve() callback accepts the fd.
- When handler is non-empty, it must be null-terminated within
  LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
  luo_preserve_file() looks up the registered handler with that exact
  name (returning -ENOENT if unknown) and verifies that its
  .can_preserve() callback accepts the fd (returning -EINVAL if not).

The retrieve ioctl is unchanged because the handler is identified by the
name stored in the serialized payload from the source kernel.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/uapi/linux/liveupdate.h  | 12 +++++++++---
 kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
 kernel/liveupdate/luo_internal.h |  3 ++-
 kernel/liveupdate/luo_session.c  |  7 ++++++-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 509c6236720d..2413b19dabc1 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
 
 /**
  * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
- * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
- * @fd:    Input; The user-space file descriptor to be preserved.
- * @token: Input; An opaque, unique token for preserved resource.
+ * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
+ * @fd:      Input; The user-space file descriptor to be preserved.
+ * @token:   Input; An opaque, unique token for preserved resource.
+ * @handler: Input; Optional null-terminated file handler name (max length
+ *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) selecting
+ *           which registered handler preserves @fd. If empty (all-zero, or
+ *           omitted when passing the 16-byte structure), the kernel selects
+ *           the first registered handler whose .can_preserve() accepts @fd.
  *
  * Holds parameters for preserving a file descriptor.
  *
@@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
 	__u32		size;
 	__s32		fd;
 	__aligned_u64	token;
+	char		handler[LIVEUPDATE_HNDL_NAME_LENGTH];
 };
 
 #define LIVEUPDATE_SESSION_PRESERVE_FD					\
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index fb81239bedf3..be20e0f1e0aa 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  * @file_set: The file_set to which the preserved file will be added.
  * @token:    A unique, user-provided identifier for the file.
  * @fd:       The file descriptor to be preserved.
+ * @handler:  Optional NUL-terminated handler name. If NULL or empty, the first
+ *            registered handler whose .can_preserve() accepts @fd is selected.
  *
  * This function orchestrates the first phase of preserving a file. Upon entry,
  * it takes a reference to the 'struct file' via fget(), effectively making LUO
@@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
  *         -EBUSY if the file descriptor is already preserved by another session.
  *         -EBADF if the file descriptor is invalid.
  *         -ENOSPC if the file_set is full.
- *         -ENOENT if no compatible handler is found for the file type.
+ *         -ENOENT if no matching handler is registered or accepts @fd.
+ *         -EINVAL if the named handler cannot preserve @fd.
  *         -ENOMEM on memory allocation failure.
  *         Other erros might be returned by .preserve().
  */
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler)
 {
 	struct liveupdate_file_op_args args = {0};
 	struct liveupdate_file_handler *fh;
@@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	err = -ENOENT;
 	down_read(&luo_register_rwlock);
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (handler && handler[0]) {
+			if (strcmp(fh->name, handler))
+				continue;
+			if (!fh->ops->can_preserve(fh, file)) {
+				err = -EINVAL;
+				break;
+			}
+			if (try_module_get(fh->ops->owner))
+				err = 0;
+			break;
+		}
+
 		if (fh->ops->can_preserve(fh, file)) {
 			if (try_module_get(fh->ops->owner))
 				err = 0;
@@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	}
 	up_read(&luo_register_rwlock);
 
-	/* err is still -ENOENT if no handler was found */
 	if (err)
 		goto err_fput;
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..911ffedec9f3 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
 
-int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
+int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
+		      const char *handler);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
 		    struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..194ef45907c1 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
 	int err;
 
+	if (strnlen(argp->handler, sizeof(argp->handler)) ==
+	    sizeof(argp->handler))
+		return -EINVAL;
+
 	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_preserve_file(&session->file_set, argp->token, argp->fd,
+				argp->handler);
 	if (err)
 		return err;
 
-- 
2.56.0.212.g129ede20d9-goog

