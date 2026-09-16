Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9453BB69D
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535161; cv=none; b=lGdBG8W9zCgHWJASKs+rPOi1wsr316K6YTdCU6klXnqfHZbE5Si/kK32NtqFGg3EFpF5HzgbFGsMK4XkgujUhvEay0QXydH2Dfl6Pl7lQJ0Ogf67UpN01MmC0/uqZRDa/jTN4xQLem9lEZfm8OjRxNXv66iWDxno8zpnXeS4baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535161; c=relaxed/simple;
	bh=LWc2s4qZvBb3TJVfltvRwFaklDcNXyLXGRlUr4C/OwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E10AucuZfy4arc1aZn0dGV0j9IS968P6eCl7Q8zIcXIk2dwxBFMZddKmCQ4+aKGtUGnz14pFNwd9u9g30EB9aj85cVnZDqtoGzd/9HowxHMWSv5/i4dXVkhsagF9CEuIP4uTUrBNkbe/rSYIqx/bzVDdcDcGKG/n49wrMFOOC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AgIxbS4l; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AgIxbS4l"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-39de8addbe4so1133364a91.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535158; x=1790139958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=knzJnCXrxQ9A7jrRpTQqZju2AiwJ/yzcy8zTXQGpCEY+JjE+tUUEQRpNj+OAmVfqQq
         gwXYBuI+YrIp7WApTo647eJswGcgupQXiPcCxMBnyMdwZU6wrmdNZA5gaaCiN7X/uRQo
         Slphj1gz9Q4ZF/nSxDo/UFosq6ou27bNUbsfc9PBFH4K3r+LQmijC0GmRxSo3xuK3Mpc
         LYjiL6X+JUDFS3akoQY8eHTDIsNB+ZUL1WmNp57b52nrlMIQo26eVz0mVEozUinoxyaU
         5OXqQXt4cA6ArGwDo2D9sXqcRs5aizaML8hmMqutDXYZaG6eB6U6oQGQZKfrrp+xTOvB
         CS5g==
X-Forwarded-Encrypted: i=1; AKwUvBxDYXtY9KsHYgeZj/tJo0tp6mfa+7BdJfQRRRB2rQQpYl5KuxYRWAEadcp0wIG1FdGjhyMLnbXRXBEx@vger.kernel.org
X-Gm-Message-State: AFuF++nQbSsDD0Vvpw53zY57v7wGZnKtLIddDspIaiXFrb95G3BWaS1s
	cuXlSnJnyZuB0HHLuuLk1j+ZKS3kxTy99Q70CR9V1prbC6cVOP/IBFMCrpryo8BH1UPbzFDVHfZ
	fmYr1OazRhp6QBwbBxzGept+Uu9HkJf6rvHaTxuowL4eYQs+16cIKSt9eqeR5UHWG5/eFnxuQSF
	0QbavyAZYyDIoGuEE4d6UJ0JpNMfYgKrHVTVbIFv5Tmxa93oaagLtGjykk29YQXyevyAyWM+6Pv
	Qr+Ka59kODQ/w==
X-Gm-Gg: AYBFou03W3Qvy1IWoVmdwOJT7KBKRgBU5EwDRYsezZbGJfcbwQd0n3hcF9kOCUz8+E2
	97VPRe1i4f62sCNlg+7zwccXRWJ/GqnbNybjFessJyqc6/qASD11WF3G7cCzQHAm8hH8yp9NMlM
	C6tVl0n/3+Hiyhtzr/RyfV1lKlKk/st7sDkRwAo/3+JJL/0YeAg91kp8LQLksvyyF6IrJcmoaA+
	lat94Sm8jmKCcKBpoa0XJNBGdvA05LNQ4O1IvBe/PDEcq5AFlz3UHI4cYJLrVVSJFR9Htf2pZ1A
	sMO9YhlV5hIcOUjvG+V5898jMa5zNHwZSLFYA8lpegWOHlbBaoeJy5RorGeYKhI+yco+AXGISk/
	r/GuCQujUWfRMBn9NEvQ4fnbi9aY5cqBglQlz3sXbRH0FghF0O22ZcK6O3fArfMjJzmyCINCMOe
	j2oon3IbY0CnEeYBfHuymdjihd1tWrFcdR
X-Received: by 2002:a17:90a:1c97:b0:39e:1fb6:9659 with SMTP id 98e67ed59e1d1-39e1fb6994cmr1991120a91.22.1789535156175;
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e1b3efe54sm799802a91.1.2026.09.15.22.05.55
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso6614755a12.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535154; x=1790139954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=AgIxbS4l+sMGzOQKUymNIgMNamCZBEsk5FlD0p+PGzS5LljSWOGjmA8Qbd3KpX/tGK
         Ga9JsNwG9oSpFcbKpB7z/4M7GGHaU04iUlAhCCTyIFsJLRXbRZ7XHhtNcme5T5sNuCN0
         +CiXxYnC2nhU2Cy2+vrjWZjf/EgUCPiN6Zb9I=
X-Forwarded-Encrypted: i=1; AKwUvBxPjlwBq/ANgQSqjoQrn26I4KTKS2Vkgdq0Z7SGyHBgwHONF525hTX/vt4UTnfw9Db7vN9+uWUP/kax@vger.kernel.org
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773493637.17.1789535153990;
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773437637.17.1789535153567;
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 1/2] percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
Date: Wed, 16 Sep 2026 01:05:39 -0400
Message-ID: <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Decrypted per-CPU data is gated by AMD_MEM_ENCRYPT. With
INTEL_TDX_GUEST=y and AMD_MEM_ENCRYPT=n it falls back to ordinary
per-CPU storage, so converting a variable to shared memory can expose
unrelated data on the same page.

Gate the declarations and linker section on X86_MEM_ENCRYPT, which both
AMD_MEM_ENCRYPT and INTEL_TDX_GUEST select. Existing AMD configurations
are unchanged.

Keep the decrypted subsection page-aligned at both ends. The per-CPU
template and each allocated per-CPU unit are also page-aligned, so page
conversion cannot expose ordinary per-CPU data. TDX-only configurations
may need additional space for this alignment and isolation.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/percpu-defs.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..1448e791773e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1013,7 +1013,7 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..decrypted)					\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..54ce1442d918 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -172,7 +172,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 
-- 
2.53.0

