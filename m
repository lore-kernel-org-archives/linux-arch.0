Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52E3DAAAA
	for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654589; cv=none; b=o1c0gFYjA5QVtfiwMfIzZqWK/9Sb+6YlSGdkQ06Pe1o3GRUhw66hIPm8Q3vu9ItLvTm+JKGE+146F2yu1CX2jupuidnnz8PsJOGo7HFWiDwhb361oMIapIyJJyhcv2HdKf3URVRt4cXwtQ8xBONaTaPYdfvM7iH/N81QNI1gK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654589; c=relaxed/simple;
	bh=ofjMK+frBLaew2v4NwVs3dlVJMs1NzYJl7FaeQqAgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAdoOSpVKzuYxC0kPbuw9t2Zs0dZOXihhxhWLk2z6FtyUHM2furWggC3m7KYyp8H/jiU/QBSLpFN207wNhiKiDAtSseUDEQRp3P+hOJVIYO+Zt10xSwCI5kzJctDOhDPqcQI6R8c1FYs+yBEn6Mak85infAB8NMXfsJbEkT/3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TdIlkCp7; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TdIlkCp7"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2d91ff7d9acso9604425ad.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654586; x=1791259386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=D69goZhHXiFJrCMemr0LkrOfVISK1BwzNnkP15pPfp6SdyKOENzrzDa3bU71iL7pjb
         i/0LDkKHtTdcTfeEPxA1jrezgFXP2b6Ofy5I2yAj1mDadc8gj3TG1TBGhxD/rkPQJ0KV
         K/Aq2oO7B1NlGmR+i8qQ/hn4k9i6gaezSAf4Vnj9yS/ga1+oL2EUsriZ/nwkbyiA2e9x
         XAe0LaGByazUuCdo0vREcifX2F/q5+ASPU+JkZRlKvBsfsRFNQzR5XSVeDjQW5LdbKRK
         mF5DHF0seDyVRWtBkqb0SQnMQ5wVBO2rT+hV8J1p8XmzAfh1sTjOeD0s/LquQGaLlpYq
         06jQ==
X-Forwarded-Encrypted: i=1; AKwUvBziGFbPQ4okit69+6qrmUYU36zNgfLYcZgpnFDu9uQmBTkUSdREvUjslIjdTpBBh25D/I+fiEgYR70D@vger.kernel.org
X-Gm-Message-State: AFuF++nA/aUjWhASFSDcKwH83FcYQBL9J8B72q+GC8TyPT/o0l88zlnC
	o0owGk2myHJqOGP9wLDTdMPpIy4/GlNUMHxRkRcSJMmybXqZEOgDMV7Dpw61ldY2KnCKY6ir4ut
	6NkFOkfuR6FyOu0xqJocp/3ls1tt9yH4KZi8cdB9nPs9ILylhbabNcQggDlJXPA3Qog8P48hPw2
	ScqaX9pLfGp3xVXgv019O7Tl/gYxNNULqgScmDthJaylGbAUTAjlqmW8MhwczzaQp5JVgKAyWmF
	zCbyXNzLhB/gA==
X-Gm-Gg: AYBFou3w4zZjMzWBdalQ1jKpyMaQ2Y5Ib5bKO9sLWQkZlCUr/bcPWtYdshxP2iuozh0
	M8SYw7csbZlkgc2OsbI26/dljwEdPCZQNvvLY/QoNSMlZnhbRT1Y9qTYAfGNA3Mg7Gk4idQsfi3
	FiNhjLMMirV0VoMKpAjMcZjQrbqNCYOuWGVS0+PiKRReyGmhHuwfXrJEbu2jqgO9aHsTtaVz660
	mVwrx+Z0+k0NzjK+EONUo2mIRZfmeJSkf53BJWodbJILJNOheJLaTMnA4VIlGrrL77YRtp+Ca96
	IOaIzLewwaAo9JWUeCjATS5MYUrc3uMyA4XuyvM0Y2R6PGNNIU2J5wsgzXSUZnLNqZXn7s55slQ
	uUYaqIiUUityECdtpmt6s8HZPIjBnCxRlwbkmCPNkCFpVrPM5dUHhwftBc7X8n6cnQpM6BByr4r
	ilE2q6EtP6OQmM1QUT/H84ZWnmsIyk+khZLZE=
X-Received: by 2002:a05:6a20:7fa3:b0:3de:7701:d15b with SMTP id adf61e73a8af0-3de7701d778mr2407454637.49.1790654586012;
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7902474b2sm6989929a12.1.2026.09.28.21.03.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34344599f01so1673329eec.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654584; x=1791259384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=TdIlkCp7hvOZ7O4to9VD/ktGFpklNkIvzV5hXPGlwMBHYLBF1S8nqsiD3o3M2MC8Ln
         jgothhzf86blwo/6n/U64q6Cx2F+TB/QNUcS9J5/m0IokDf99Vtb+RhGwwpy6VybDFM8
         cTtxrXCmsP8aG8USh0u4j54Q5XvnoQVsK9wxs=
X-Forwarded-Encrypted: i=1; AKwUvBzYdcNyEPTU7YUP1ee/INCryUPn8dYw5yySGEiLEuJj7b919abPRZwVv0DoElRTUZ9+bDVJSE8dGPFP@vger.kernel.org
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268567eec.31.1790654583899;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268522eec.31.1790654583107;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:02 -0700 (PDT)
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
Subject: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
Date: Tue, 29 Sep 2026 00:02:49 -0400
Message-ID: <20260929040256.543767-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware publishes its per-CPU steal-time GPA without first sharing the
storage in encrypted guests. Following Kiryl's review, this series moves
sharing into early per-CPU initialization for both KVM and VMware.
This replaces the VMware fix from Bo Gan and Alexey Makhalov:
https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@broadcom.com

The common helper uses boot-time page-table allocation and preserves
initial contents on AMD and TDX. Conversion precedes buffer registration
on SMP and UP; failures stop boot. Encrypted guests use the embedded
allocator, warn on percpu_alloc=page, and never fall back to page mode.
There is no driver conversion loop or readiness flag. .bss..decrypted
remains outside this series.

I interpreted the allocator requirement as guest-specific, so both it
and per-CPU conversion use CC_ATTR_GUEST_MEM_ENCRYPT and leave bare-metal
SME behavior unchanged.

Two corrections to v1: its isolation claim missed UP, where ordinary data
could share the decrypted objects' page; patch 1 fixes that separately.
TDX's vmalloc constraint concerns private aliases and adjacent accesses
through load_unaligned_zeropad(), not just GPA lookup. This series removes
the unused declaration macro and adds explicit SMP/UP section boundaries.
I have not carried the v1 Ack onto the revised patches; renewed review
would be appreciated.

Tested on VMware ESXi with SEV-SNP and TDX guests, and on KVM with
SEV and SEV-SNP guests, using SMP and UP kernels.

v1: https://lore.kernel.org/r/cover.1789488039.git.zack.rusin@broadcom.com

Zack Rusin (6):
  percpu: Page-align decrypted data in UP kernels
  percpu: Bound decrypted storage for all x86 encrypted guests
  x86/percpu: Require embedded allocation in encrypted guests
  x86/mm: Provide common early memory decryption
  x86/tdx: Support early sharing of kernel data
  x86/percpu: Share decrypted storage before guest CPU setup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/coco/sev/core.c                      |  16 ++
 arch/x86/coco/tdx/tdx.c                       |  32 ++++
 arch/x86/hyperv/ivm.c                         |   4 +
 arch/x86/include/asm/mem_encrypt.h            |   9 +-
 arch/x86/include/asm/x86_init.h               |   4 +
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/kvm.c                         |  35 -----
 arch/x86/kernel/setup.c                       |   2 +
 arch/x86/kernel/setup_percpu.c                |  14 +-
 arch/x86/mm/mem_encrypt.c                     | 139 ++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c                 |  12 +-
 include/asm-generic/vmlinux.lds.h             |  19 ++-
 include/linux/percpu-defs.h                   |   7 +-
 14 files changed, 247 insertions(+), 51 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

