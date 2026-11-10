Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286939;
	b=H5N0WDyZZDwvyElTdrCDULn4wDx7CsGwEbsnya7xw77D3WF9vBOBSUsaBWaitgVGEoY+
	 nvM6vNuz3EkpKpD3kk8D87wou8imaoY8cJpx7pvqlh2oNYL/XHx6N+du8wLYWn1AFhiBU
	 lveEUJSQUDRoO9P3V8usxhdjvkiLuTVzxbIQXy6lfP2in5Ndxkro87+CQO5WlF/LDDIyi
	 I/6k3dZLzfeSNmt3brYShKe7dyhoUoqka+lXET5Ct6x+BY1IfejtsFVn5UcLpvwCxqhgf
	 7s0JaWuEp1sWEzWO5pyP2CaMYdILexyUuRjg2npRSImQP6KuFBbijjl0DEEJ1MiGePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
	b=DZh3mb2POS8l1UOaKFPB7cjNSyt99bzFZolc1lrjKVAxSi6I9jvK5nJrfE9WWJp2CFJ0
	 +Ay6kaUwBsNRwviU9hBvTSOslrkDKXTDcMsImuBLpwQhFsfU1Q+57SXc8eIpGCJEX6RO+
	 zO5OgC70tAziDRznsD2dGpCzx3grxTZ61WYY5fPX+y3mB0bkPHt9vqoaH/wtyjoeKY1io
	 xgnY9tpgW7YjsDbG9hAMPicfKn0JlgiL55TtGcndBRDFbeX7B7H3XpfB1woYC4/LKZZNs
	 5Z5GzDFvisXmNF90eoLsXHksKQ3YFX8NCqxGB7iOa2R6hyDTFBBipU3QKkkP5OAEFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FiOEcCvK;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F96606B88E
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 05:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F96606B88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FiOEcCvK
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b56221d367so1515342a12.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286937; x=1794891737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
        b=FiOEcCvKt8hD5XQASYW/7fiH9SckLOo5T1b4DEmVCLpCFQFZXC4REpnWaK4Iax/5dc
         h+sJ1frhT11FIgtDCI0vyzBTRQesHQ6dbzx/LA5qcNW6kVSAntx039PzXxZ9nXDlMGDI
         i1vl0N5Xgw+bqFys8nWpj5VofpBx5swGGK0NjUURLekhQNjXMJvu5wF9yR4IoYTGnXfm
         0VkesjThVCQZuBk8RSp35U4DXGjbLN5kiqZ26ufPAmvG+qR2SpSP1yU/Vzt+HeFRi9HC
         I1yQjhcj6pFNNyLe/VBYDvCnvL84nbrLD959p/DZZkjAMX7a9edF6g8URdE0+1Bvxsaa
         uDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286937; x=1794891737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPe/n/7OHPWH7BQXApvZomY3AKt9T7o7Wopgeakkuns=;
        b=2e5EvlIdDZB8kJqLMAl37O3oRT2i9a7EEj661EiH7+rprieQUq91TjorF3n6E8Xmvr
         ZvAolbI/50f1a7L1bceoX9izp4i8hMAXhNvankbs35OL749mcYwArJYqD2GXsls6LCt+
         A6qUiHN6DyE/wMcB2e8QBWZHKvNK227oAjrJ3PfcOczbAQfsvaQOeJzfGOt/bssw0mWV
         yyIT4Ul1FDWgyfjPZrMCGbvwr2bHOOgevwLvgRRz3wiwg8OhdJf8IVHn6v1VOleVl07P
         8T2UTCaASV2EZJddvt/Jr0K1aWg7VTbtK/qrarrzlH/zQ3uuqDidi3kue9ybR9HQoemT
         bFuA==
X-Forwarded-Encrypted: i=1; AL+hErH+NGyQI1pu5DTrbMUaQ/MIRvDSHofSk5KR/gePFBbuC/RtjCH6kiNjxuVOVJaPktIQzU62VGuQGIje@vger.kernel.org
X-Gm-Message-State: APuU4Z+5fbzp2CO4bj9zzOXgLRn5N+KWxNLqOmRKmXh09C6wTfmrhq0l
	wrnYn+Ac6b8/sLzS4/GQ2sJyohNyqJ+M+LLk2eQ0iUK49/YL7rh/zODqlNHZ88nGGbfC8HPt6Is
	b89MVJArVLyKYdlIAog==
X-Received: from edcp5.prod.google.com ([2002:a05:6402:43c5:b0:6b5:8717:e943])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3907:b0:6b5:5fca:3d5 with SMTP id 4fb4d7f45d1cf-6b756ad6f48mr1260878a12.19.1794286937148;
 Mon, 09 Nov 2026 21:02:17 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:54 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-12-tarunsahu@google.com>
Subject: [PATCH v4 11/19] liveupdate: Add feature header to struct luo_file_set_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Precede struct luo_file_set_ser with struct kho_ser_hdr via
DECLARE_KHO_SER so future file-set metadata features can append fields
to struct luo_file_set_ser without breaking compatibility between
adjacent kernels.

Reserve space for both the session feature header and the file-set
feature header in each session block-set entry, initialize the file-set
feature header in luo_file_freeze(), and validate incoming required
features in luo_file_deserialize() before accessing payload fields.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h      | 15 ++++++++-------
 kernel/liveupdate/luo_file.c     | 32 ++++++++++++++++++++++----------
 kernel/liveupdate/luo_internal.h |  7 ++++---
 kernel/liveupdate/luo_session.c  | 14 +++++++-------
 4 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 425c52c494f1..bd19211c64e1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -112,21 +112,21 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * @count:   The total number of files that were part of this session during
  *           serialization. Used for iteration and validation during
  *           restoration.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_file_set_ser {
 	u64 files;
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_file_set_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_file_set_ser) == 8);
+DECLARE_KHO_SER(luo_file_set_ser, 16, 0, 0);
 
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
- * @name:         The unique name of the session, provided by the userspace at
- *                the time of session creation.
- * @file_set_ser: Serialized pointer to the files belonging to this session.
+ * @name:          The unique name of the session, provided by the userspace at
+ *                 the time of session creation.
+ * @file_set_fhdr: Serialized pointer to the files belonging to this session.
  *
  * This structure is used to package session-specific metadata for transfer
  * between kernels via Kexec Handover. An array of these structures (one per
@@ -137,7 +137,8 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	DECLARE_KHOSER_PTR(file_set_ser, struct luo_file_set_ser *);
+	DECLARE_KHOSER_PTR(file_set_fhdr,
+			   DECLARE_KHO_SER_HDR(luo_file_set_ser, *));
 };
 
 DECLARE_KHO_SER(luo_session_ser, 72, 0, 0);
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..02d09a80d785 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -440,8 +440,8 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
- * @file_set:     The file_set whose files are to be frozen.
- * @file_set_ser: Where to put the serialized file_set.
+ * @file_set:      The file_set whose files are to be frozen.
+ * @file_set_fhdr: Where to put the serialized file_set.
  *
  * This function is called from the reboot() syscall path, just before the
  * kernel transitions to the new image via kexec. Its purpose is to perform the
@@ -472,12 +472,14 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  * Return: 0 on success, or a negative errno on failure.
  */
 int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser)
+		    DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
+	struct luo_file_set_ser *file_set_ser;
 	struct luo_file *luo_file;
 	struct kho_block_set_it it;
 	int err;
 
+	kho_ser_init(file_set_fhdr, luo_file_set_ser);
 	if (!file_set->count)
 		return 0;
 
@@ -506,6 +508,7 @@ int luo_file_freeze(struct luo_file_set *file_set,
 		file_ser->token = luo_file->token;
 	}
 
+	file_set_ser = kho_ser_payload(file_set_fhdr, luo_file_set_ser);
 	file_set_ser->count = file_set->count;
 	file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
 
@@ -519,8 +522,8 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
- * @file_set:     The file_set whose files are to be unfrozen.
- * @file_set_ser: Serialized file_set.
+ * @file_set:      The file_set whose files are to be unfrozen.
+ * @file_set_fhdr: Serialized file_set.
  *
  * This function rolls back the state of all files in a file_set after the
  * freeze phase has begun but must be aborted. It is the counterpart to
@@ -534,13 +537,13 @@ int luo_file_freeze(struct luo_file_set *file_set,
  *          the reboot() syscall, after luo_file_freeze() has been called.
  */
 void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser)
+		       DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
 	if (!file_set->count)
 		return;
 
 	__luo_file_unfreeze(file_set, NULL);
-	memset(file_set_ser, 0, sizeof(*file_set_ser));
+	memset(file_set_fhdr, 0, kho_ser_size(luo_file_set_ser));
 }
 
 /**
@@ -780,8 +783,8 @@ static int luo_file_deserialize_one(struct luo_file_set *file_set,
 
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
- * @file_set:     The incoming file_set to fill with deserialized data.
- * @file_set_ser: Serialized KHO file_set data from the previous kernel.
+ * @file_set:      The incoming file_set to fill with deserialized data.
+ * @file_set_fhdr: Serialized KHO file_set data from the previous kernel.
  *
  * This function is called during the early boot process of the new kernel. It
  * takes the raw, contiguous memory block of 'struct luo_file_ser' entries,
@@ -804,12 +807,21 @@ static int luo_file_deserialize_one(struct luo_file_set *file_set,
  * Context: Called from session deserialization.
  */
 int luo_file_deserialize(struct luo_file_set *file_set,
-			 struct luo_file_set_ser *file_set_ser)
+			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
+	struct luo_file_set_ser *file_set_ser;
 	struct luo_file_ser *file_ser;
 	struct kho_block_set_it it;
 	int err;
 
+	if (!file_set_fhdr)
+		return -EINVAL;
+
+	err = kho_ser_validate(file_set_fhdr, luo_file_set_ser);
+	if (err)
+		return err;
+
+	file_set_ser = kho_ser_payload(file_set_fhdr, luo_file_set_ser);
 	if (!file_set_ser->files) {
 		WARN_ON(file_set_ser->count);
 		return 0;
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..e22a8cf39d91 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_LUO_INTERNAL_H
 #define _LINUX_LUO_INTERNAL_H
 
+#include <linux/kho/abi/luo.h>
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
 #include <linux/kho_block.h>
@@ -104,14 +105,14 @@ int luo_session_deserialize(void);
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser);
+		    DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser);
+		       DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
 int luo_file_deserialize(struct luo_file_set *file_set,
-			 struct luo_file_set_ser *file_set_ser);
+			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr));
 void luo_file_set_init(struct luo_file_set *file_set);
 void luo_file_set_destroy(struct luo_file_set *file_set);
 
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 641bd67ce76e..6513fde3ecfe 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -132,7 +132,7 @@ struct luo_session_global {
 };
 
 #define LUO_SESSION_SER_SIZE (kho_ser_size(luo_session_ser) + \
-			      sizeof(struct luo_file_set_ser))
+			      kho_ser_size(luo_file_set_ser))
 
 static struct luo_session_global luo_session_global = {
 	.incoming = {
@@ -227,7 +227,7 @@ static void luo_session_unfreeze_one(struct luo_session *session,
 {
 	guard(mutex)(&session->mutex);
 	luo_file_unfreeze(&session->file_set,
-			  KHOSER_LOAD_PTR(ser->file_set_ser));
+			  KHOSER_LOAD_PTR(ser->file_set_fhdr));
 }
 
 static int luo_session_freeze_one(struct luo_session *session,
@@ -235,7 +235,7 @@ static int luo_session_freeze_one(struct luo_session *session,
 {
 	guard(mutex)(&session->mutex);
 	return luo_file_freeze(&session->file_set,
-			       KHOSER_LOAD_PTR(ser->file_set_ser));
+			       KHOSER_LOAD_PTR(ser->file_set_fhdr));
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -560,14 +560,14 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 static struct luo_session_ser *
 luo_session_ser_init(DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr))
 {
-	struct luo_file_set_ser *file_set_ser;
+	DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr);
 	struct luo_session_ser *ser;
 
 	kho_ser_init(fhdr, luo_session_ser);
-	file_set_ser = (void *)fhdr + kho_ser_size(luo_session_ser);
+	file_set_fhdr = (void *)fhdr + kho_ser_size(luo_session_ser);
 
 	ser = kho_ser_payload(fhdr, luo_session_ser);
-	KHOSER_STORE_PTR(ser->file_set_ser, file_set_ser);
+	KHOSER_STORE_PTR(ser->file_set_fhdr, file_set_fhdr);
 
 	return ser;
 }
@@ -601,7 +601,7 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
 
 	scoped_guard(mutex, &session->mutex) {
 		err = luo_file_deserialize(&session->file_set,
-					   KHOSER_LOAD_PTR(ser->file_set_ser));
+					   KHOSER_LOAD_PTR(ser->file_set_fhdr));
 	}
 	if (err) {
 		pr_warn("Failed to deserialize files for session [%s] %pe\n",
-- 
2.56.0.506.g506a7eabc5-goog

