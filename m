Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578192E2840
	for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402902; cv=none; b=PkD+uYy2BOgmaHcaFH3rfuxz7dFiywEEVG37OTbC4mfnBm8oF2gfflPtP2kT5vUzky8f2+cvz3PEAuoUGbk3NQCqAbhpNtwLxoVjILXLa+WaZVupoY6Z3Q+Kdxspmox8pguV6QHGz2dmoTUS+xgg5g4hsnm+MqI1y6eRUbj/0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402902; c=relaxed/simple;
	bh=KttI8yN3SEE9knj1xRs/FNrG5jE/gzLZlVVCanD/Yjg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MlUzXIi/oXLgbbG9pxtpLNb1KNmNnma9ywBDoLu94q1pZTVYHBN+/uZqj4XYdJm1XfKwZMuOHs6jwGVaUBPshlTUHNA9Ug1xW5euylBt+bFTVf9CHw4w58jO1zTlUYJIC/5k7ZrrpRRo2L4mewVaez8GZxZySjuUCDL//wO2uxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKRSKjDP; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKRSKjDP"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3182893a91.2
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402896; x=1789007696; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=JKRSKjDPVk0FFsbYxUN8rh23atvO0BGLo2l3Ks8shrfBJHKyupH84uaTVmVhlhgbqC
         18LH/IN4BB17i9S++NQrSkJeh9KO1YPa5D9KUQAK1/bpwfRSdiJx1MbpQ6k/L/uSr2At
         4VILdEOzvdycnbiae+QyQaM1fYRQv74kqDgQufzjn3PnkJ8/34nk8O/sumZX0wLMYMES
         YsNohw0fzbT0Ns4S60MeuyjFyAVFi+XdrvuMAw/xlJhvQtlN4y+0aA8p4tAVY7108Tjo
         hUL9t8/h0MrjaL7b6p9PxycrKxAYjK0oI08YxCuv4conWs/RU7eIbr2a18cxuPWDlVtQ
         5EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402896; x=1789007696;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=KUluk+ToRd8vTEU8///tM7IngaekdX1t9CGbVHgt2BMvQtxy3u365fY4+4xRmZX6JI
         NfG+6LXQzycGz5UGg1lcJUvB7Cjpk189bR9oDY8R9WJyL4r+/Pst/5sghJgCpbjgfBk5
         0WUfK7bHD43XPKQo52p2JRNzcnvmW9or41c9pANA0YO5dkeaHOa3aJUCUw9g9iUnNWnq
         Ug8aBBJwMmi28fkG/8qVoGgCns768oPnazzwVhMbABai3P8klrRhKOeQhi4Xv5QnSsHB
         NvQb1smyM0PvY6SsS57pDnN24YFF7v9xalZIeds7HDmC1CTBt1u7lms0n39HiaNZGKTv
         RR+w==
X-Gm-Message-State: AFuF++lkDpxowaghd+2h1JYTXMUKIIL4S2KUjcI8k3dBDCLB/sVue402
	29UU4Jv+InL61S8b3XN3IZLLveWqzwEuXSYpipzCVkdCPfwSn+F1aq/icTi9pwdNcYO0gZ2Q0oP
	f4EgCfXvblSIfT2ClUhM9Yg==
X-Received: from dysc26.prod.google.com ([2002:a05:7300:3b1a:b0:332:2edd:e13a])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d85:b0:398:9c00:29f0 with SMTP id 98e67ed59e1d1-39aee249bd7mr14082963a91.24.1788402895806;
 Wed, 02 Sep 2026 19:34:55 -0700 (PDT)
Date: Wed,  2 Sep 2026 19:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903023452.721732-1-loganodell@google.com>
Subject: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and memfd
 ABI compatibility
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

We're including maintainers from all subsystems that currently is or
will be expected to participate in live update to ensure alignment on
the path forward for compatibility.

Currently, Live Update Orchestrator (LUO) and its file handlers rely on
monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
validate ABI compatibility across kexec live updates. Any modification
to serialized structures requires bumping the version string, which
strictly breaks compatibility between adjacent kernels even when changes
are additive, backwards-compatible, or optional.

This RFC series transitions LUO and subsystem file handlers to use
granular feature bitmasks instead of compatibility strings. We replace
the compatibility string with a header structure that includes some
reserved space to define the features that are included after the
feature.

We include 3 bits of data for each feature: supported, active, and
required. When the supported bit is set in the next kernel, the previous
kernel can serialize the feature and pass it to the next kernel. When
the active bit is set, it means the previous occurred and the data for
that feature is valid. When the required bit is set, it means that the
next kernel must have the associated supported bit in order to be
compatible.

If a feature is required in that it cannot live update to a kernel that
does not support the feature, it is expected that the feature not be
active or required initially. This allows for an intermediate upgrade
path.

Overview of Changes:
1. Define feature header and migrate luo_ser (Patch 1):
  - Introudce the feature header with the supported, active, and
    required bits.
  - Replace the luo compatibility string with this new header.
  - Validate the preserved size is at least the size of the header. This
    breaks compatibility with the old way.

2. Export feature header information to vmlinux (Patch 2):
  - Adds a .liveupdate_features section in vmlinux containing
  - Adds helper macros to export feature information for a given
    subsystem
  - Export luo's feature information

3. Memfd Handler Migration (Patch 3):
  - Migrate memfd to use the feature header instead of compatibility
    strings

Logan Odell (3):
  luo: Move to feature flags instead of compatibility strings
  luo: Export feature support to vmlinux section
  luo: memfd: Move to feature flags instead of compatibility strings

 include/asm-generic/vmlinux.lds.h |  12 ++++
 include/linux/kho/abi/luo.h       | 114 +++++++++++++++++++++++++-----
 include/linux/kho/abi/memfd.h     |  41 +++++++----
 include/linux/liveupdate.h        |  22 ++++--
 kernel/liveupdate/luo_core.c      |  60 ++++++++++++----
 kernel/liveupdate/luo_file.c      |  28 ++++----
 kernel/liveupdate/luo_flb.c       |   2 +-
 lib/tests/liveupdate.c            |   2 +-
 mm/memfd_luo.c                    |  40 ++++++++---
 9 files changed, 246 insertions(+), 75 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

