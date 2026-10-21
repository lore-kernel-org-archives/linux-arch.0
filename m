Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596337;
	b=eGtcZ+2CztTrcofk1RWlGs7SUfExBjh1oUUIfZ1S7MmrzEpNnIt21DL1rjIz+3D46NPv
	 RPOO0mG5L2TlcLcY1uex0hdhl/8JvkZUOCsCP344BVx8iTjCS35VGFN/CgGfAsAdew4mC
	 Twt9T/ZuhGcsN0z+BXoO6Xiu/pTBXmAKYoc8uCeGYtm6djzwlAwExeXo1srXivKMjYoEQ
	 G1FQAdw/X0Zbq8+t9fqi5w8ZfVntAKE7WchtWCFPTG3R7hZY+Aa3bbHV5FsnTeOD7aPel
	 cINvMwOGcun2FBCL0/U9ug4vWsYFTE7rxfxi9g7aUmItaCB7NfTZyssOJXMKIWgvTRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=;
	b=S6UJTGsfHQbjw3/cIV7qBjZDrqs4d+kRXf0sIeveYk4t1VvFYmJahfJVePYXkJ6hAccZ
	 cRDWO1GBJvAkoFOgFudGznB0Y30P4veu9+Wc7RlASo7YkaoMx/9OxaAYfNH3f9nuyzCL8
	 hHH3tBsVwmpdf764Z9rnZES6Q5mfT127KIS1+IwHB3flxsf4Zqlj26qGg6tIGHX1GHCGG
	 oUGLxt2LjAgY844yzZ7UkdZkx7N59VZBCUpjCzcdXYwTD72Mc3JWuB4sidpXm+dQhbaTP
	 m48A0vipCX4te8jqJ095kA026EGmMHdH6EqMkWJhQpPW96tPWKnYWLWGEWRQVchSlng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jc3bLYEO;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191360A2631
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9191360A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jc3bLYEO
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41b03cd1dcso79611466b.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596334; x=1793201134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=;
        b=jc3bLYEOf8zmAbDpQW600Y71cZu0cU6Muo3eczCRYHwipOI4moDhU8p8wg4+/iCpla
         mhxEg8m9dr/8gSw7EDxBBZHQ/37Krx1ZmZSsGLxY//i+huyTP8XYu9vHxxFoyVyjJ2Uq
         DSTMt/P5pb5qcdJ1XjhJNch8iRYYELnNWK4kousHIsXPJUyzRIdWsdf1xwqdXjrUQjUZ
         A5LGUMjZ73UjIZqwOBo1UdwPFo+CmO1cEq2Y9LLjQYqnjlG4WYwubAHylSD9VeF1mtOV
         bJKgTRn5Un2bSSx1KdI61mKnjA/8oFZ9xKpdQEpdoNbwkCV/KqC+qdDEzVMhq8PqoZKP
         my7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596334; x=1793201134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVHoNG/F+MSh1AvSZ4DFO2pLKQWPL8PGoHBteE3nowI=;
        b=VHiTz0FnY4SXgwfsynviSG+6/ZQdOcii8icQjInWP4aB2KgGiCRhFN62hMYPNBIuWH
         D2FBNMkIXUSOr6XgS2robbm5vATcxa6imFVrsh0PFmtw7DkXvyF8M6oSu+ALdi84RiF9
         TMAJr2QGmamC12z+a67fQFZSBNTOWc1GWGeOYjQDoFFxh1CEvpoYLpDec+WT9JopCBxY
         rffUslZ/t/3dB8eBx812mIh/Z8OXXBjD+9kauWsfEniedxfv9vRE7UwTTHU7jn/VyuXF
         sOn0he/dAcy9Hi28M/HO2JlKLpzyMRDnMCbMeL1CPgYb0gC9D9FLxxdZhAy3llE2+rdY
         UV0Q==
X-Forwarded-Encrypted: i=1; AKwUvByVykNQX2I146t13KMq186EAhbcyHEkYQ12CDO/oV4Xyuim/+y7oE5z0dQ/HTJo1bv6/D8fTxjIY5ud@vger.kernel.org
X-Gm-Message-State: AFq9FYIzuarusVPvUnxHxx9IFyfidUnlTsNmSFUole3jWR9zEK7sv958
	Z4B8SWxuqeT2TIvJTJYDYWfG5UShq32jh9yCGC1ij1nTn20QGExJCYarG3CnUh6PXjML20XS3o+
	eLJOuy/nFy5HXTPdtGA==
X-Received: from ejeck13-n2.prod.google.com ([2002:a17:907:e1cd:20b0:c2e:8317:2af9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c64b:10b0:c46:7fa4:922b with SMTP id a640c23a62f3a-c467fa4a587mr117629166b.33.1792596333890;
 Wed, 21 Oct 2026 08:25:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:27 +0000
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
Message-ID: <20261021152527.375070-5-tarunsahu@google.com>
Subject: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
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

Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
struct memfd_luo_ser and define enum memfd_luo_feature
(MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.

All current struct memfd_luo_ser fields (pos, size, seals, flags,
nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
changes add new entries to enum memfd_luo_feature before
MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
memfd_luo_ser so existing field offsets never shift.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
 mm/memfd_luo.c                | 14 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 371ffd108a79..f0b5235a408d 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/luo.h>
 
 /**
  * DOC: memfd Live Update ABI
@@ -21,11 +22,20 @@
  * reboot using the LUO.
  *
  * The state is serialized into a packed structure `struct memfd_luo_ser`
- * which is handed over to the next kernel via the KHO mechanism.
+ * which is handed over to the target kernel via the KHO mechanism.
  *
- * This interface is a contract. Any modification to the structure layout
- * constitutes a breaking change. Such changes require incrementing the
- * version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ * This interface is a contract. `struct memfd_luo_ser` starts with a fixed
+ * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
+ * fields must remain unchanged as features are added or retired: new fields
+ * are appended at the end of `struct memfd_luo_ser` under a new feature
+ * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
+ * retired fields are kept in place so subsequent offsets never shift. In
+ * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaranteed
+ * present once `luo_feature_hdr_validate()` succeeds, whereas fields of a
+ * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
+ * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`,
+ * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
+ * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
  */
 
 /**
@@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
 
 /*
  * The set of seals this version supports preserving. If support for any new
- * seals is needed, add it here and bump version.
+ * seals is needed, gate them behind a new feature flag.
  */
 #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
 			     F_SEAL_SHRINK | \
@@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
 			     F_SEAL_FUTURE_WRITE | \
 			     F_SEAL_EXEC)
 
+/**
+ * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
+ * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `flags`,
+ *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS.
+ * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature features.
+ */
+enum memfd_luo_feature {
+	MEMFD_LUO_FEAT_CORE = 0,
+	MEMFD_LUO_FEAT_MAX,
+};
+
+static_assert((int)MEMFD_LUO_FEAT_MAX <= LUO_FEAT_MAX);
+
 /**
  * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * @features:  ABI feature and size header for memfd_luo_ser.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
@@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
  *             struct memfd_luo_folio_ser.
  */
 struct memfd_luo_ser {
+	struct luo_feature_hdr features;
 	u64 pos;
 	u64 size;
 	u32 seals;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 64f8b8cb75bd..ea1f4c8cd259 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -84,6 +84,10 @@
 
 #include "internal.h"
 
+static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] = {
+	[MEMFD_LUO_FEAT_CORE] = LUO_FEAT_REQUIRED,
+};
+
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
 				     struct memfd_luo_folio_ser **out_folios_ser,
@@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 		goto err_free_ser;
 	}
 
+	luo_feature_hdr_init(&ser->features, sizeof(*ser),
+			     memfd_luo_features);
 	ser->pos = args->file->f_pos;
 	inode_size = i_size_read(inode);
 
@@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
+	err = luo_feature_hdr_validate(&ser->features, memfd_luo_features);
+	if (err) {
+		pr_err("memfd_luo_ser feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
+		       ser->features.size, ser->features.flags[0],
+		       ERR_PTR(err));
+		goto free_ser;
+	}
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;
-- 
2.56.0.212.g129ede20d9-goog

