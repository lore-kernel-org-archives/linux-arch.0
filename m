Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6B3DAAA9
	for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654599; cv=none; b=Ui0VwAq92W1RH6cqF5WuRRdKrQ2+3/Ev2EPYGksvDp7pw7mY0KMZyQRIdSFxhLDyy7KGiHSJ++go1jY9QZBncjPNkDckUmveVsQ6vSTkRNyu5B0E9Uvq9PKXxElvY41159M1GF971Vr+Gxg2KVNTg3egIK83I10JysOMIyYQWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654599; c=relaxed/simple;
	bh=hwzN7aNlJ2wxS9ZWnQFgLPxc8hv3AZhs4ribMUFVqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfMrP/W3lRiKJuquqt1KtLJynLvWVPed0FxhoILWCVBV9OprQQHdhXa9Rf38q1v8DiKcFObhS4uVpEhbGC41yx15Bx9bRT2cv/ORL5SEhEo+ZIZ9/4Dnk5t7mGj/bmp5gBBzEj2haB3KYbuaJT5aQCERSxr4lx/wgoJGXDcUFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J2pFgVBZ; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J2pFgVBZ"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so403179a12.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654598; x=1791259398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=grTcVMW+5dpG73/M2B3ISc62nMnTel/mTCtdYg+HOoX/4Z9uOeuMuWzIQfTURCYAda
         oen+Aq3CI/nbAS2hJfEWec9oqV2OgBD/Ir/eEejX+3INSDiBNoKbHRfOtElmNrXfiFE3
         giNkq1x/XVRO/KRHoBGvNBwetCysAMb1kekGraRbuuvjm0PHQcJbfu9H7OaoA+Dqfnhq
         KAbeqbakyvSsyXjOTvZ6UndRussuivZShPzIvPGidUXzYctyUs9V2IWxA30/pQHSR+bC
         kTjG6buySSuWCxp/OMnaqPinc/mGbZ2zIjYkbRr+MSKF+Dta2F9V+jAkEPd+0T5bOsl1
         g5oQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqCt2iC4sCXCO8yslF72Bc/aV8F5iGcDrxsxinpxzzyH4SMiILTsCtelMN/0Pf4Qwz6qnV26Q/TmrA@vger.kernel.org
X-Gm-Message-State: AFq9FYI+KCakUpU7lvdF/3reP/vE8Ccivh52vxf37812urcAL3jPMo4z
	z3rqnRcS12qcGjbDLe4xpMLcjSqBDzzrnW7Qr+i8IhX7iydXXRtn5PaipHJqsHb3HHHtYs7dEbt
	XlUnrWV5tQhBZNq0aYgACHONk+24YdREeep4Spfs2I9tJWCzOOpcN9WZZVG0BXCa7kyyRGdKkrX
	/MPzKk3760gaAWiTfR5S4U0DgyhAOKrQPC6qsuC+k2qEkoHboQVKhfJzUrT0qrHdPRuz5JmlxX4
	0iS2PHbt+m8qg==
X-Gm-Gg: AYBFou1eQb1cPaRs6i3RVyqIAYT0YGsx7Ry1QyFubNyZFldCI+5rbmC+NQ+wZcGNPOO
	vYbg0de1jmJoJyRwB/EAPzZxZKr7YOpuBpcHZA+hDf23+N20DaCtYlh3z/BAnvzPwyPgFCgy9ty
	yJv3aUv5zZ/4h5Qu+Et/rINerDU8GnUAcmfKBiDSpacwA1iyutPzdW2w8sEh9JqKqLB5+naPlKm
	Gz6cSryG4qkEl3PzEzUmFEDzsEDqsVdsJl7MaXk2CQwjfW6Snkof+qa88+CgIH2967MIhUIGGlW
	oSyV94fqabwhXbg6t2OpuFFioMS6ETu1rinsDJsEi9rM7+cbDJZlMRgJ68qy7mK48Rfyge7D7Se
	ly6J16ZgKiQ19M/FLrL+XICE5JLnJ9spacRtutjeD58JyAII31kPUb3oFq8ssPZhKBlFiUyClXx
	5sge6pw1tjjOyG/KAEYCERMlWdkbK5X9qN8AE=
X-Received: by 2002:a17:90a:e0f:b0:3a2:b246:be70 with SMTP id 98e67ed59e1d1-3a2b247915dmr2212666a91.22.1790654597338;
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a497ef6aebsm1000096a91.6.2026.09.28.21.03.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so14196757eec.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654595; x=1791259395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=J2pFgVBZHM/fAYXBIqK0/AZxOq/6YSGIL/qKx8D5ACk4THDMXEn+y7CpCzCt8uAWke
         pNQfQ3sU+6Kte5+o+X5ITV615SfqaNQ48T1lR1rglF81HJ+VpKIsc+yJM51g9tVqknPx
         w3kg3JpDvpGwrexpl/4noHhn+sLyrJTgrO3HA=
X-Forwarded-Encrypted: i=1; AKwUvByomh3NOA2Ak0BGRp2ZiA671Sv2cgpkDKkz8WnB+cKFKbKklzUJLp1VduuduB2GbjdCGOiImpKrjsQS@vger.kernel.org
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863803eec.8.1790654595148;
        Mon, 28 Sep 2026 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863746eec.8.1790654594365;
        Mon, 28 Sep 2026 21:03:14 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86 encrypted guests
Date: Tue, 29 Sep 2026 00:02:51 -0400
Message-ID: <20260929040256.543767-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
definition and placement, and provide page-aligned boundaries so the
architecture can convert each CPU's whole section before registration.

Define the boundaries in the SMP template or UP data as appropriate.
Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++----
 include/linux/percpu-defs.h       |  7 ++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 64bc2bfdd2ec..145fcdbbe9db 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,11 +368,13 @@
 /*
  * .data section
  */
-#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#if defined(CONFIG_X86_MEM_ENCRYPT) && !defined(CONFIG_SMP)
 #define DATA_DECRYPTED							\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..decrypted)						\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define DATA_DECRYPTED	*(.data..decrypted)
 #endif
@@ -1022,11 +1024,13 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..percpu..decrypted)					\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define PERCPU_DECRYPTED_SECTION
 #endif
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..fdb666a1b4de 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -169,13 +169,10 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
- * Declaration/definition used for per-CPU variables that should be accessed
+ * Definition used for built-in per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-#define DECLARE_PER_CPU_DECRYPTED(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
-
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
 #else
-- 
2.53.0

