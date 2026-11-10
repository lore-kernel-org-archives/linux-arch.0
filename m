Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286934;
	b=boZfSDtkqsu6FwWjryAJ3rWH46FqjbM3/9WjrhFqs71WaChlPlQpHi32F0cyPpT8a63U
	 e2gBAXVRIlVnL002iKBZ+Q6cZ4fg3i/oTagXZA+3rmNnxqeCi0esCXuXEBXkDR7mYWUGP
	 0EMv0qKNasBIlOFQnuXRlcwkW84Syyd60cSBS1kIUKbVVzjKKvCzIXWPhCof3ZLpuTHQ6
	 6CIVbWYlWzYKZQPOVl/PJZyOAwkXScF+8pyKWIe9BDd87wf9x5UdLPW2pYIS3LIRnkb0W
	 R8orLQ/gab+CoTaYWkjfy9B1sxWclBNL1WZ9QJ0nAc+XJGepiX7kIQmAUI0ribjfReQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
	b=BL+eh3y5MtbKP9O+A5pMzaaxA1KYWiKja5n+PC0oQ6BWHebpUy+yk/d7noO7uDjPWZkN
	 8wwrpEoz3YsbsGmr7GL/BdXdf87kkd/0lxi96sxus5My7gn6A/yCs2m94qu61MpweTCTM
	 kzBEYykFtIAo7d1wjTCZFmZYQkUA2wA4Jm981nevBVPaI0Ay2FVJ8b8PxjHGAq+8/ubsU
	 6KPZ3AgdkfaewUNA+HzgxhTInoLUbwgcX20+wMctiKlii3Os/PVoeJrZw6SDT+6xdrVx8
	 1McX2v8iv7hkbuyjLGym+g4KPm1+ipHEBPd+Oss0MbMhDG6wdmqTFaa4twbZLXkm8ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RK98XkIM;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBC60A6F4C
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 05:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29EBC60A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RK98XkIM
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4d288b67ccso132811166b.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286932; x=1794891732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=RK98XkIMArO5krnjlZsSPUNp58bEz7fkWGksIzf/a4YyyV6wR8+oHD+evYV99pLhUf
         pNBkBUY+Pl612sERdsqtIxSba65O89Bmzv9755S3WKvQmfF5z6w0si2gTD9U5CrblayS
         MINQ0Mo4EpmOaAHD4UB3m8DsxAFl7vKWOfB7UcpnAJkU5ypysemMiaeyUPVzak4rDzqB
         8gMeeQvUwawzaHCCNTKyZ7G8EwLrSXkpAUsFhno4lL4r9EMV3TdhXjSrao4uzXgMw3pH
         uIoJojUFcGxgWYBi7mx7VtM0WMcYjsqk5B4Uau8dWWnIkzA6BdfGyRWenXuTRmkQtNdT
         dE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286932; x=1794891732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IgLF3AO1jBgBbxTE6gThjrdHr/S4nDjr0YcBANCh54=;
        b=i5iNRnqeL0bPhP/wiU3n5WzeUF4zT5eSjVm4FLowPBypV8ATNp8g5n3w5bhD3dFeTM
         njNSutL8S6lVkHaasIT+zKyChexM/lWRpfEo7bmQulUwYYsknw80D94KwahH+TKdTq9Q
         lKDQJToArb5qgnzncg2vs43TACreTvrAdWQgxrAPbaTZrB8qAKFKpijmeLjYTAt73fvA
         +UH0FRxXS5Wi2bbin8JeCJaE2h8CANZW/tpk0f9izGGPiwIiB+nbLbascjRfvmf/Srs9
         cF7c6/0VOre1yWloFR+KVoShFt+gchBRtqS2ClBi0rmDlb6Ci4jexjD9Xb5kEHEi4aHn
         zKjw==
X-Forwarded-Encrypted: i=1; AL+hErEo9L431AHB/i98XffqKDgNS3nE3bsMpfJwOUixbYLJw+x/YrPnNbW+QUfsoX/+UepicmFS+wusVMUl@vger.kernel.org
X-Gm-Message-State: APuU4Z/OLeOsv/pteupDtCdtyBRgyGWUys84WZMLRaXD5KgQYD+5YKVF
	ZxaJSJ+N29zWbF31hq2SvFoj/2tIlQeWp8WoEoys7tQCsuB8AsdrEViYPDTnf9oV/GvQAfSUffi
	RNykTo4RjqKXh93aACA==
X-Received: from ejbwr20.prod.google.com ([2002:a17:907:7014:b0:c3f:b33c:8124])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f0d:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c50495d6ee1mr114117566b.36.1794286931810;
 Mon, 09 Nov 2026 21:02:11 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:49 +0000
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
Message-ID: <20261110050202.529473-7-tarunsahu@google.com>
Subject: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
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

The kexec metadata subtree currently uses a monolithic u32 version field
to identify the metadata structure layout. Any change to the structure,
even an optional additive field, requires incrementing the version and
breaks compatibility between adjacent kernels.

Replace the u32 version field in struct kho_kexec_metadata with
struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
under new feature indices without breaking compatibility across kexec.
Also make the 3-byte padding hole between previous_release and kexec_count
explicit as reserved[3].

During deserialization, validate the blob size against the header size
and reject unknown required features. A legacy v1 metadata blob is
ignored with a warning.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_metadata.h | 17 +++++++-----
 kernel/liveupdate/kexec_handover.c     | 38 ++++++++++++++------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
index e9e3f7e38a7c..316b3e5ad01b 100644
--- a/include/linux/kho/abi/kexec_metadata.h
+++ b/include/linux/kho/abi/kexec_metadata.h
@@ -18,28 +18,31 @@
 #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
 #define _LINUX_KHO_ABI_KEXEC_METADATA_H
 
+#include <linux/build_bug.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/types.h>
 #include <linux/utsname.h>
 
-#define KHO_KEXEC_METADATA_VERSION 1
-
 /**
  * struct kho_kexec_metadata - Kexec metadata passed between kernels
- * @version: ABI version of this struct (must be first field)
  * @previous_release: Kernel version string that initiated the kexec
+ * @reserved: Reserved for structure alignment; must be zero
  * @kexec_count: Number of kexec boots since last cold boot
  *
- * This structure is preserved across kexec and allows the new kernel to
+ * This structure is preserved across kexec and allows the target kernel to
  * identify which kernel it was booted from and how many kexec reboots
- * have occurred.
+ * have occurred. Preceded by &struct kho_ser_hdr.
  *
  * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
  */
 struct kho_kexec_metadata {
-	u32 version;
 	char previous_release[__NEW_UTS_LEN + 1];
+	u8 reserved[3];
 	u32 kexec_count;
-} __packed;
+} __aligned(8);
+
+/* Register kho_kexec_metadata with KHO serialization accessors */
+DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
 
 #define KHO_METADATA_NODE_NAME "kexec-metadata"
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4b1d173d48ff..641a3b4c88fb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1762,6 +1762,7 @@ static __init int kho_out_fdt_setup(void)
 
 static void __init kho_in_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	phys_addr_t metadata_phys;
 	size_t blob_size;
@@ -1773,27 +1774,28 @@ static void __init kho_in_kexec_metadata(void)
 		/* This is fine, previous kernel didn't export metadata */
 		return;
 
-	/* Check that, at least, "version" is present */
-	if (blob_size < sizeof(u32)) {
+	if (blob_size < sizeof(*fhdr)) {
 		pr_warn("kexec-metadata blob too small (%zu bytes)\n",
 			blob_size);
 		return;
 	}
 
-	metadata = phys_to_virt(metadata_phys);
-
-	if (metadata->version != KHO_KEXEC_METADATA_VERSION) {
-		pr_warn("kexec-metadata version %u not supported (expected %u)\n",
-			metadata->version, KHO_KEXEC_METADATA_VERSION);
+	fhdr = phys_to_virt(metadata_phys);
+	if (fhdr->size != blob_size) {
+		pr_warn("kexec-metadata size invalid (%u != %zu), ignoring metadata\n",
+			fhdr->size, blob_size);
 		return;
 	}
 
-	if (blob_size < sizeof(*metadata)) {
-		pr_warn("kexec-metadata blob too small for v%u (%zu < %zu)\n",
-			metadata->version, blob_size, sizeof(*metadata));
+	err = kho_ser_validate(fhdr, kho_kexec_metadata);
+	if (err) {
+		pr_warn("kexec-metadata feature validation failed: %pe\n",
+			ERR_PTR(err));
 		return;
 	}
 
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
+
 	/*
 	 * Copy data to the kernel structure that will persist during
 	 * kernel lifetime.
@@ -1813,23 +1815,25 @@ static void __init kho_in_kexec_metadata(void)
  */
 static __init int kho_out_kexec_metadata(void)
 {
+	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
 	struct kho_kexec_metadata *metadata;
 	int err;
 
-	metadata = kho_alloc_preserve(sizeof(*metadata));
-	if (IS_ERR(metadata))
-		return PTR_ERR(metadata);
+	fhdr = kho_alloc_preserve(kho_ser_size(kho_kexec_metadata));
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
+	kho_ser_init(fhdr, kho_kexec_metadata);
 
-	metadata->version = KHO_KEXEC_METADATA_VERSION;
+	metadata = kho_ser_payload(fhdr, kho_kexec_metadata);
 	strscpy(metadata->previous_release, init_uts_ns.name.release,
 		sizeof(metadata->previous_release));
+	memset(metadata->reserved, 0, sizeof(metadata->reserved));
 	/* kho_in.kexec_count is set to 0 on cold boot */
 	metadata->kexec_count = kho_in.kexec_count + 1;
 
-	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata,
-			      sizeof(*metadata));
+	err = kho_add_subtree(KHO_METADATA_NODE_NAME, fhdr, fhdr->size);
 	if (err)
-		kho_unpreserve_free(metadata);
+		kho_unpreserve_free(fhdr);
 
 	return err;
 }
-- 
2.56.0.506.g506a7eabc5-goog

