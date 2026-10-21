Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596332;
	b=Ud6zCjW0IJaAYo4bYe7SkHXLDOjAZAqOl1v51FcfjAaCfeoXTN1T2rOiZ0QnpVz7khF/
	 xwHDM9xvHd2Z9bGOWdTA+aI3h1aWyU3MOhKqMJPqhNq7jBt91glIgIMiMMH8YzXgTOf6d
	 yaN4I/0Ucb4q2vxmeXo7AfpoyJMRyoRObzZjlFbjXXviVmcUzKaIe/pQLMUBo+K5smae6
	 dR38i3kmyOhClqG6YZtAtijl1vSHvk2bOIdV4nQ+e4F3ZOC0w+0uwOJVI1nGWsdr1iaA1
	 59SO7Tjwap6IptYNq0g9isE6s+QXRQjtbiSJaMXHOyzqc4M8B0b6CYRuQOPodEMz4DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=W0oLRP7RmrwK+s1WyDoN9zSSlBczsPl1G7flMYO8vs0=;
	b=lKHWyBoF55LCle1hUbBF0JHHZqrernpu0ijuf1xOjZS5h5uNwW35YuZeEDaEN9HteD3I
	 yC7VM1HqyNqNOOWO0Kdwvapsh5az8e5oJjJqvothW3dG85j/RFME48RrmpbA4oY6cPpWB
	 PzJK1P6iz+AKy/8QllRRQe+dnBQySQGnXbLsDeEuLDran8rvroVW/FYX72++SK2G7F79N
	 oP3OwHZQa7fpoHKBSzzVuXnWsk4FYpogsw77dfXFvHtVHbpvNTPhwNSQeCG0f9PrmV7Cz
	 JXsKaZKIYAxAr8R5Jy7veEWIb25SdJE9imfO3oQoifs23+EkAU50u00OGv2dG6cFVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KnNR8tlw;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC37606A325
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 15:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC37606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KnNR8tlw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293e604f0eso78283366b.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596329; x=1793201129; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W0oLRP7RmrwK+s1WyDoN9zSSlBczsPl1G7flMYO8vs0=;
        b=KnNR8tlwheC0ksiXfol0xmrswUPXdERE2pUiy4ruJaJMpyEYFj0+uSjn5DSvYMi26+
         mLuQV3DBerh7Fa4DBoR0UWT95tWppxJ0nl4N6GE7ZVpyVo+jc9BfOGSlnjr9jBUjio+0
         8iktvpbm9H6+6ewiqoOeWQqgHAUZEwH3ppL+89gZKyA/Ep2aaszHzO4JGwtT9ZfnbdYu
         iziEBgFuZyXk5DtzLItDBuDBm95Kb87Mhw6c98J4xA5kPDISQL+lTxmbj+fqjzNxkkU8
         bjh9Nze1LkabYykX7f0FJ9LUE687t6Dzxgd/QoYD2HyG+rez/8ryGik4hjqcL9YOgtrX
         J33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596329; x=1793201129;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0oLRP7RmrwK+s1WyDoN9zSSlBczsPl1G7flMYO8vs0=;
        b=rH/qPBJBCSkau8iBQ3YwDi0aAfFCrAgTRTkDnp7wFNRygxJG1TMbVP/IWG8zDihfaE
         U2sR4oA0Fmj+j3dThA0KTEqZNvW/AKr8W7avsJMOFij2E88LGs+bdNrpoCQFa1L/T9BS
         ePMJEWhbqSnB3Pv4a2ywJfX57PSEtKuuPlBGgS2bTnxI4C8a4/AjbJ1UQswrTBU+k6AH
         mL1a00SzUhVyKbuG8jPCQsLlwz0S7CuwKXflW+hJS/zpaYQa0I0kXhDAWV0hgtRB3Rog
         ApwfagSg7RwedZani29i/fVDnpBPDaucBtpRP/L7LEENzrf6/AxvdWwh6VeFlugbMvdr
         QgJw==
X-Forwarded-Encrypted: i=1; AKwUvBzC4oLzPp7nFA5OAjRdFcYB+Mo67Z0ErsvHmxOlHXyTiXxrWV4AaTgCt79Vgi9tnhKVL7V54xTLvYHc@vger.kernel.org
X-Gm-Message-State: AFq9FYK+vWUp9O+JmAZm4+iYTCrVJ/ErfumrrA/SXKDgz6RiE0hzrWhe
	LKxaop4qlRRp5Ak7GnYmJKz74vgilNm951Fv0LCdV22oHD5R3aYEHZoJJD6pExvmH6Zi8cKD5r+
	IrzCdrxC6qsl742CxrA==
X-Received: from edqo20.prod.google.com ([2002:aa7:c514:0:b0:6b1:dfff:2ee9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc8e:b0:c44:14d:d95d with SMTP id a640c23a62f3a-c46796ec9bcmr208718966b.23.1792596329153;
 Wed, 21 Oct 2026 08:25:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:23 +0000
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-1-tarunsahu@google.com>
Subject: [RFC PATCH v2 0/4] liveupdate: Feature header ABI and named handler
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

Live Update Orchestrator (LUO) and its file handlers currently validate
handed-over KHO state using monolithic compatibility strings ("luo-v5",
"memfd-v2"). Any change to a serialized structure, even an optional
additive field, requires bumping the compatibility string, breaking live
update between adjacent kernel versions across both forward updates and
rollbacks. This series introduces the feature flags per serialized
struct to communicate between the kernel about their active and required
features. Having feature flags increase the compatibility matching
granularity.

This series also renames the file-handler and FLB compatible identifier to
name, extends LIVEUPDATE_SESSION_PRESERVE_FD so userspace can
optionally select which registered file handler preserves a file
descriptor by name, and replaces monolithic version strings in serialized
payloads with a fixed-size 2-bit pair feature header
(struct luo_feature_hdr). So in future, If a change to a subsystem
preservation can not be handled with feature flags, we can attach a new
handler to support the preservation.

This change is motivated by the LPC discussion.

Named File Handler Selection
============================
With fine-grained compatibility tracked via feature headers, the
handler and FLB compatible field is renamed to name. When a subsystem
needs a genuinely incompatible new handler alongside an existing one for
the same file type, struct liveupdate_session_preserve_fd now includes
char handler[LIVEUPDATE_HNDL_NAME_LENGTH] after token (keeping
min_size at 16 bytes for backward compatibility):
- Empty handler (or 16-byte struct): selects the first registered
  handler whose .can_preserve() accepts the fd, keeping default callers
  on the original rollback-safe handler.
- Non-empty handler: selects the registered handler with that exact
  name and verifies .can_preserve() accepts the fd.

2-Bit Pair Feature Header (struct luo_feature_hdr)
==================================================
Each serialized ABI structure (struct luo_ser, struct memfd_luo_ser)
starts with a fixed 128-byte struct luo_feature_hdr containing:
- size: byte size of the enclosing serialized structure from the source
  kernel.
- flags[15]: 15 chained 64-bit feature flags entries. Each entry
  encodes up to 31 features as 2-bit pair (req, active) states
  (enum luo_feat_state: LUO_FEAT_DISABLED = 0b00,
  LUO_FEAT_OPTIONAL = 0b01, LUO_FEAT_REQUIRED = 0b11) plus
  LUO_FEAT_EXT_MASK (bits[63:62] = 0b11) chaining to the next entry
  (up to 465 features total). Because the header is fixed at 128 bytes,
  payload field offsets never shift when extended flags entries are used.

Each subsystem defines its feature states as a static const u8 array
indexed by its feature enum, which luo_feature_hdr_init() packs into
the payload feature header. During deserialization,
luo_feature_hdr_validate() checks the header from the source kernel
against the feature array in the target kernel according to the
per-feature (req, active) truth table:

  Source Target Action
  (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
  (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
  (0,0)  (0,0)  Accept: feature absent
  (0,0)  (0,1)  Accept: feature absent
  (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
  (0,1)  (0,0)  Accept: ignore payload data
  (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
  (x,1)  (x,1)  Accept: use payload data

Structure Evolution
===================
The relative order and offsets of fields in serialized structures must
remain unchanged as features are added or retired. New fields are always
appended at the end of the structure under a new feature flag, and
retired fields are kept in place so that the offsets of subsequent
fields never shift. If the type or format of a field needs to change,
the existing field and feature are kept intact (and retired when no
longer needed) and a new feature flag with a new appended field of the
new type is added.

In the target kernel, fields of a LUO_FEAT_REQUIRED feature are
guaranteed to be present once luo_feature_hdr_validate() succeeds,
whereas fields of a LUO_FEAT_OPTIONAL feature should be accessed only
after verifying that the feature is active in the source kernel header:

  if (luo_feature_is_active(&ser->features, FEAT_X))
          val = ser->x_field;

Changes since RFC v1 [1]:
- Renamed file-handler and FLB compatible to name and added optional
  handler selection by name in LIVEUPDATE_SESSION_PRESERVE_FD.
- Replaced the 3-mask (supp, req, active) + variable-length FDT and
  feature-section design with a fixed 128-byte struct luo_feature_hdr
  embedding size and 15 chained 64-bit 2-bit pair (req, active)
  flags entries directly in struct luo_ser and struct memfd_luo_ser.
- Replaced compile-time bitmask macros with a static const u8 feature
  array per subsystem packed by luo_feature_hdr_init() and validated
  in a single pass by luo_feature_hdr_validate().

[1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/

Tarun Sahu (4):
  liveupdate: Rename handler compatible to name
  liveupdate: Select file handler by name in the preserve ioctl
  liveupdate: Replace compatibility string with a 2-bit pair feature
    header
  mm: memfd_luo: Add the 2-bit pair feature header

 drivers/pci/liveupdate.c         |  10 +-
 include/linux/kho/abi/luo.h      | 367 +++++++++++++++++++++++++++----
 include/linux/kho/abi/memfd.h    |  39 +++-
 include/linux/kho/abi/pci.h      |   2 +-
 include/linux/liveupdate.h       |  18 +-
 include/uapi/linux/liveupdate.h  |  15 +-
 kernel/liveupdate/luo_core.c     |  27 ++-
 kernel/liveupdate/luo_file.c     |  64 ++++--
 kernel/liveupdate/luo_flb.c      |  16 +-
 kernel/liveupdate/luo_internal.h |   3 +-
 kernel/liveupdate/luo_session.c  |   7 +-
 lib/tests/liveupdate.c           |  22 +-
 mm/memfd_luo.c                   |  16 +-
 13 files changed, 481 insertions(+), 125 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

