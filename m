Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DD2D46CE
	for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2026 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402906; cv=none; b=CRjaeZmHQa8wminUXedfVPRo8mMgIgyorCxk2nJi+sVXzdS7pwtXGwJVZvYJBhlKPYoinf6wsrmwVJMczzTxQrQmzWqj1LbRDjCSGP03xpk/HXQlpsVsc9uIFeteq8g4rbPf/dFBMZofTQPMiLyWgIlFuzTBB/W6bu0nzClv7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402906; c=relaxed/simple;
	bh=ZIZ26mrTUuug6bKSq0P9x/4GvGh5nk8/dS3YxH8CAfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCafUto1b6vp3eGayh77HUpwnrccK89UWaWbdOm3TYMwGZdIa5TOJklUA3c++I44UfeY88HnW3dYWgrTXw9C90PFziMBVHaCovfV9GluxstROjCpHSpQV0ov7l8CntSnsOxhWkH04t5s806JsH0m1u9U3Hnqy6EGfpDdF3w4TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwqaWoKc; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwqaWoKc"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so3749773a91.1
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2026 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402897; x=1789007697; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXIsSz+mo8g74Vp8Vf3mNp3/WCeSzCYf+BKqQ2Sb8NU=;
        b=HwqaWoKcUG6AhIRUEh1WTDNXDD25LQNrceIhMftawpeU3So3kbSQ+nipC65E13GMSz
         EKAGR1T8yaxnWfDJC/1hQhIl5eGPL9jU8Cf3Ym3qIt38YedjhAdr+WDPm0/kZQ0H5/8Y
         xvonU5S7zfd4pP/MfIMzkNRJB0Dk2qpHQWft8kX24QSeGiSD4dTCrhGWbG7gmM7D/tAw
         vZgoCM2/G8kKZFSKGWWJTaweorwRIZAW9ohO9IUf7PxDjJWqMefPRe47jhHeb3HAweT5
         cZgVkvxswIG50EMY6x24BXL8XUBL37bolqduZcwKyb27En7vEq68puD0JQeAy9klB2hg
         1hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402897; x=1789007697;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXIsSz+mo8g74Vp8Vf3mNp3/WCeSzCYf+BKqQ2Sb8NU=;
        b=mLGoOtY2iLgNKxUmKQG57YoNt3mybZaMYAsw9rNQJRlSnAQLMjokyh6olc3D9m5XMG
         z2lZBIvKNUJrH3VMCv1S4JoPDlv6NSlex+7OxcnAX7uM8h9QLPaa1URuzZMby7+TLmKS
         W1hgLzs6Tysw1BxOgUOzHJYUXGeGkINA26gOCiihddcAVb7siQSE5HTKeeZoS34sgtt5
         aY+VYtGsvjbIGfzUe5Lb6eTvLjhneOg7bugzDM7eiYvjqO0Ag5DoHe5ZTYEW9SWOMqS6
         9pCEaMGDq5hkHk3jN+3im3npAbx5fJzt/v55rkqzUWWA+NsJlkAXy7WpcVjrRmmOZejL
         n2kw==
X-Gm-Message-State: AFuF++mjy/47lOqw20DqHeE0nuC4p+j+NaDaJ6Dz6e8ciS0LrCIgEa0B
	+3oyYX3daRfLmtjhP24JRcyK4e4PleBQSxT1z6ETpr26LqlvR2Yp9dNguCUaHIokHdLQQwahgCi
	Fitl6xAygrkC2fk1kw4wiRw==
X-Received: from dld23.prod.google.com ([2002:a05:7022:317:b0:13b:9d65:a542])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d83:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-39aee049464mr14969285a91.15.1788402896637;
 Wed, 02 Sep 2026 19:34:56 -0700 (PDT)
Date: Wed,  2 Sep 2026 19:34:50 -0700
In-Reply-To: <20260903023452.721732-1-loganodell@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903023452.721732-2-loganodell@google.com>
Subject: [RFC PATCH 1/3] luo: Move to feature flags instead of compatibility strings
From: Logan Odell <loganodell@google.com>
To: arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org, 
	pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, maz@kernel.org, oupton@kernel.org, seanjc@google.com, 
	bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, kevin.tian@intel.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"

Define a 128 byte header that can be used by all live update serialized
structures. In this header, we reserve room for 64 features with
supported, active, and required bits. Update the top level luo struct to
use this instead of compatibility strings. Previous versions of the
struct had smaller sizes, so add a minimum size check to avoid
collisions with older kernels.

Signed-off-by: Logan Odell <loganodell@google.com>
---
 include/linux/kho/abi/luo.h  | 74 +++++++++++++++++++++++++++++-------
 kernel/liveupdate/luo_core.c | 44 +++++++++++++--------
 2 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..0a7662a0cf9a 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -13,15 +13,17 @@
  * kernel. The ABI is built upon the Kexec HandOver framework and registers
  * the central `struct luo_ser` via the KHO raw subtree API.
  *
- * This interface is a contract. Any modification to the structure fields,
- * compatible strings, or the layout of the `__packed` serialization
- * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the relevant `_COMPATIBLE` string to
- * prevent a new kernel from misinterpreting data from an old kernel.
+ * This interface is a contract. To ensure the stability of moving between
+ * kernel versions, any changes to the structures should only be additive
+ * and should utilize the feature flags to denote the supported, active, and
+ * required status of the feature.
+ *
+ * Features that are entirely optional can be added with the supported and
+ * active flags both asserted, and the required flag cleared. Features that
+ * require that the next kernel supports the feature should only be added as
+ * supported to allow compatible transition kernels. At a later time, the
+ * active and required flag should be asserted.
  *
- * Changes are allowed provided the compatibility version is incremented;
- * however, backward/forward compatibility is only guaranteed for kernels
- * supporting the same ABI version.
  *
  * KHO Structure Overview:
  *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
@@ -30,7 +32,7 @@
  * Serialization Structures:
  *   - struct luo_ser:
  *     The central ABI structure that contains the overall state of the LUO.
- *     It includes the compatibility string, the liveupdate-number, and pointers
+ *     It includes the feature flags, the liveupdate-number, and pointers
  *     to sessions and FLBs.
  *
  *   - struct luo_session_ser:
@@ -58,19 +60,65 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/bits.h>
 #include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
+/**
+ * struct luo_feature_hdr - Feature negotiation and versioning header.
+ * @supp:     Bitmask of features supported by the producing subsystem.
+ * @req:      Bitmask of features required for safe deserialization by the
+ *            receiving subsystem.
+ * @active:   Bitmask of features actually active/used in the serialized payload.
+ * @reserved: Reserved for future use.
+ *
+ * This header can be embedded at the beginning of any serialized structure to
+ * provide forward and backward compatibility via feature negotiation across
+ * live update.
+ */
+struct luo_feature_hdr {
+	u64 supp;
+	u64 req;
+	u64 active;
+	u64 reserved[13];
+} __packed;
+
+#define LUO_FEATURE_ACTIVE(s, f)		\
+	do {					\
+		(s)->features.supp |= (u64)(f);	\
+		(s)->features.active |= (u64)(f);	\
+	} while (0)
+#define LUO_FEATURE_SUPPORTED(s, f)	((s)->features.supp |= (u64)(f))
+#define LUO_FEATURE_REQUIRED(s, f)	((s)->features.req |= (u64)(f))
+#define LUO_FEATURE_IS_ACTIVE(s, f)	(!!((s)->features.active & (u64)(f)))
+#define LUO_FEATURE_IS_SUPPORTED(s, f)	(!!((s)->features.supp & (u64)(f)))
+#define LUO_FEATURE_IS_REQUIRED(s, f)	(!!((s)->features.req & (u64)(f)))
+
 /*
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v5"
-#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
+
+/*
+ * Bits associated with the luo_feature_hdr values.
+ */
+#define LUO_FEATURE_NUMBER    BIT_ULL(0)
+#define LUO_FEATURE_SESSIONS  BIT_ULL(1)
+#define LUO_FEATURE_FLBS      BIT_ULL(2)
+
+#define LUO_CORE_FEATURES_SUPP		(LUO_FEATURE_NUMBER | \
+					 LUO_FEATURE_SESSIONS | \
+					 LUO_FEATURE_FLBS)
+#define LUO_CORE_FEATURES_REQ		(LUO_FEATURE_NUMBER | \
+					 LUO_FEATURE_SESSIONS | \
+					 LUO_FEATURE_FLBS)
+#define LUO_CORE_FEATURES_ACTIVE	(LUO_FEATURE_NUMBER | \
+					 LUO_FEATURE_SESSIONS | \
+					 LUO_FEATURE_FLBS)
 
 /**
  * struct luo_ser - Centralized LUO ABI header.
- * @compatible:     Compatibility string identifying the LUO ABI version.
+ * @features:       Bit mask of supported and active features.
  * @liveupdate_num: A counter tracking the number of successful live updates.
  * @sessions_pa:    Physical address of the first session block header.
  * @flbs_pa:        Physical address of the FLB header.
@@ -78,7 +126,7 @@
  * This structure is the root of all preserved LUO state.
  */
 struct luo_ser {
-	char compatible[LUO_ABI_COMPAT_LEN];
+	struct luo_feature_hdr features;
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..6add1ecc463f 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -107,26 +107,37 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
-	if (len < sizeof(*luo_ser)) {
-		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
-		return -EINVAL;
+	luo_ser = phys_to_virt(luo_ser_phys);
+
+	if (len < sizeof(struct luo_feature_hdr)) {
+		pr_err("LUO state is too small (%zu < %zu)\n",
+		       len, sizeof(struct luo_feature_hdr));
+		err = -EINVAL;
+		goto out_free_ser;
 	}
 
-	luo_ser = phys_to_virt(luo_ser_phys);
-	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
-		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
-		return -EINVAL;
+	if (luo_ser->features.req & ~LUO_CORE_FEATURES_SUPP) {
+		pr_err("Unsupported required LUO feature (req: 0x%llx, supp: 0x%llx)\n",
+		       luo_ser->features.req, (u64)LUO_CORE_FEATURES_SUPP);
+		err = -EOPNOTSUPP;
+		goto out_free_ser;
 	}
 
-	luo_global.liveupdate_num = luo_ser->liveupdate_num;
-	pr_info("Retrieved live update data, liveupdate number: %lld\n",
-		luo_global.liveupdate_num);
+	if (LUO_FEATURE_IS_ACTIVE(luo_ser, LUO_FEATURE_NUMBER)) {
+		luo_global.liveupdate_num = luo_ser->liveupdate_num;
+		pr_info("Retrieved live update data, liveupdate number: %lld\n",
+			luo_global.liveupdate_num);
+	}
 
-	err = luo_session_setup_incoming(luo_ser->sessions_pa);
-	if (err)
-		goto out_free_ser;
 
-	luo_flb_setup_incoming(luo_ser->flbs_pa);
+	if (LUO_FEATURE_IS_ACTIVE(luo_ser, LUO_FEATURE_SESSIONS)) {
+		err = luo_session_setup_incoming(luo_ser->sessions_pa);
+		if (err)
+			goto out_free_ser;
+	}
+
+	if (LUO_FEATURE_IS_ACTIVE(luo_ser, LUO_FEATURE_FLBS))
+		luo_flb_setup_incoming(luo_ser->flbs_pa);
 
 	err = 0;
 
@@ -162,7 +173,10 @@ static int __init luo_state_setup(void)
 		return PTR_ERR(luo_ser);
 	}
 
-	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
+	luo_ser->features.supp = LUO_CORE_FEATURES_SUPP;
+	luo_ser->features.req = LUO_CORE_FEATURES_REQ;
+	luo_ser->features.active = LUO_CORE_FEATURES_ACTIVE;
+
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
 	luo_session_setup_outgoing(&luo_ser->sessions_pa);
-- 
2.55.0.979.g7e5102b832-goog

