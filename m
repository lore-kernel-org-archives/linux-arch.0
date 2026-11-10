Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286940;
	b=tirJGTeY1tJ+x0SuKrtaUbbonP2EabWLa0BWwAw1zWt0Z3S5Od2dIsMjRO3vNdZKamtR
	 DR1zKdYBNWsC61GgpPkjfNrbL9SonRCcNYnujoGX/u/p0vasZEv89K3kEe5bfkEI6wwEJ
	 Dhj7qt6edPGX91c7B66NomhqgYDTapmBrdcR53whSjGoyZw9Y7AvC810QlWwGDgsetIo9
	 dvB3ZA+ZiQfKZYd2vObpsWfZme1FFYh7c3sD8LZKxJ37UNwE13NAzeozOEk67zZyB5ZCY
	 cA7iyQKZnAETrZHAl34m2OJ2zK4fYCSuaIhJkj+PtsBZd7D8UXyBkPxByA+S73Xn1mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=;
	b=vMAn7YVCCMCW6hiAkR2Ivd30xtkzjOdRukMnwi3gH/P/tCDQkylOCK5bcY/8wWtGePBY
	 CRveT/d8ZAr4BvTFRk9NMM9l47dZwDIRJ7NacN5bMSJoLnqh3atfGe5KRNqSN/W04KE66
	 2s8pEPrxksNG+v4dxwsX/21eMvev1RFxeilA4gGOYRQdQVkF07U2Om+7G7MXVvzrfqmgU
	 AUV/GbePwHppG+w1mAz4gPhJWX/xNS2wsGj5iL9ozaVi9pO95uRWl+pri4LZ7xrhf4iQj
	 xD4DncI+752xbbFc0UDZUFEvZKqg6Lijy40zeMrZvNrFwbsJcihOfcKU2jvcEgzmWAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Py5I6zuL;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10612606B8AA
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 05:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10612606B8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Py5I6zuL
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4d1684d1b3so145705866b.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 21:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286938; x=1794891738; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=;
        b=Py5I6zuLDc2O4ylVDAQMOq2xfBJFMok6YcLdXsK3QGtW7DYKWl96IpTNBZq7lZQmZg
         AK6gvo5ikQg7vvsyfBARQlTyOutCAmBXgXTuZ9tBioMV46RHozJErkvhjbybFIM3Jssy
         nUDOredF8ewQgTHougB8nv6IM3UI5LlEd+1Kz3XT5Xy+Uj+46TwBfUdiI+c8dhGjSxNT
         r9dSigFcCXa8j1u4wWMG5H6MyTB+YaLOMG6TIIVS0kdbJMwoLEOvebusPvBPNGTWvurR
         SMSFlMx1u96fGSaPZsN9kcMtjbhO2gd7MGZaqXkBQSYdbhb3ZdbS6/b99Yc4XN17lGwD
         IcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286938; x=1794891738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jomqh3EBPc599hlxv7mE3jDDZh0m6vOE0Julqd7EtAs=;
        b=gFXUn9UPueGEuJMRKn6ank7UTLVjC7W7/fIt/gqsU9mY998eK2If/9sI5ExTHMWWR+
         c6CdeVHQMDzZ3jTg1sUbBEbKBl4ZeYhQOf2sP6/CgfYTbxFsGjstAJGUqSxw1ua2hpmQ
         MspPQzcB9uinTtbrfGL8Vxc5KpaI2qSdnw+Po58r/q9bayQ+bxXkJlJx19fUXFvmSCCZ
         KTTyO8l72UnVDeBzIE8fGaViCk3tHaSBghKnfZvBYTy3n6GDj22K/A6gKRctAQiCBGPa
         75nfLAkdPMYLk7rSgv7/SSOSJ2KdncY1tZIC3wRaojTIXopVBAVZKyPH42orzx+BwSgb
         De9w==
X-Forwarded-Encrypted: i=1; AL+hErH5YkvBpnG57SC0ciwS/w4UQKulKpmONwZWJeCq+/8yX2SQDoteQPmSo71Of0jsaDU1QmPMnlDWJ4H7@vger.kernel.org
X-Gm-Message-State: APuU4Z91+OYb/ylUN0fYfJqdHc8qtICokfkSN2xA+r1jHyIfTWkNioKy
	dyIJBGNpu928Q3L4pfa2Xb3iUQ0O6ht4hDlAf6xe6VKc2179kUp2RINc7yCSC9REsG51pRNmLAE
	GqVk4MaZVFCE8gIpUeg==
X-Received: from edzg2.prod.google.com ([2002:a05:6402:902:b0:6b5:8540:2bf])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d8f:b0:c48:a838:c16d with SMTP id a640c23a62f3a-c5049629dbbmr100182566b.30.1794286938072;
 Mon, 09 Nov 2026 21:02:18 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:55 +0000
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
Message-ID: <20261110050202.529473-13-tarunsahu@google.com>
Subject: [PATCH v4 12/19] liveupdate: Add feature header to struct luo_file_ser
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

Precede each serialized file entry in a LUO file set KHO block set with
struct kho_ser_hdr via DECLARE_KHO_SER so future per-file metadata
features can append fields to struct luo_file_ser without breaking
compatibility between adjacent kernels.

Initialize file set block sets with kho_ser_size(luo_file_ser), initialize
each entry feature header in luo_file_freeze(), and validate the incoming
feature header in luo_file_deserialize_one() before accessing the struct
luo_file_ser payload.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h  |  6 +++---
 kernel/liveupdate/luo_file.c | 26 +++++++++++++++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index bd19211c64e1..38b4658183a2 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -92,6 +92,8 @@ DECLARE_KHO_SER(luo_ser, 24, 0, 0);
  * @compatible:  File handler compatible string.
  * @data:        Private data
  * @token:       User provided token for this file
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
@@ -99,9 +101,7 @@ struct luo_file_ser {
 	u64 token;
 };
 
-static_assert(sizeof(struct luo_file_ser) == 64);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_file_ser) == 8);
+DECLARE_KHO_SER(luo_file_ser, 64, 0, 0);
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 02d09a80d785..2da327f8bdae 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -486,10 +486,12 @@ int luo_file_freeze(struct luo_file_set *file_set,
 	kho_block_set_it_init(&it, &file_set->block_set);
 
 	list_for_each_entry(luo_file, &file_set->files_list, list) {
-		struct luo_file_ser *file_ser = kho_block_set_it_reserve_entry(&it);
+		DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr) =
+			kho_block_set_it_reserve_entry(&it);
+		struct luo_file_ser *file_ser;
 
 		/* This should not fail normally as blocks were pre-allocated */
-		if (WARN_ON_ONCE(!file_ser)) {
+		if (WARN_ON_ONCE(!fhdr)) {
 			err = -ENOSPC;
 			goto err_unfreeze;
 		}
@@ -502,6 +504,8 @@ int luo_file_freeze(struct luo_file_set *file_set,
 			goto err_unfreeze;
 		}
 
+		kho_ser_init(fhdr, luo_file_ser);
+		file_ser = kho_ser_payload(fhdr, luo_file_ser);
 		strscpy(file_ser->compatible, luo_file->fh->compatible,
 			sizeof(file_ser->compatible));
 		file_ser->data = luo_file->serialized_data;
@@ -742,11 +746,19 @@ int luo_file_finish(struct luo_file_set *file_set)
 }
 
 static int luo_file_deserialize_one(struct luo_file_set *file_set,
-				    struct luo_file_ser *ser)
+				    DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr))
 {
 	struct liveupdate_file_handler *fh;
 	bool handler_found = false;
+	struct luo_file_ser *ser;
 	struct luo_file *luo_file;
+	int err;
+
+	err = kho_ser_validate(fhdr, luo_file_ser);
+	if (err)
+		return err;
+
+	ser = kho_ser_payload(fhdr, luo_file_ser);
 
 	down_read(&luo_register_rwlock);
 	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
@@ -810,7 +822,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 DECLARE_KHO_SER_HDR(luo_file_set_ser, *file_set_fhdr))
 {
 	struct luo_file_set_ser *file_set_ser;
-	struct luo_file_ser *file_ser;
+	DECLARE_KHO_SER_HDR(luo_file_ser, *fhdr);
 	struct kho_block_set_it it;
 	int err;
 
@@ -848,8 +860,8 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	 * reliably reset devices and reclaim memory.
 	 */
 	kho_block_set_it_init(&it, &file_set->block_set);
-	while ((file_ser = kho_block_set_it_read_entry(&it))) {
-		err = luo_file_deserialize_one(file_set, file_ser);
+	while ((fhdr = kho_block_set_it_read_entry(&it))) {
+		err = luo_file_deserialize_one(file_set, fhdr);
 		if (err)
 			goto err_destroy_blocks;
 		file_set->count++;
@@ -883,7 +895,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 void luo_file_set_init(struct luo_file_set *file_set)
 {
 	INIT_LIST_HEAD(&file_set->files_list);
-	kho_block_set_init(&file_set->block_set, sizeof(struct luo_file_ser));
+	kho_block_set_init(&file_set->block_set, kho_ser_size(luo_file_ser));
 }
 
 void luo_file_set_destroy(struct luo_file_set *file_set)
-- 
2.56.0.506.g506a7eabc5-goog

