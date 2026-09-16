Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D633B841F
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535154; cv=none; b=LjIloV8KwEUDOQU5ynLYMKeR8h43Hm3lIfnLdqiAW5gYUcGDB/jVaWjVXxyuzyV3zWcZX5LHQUZxvLJ8suZMSBJZGlXLQhcrz6CEcRWhxy0yRDJaCnEnM77Z7llqQxo2rwQhd2XKeQNRQSsso638HOyue5wedgFpahiXmj29+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535154; c=relaxed/simple;
	bh=jUsdJh8Hh+QQW+V8f3/afoIgbxaF+ULvWELh063IS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmoNuYSm1TpuPSV6DCflUgBEKhw7Ib3hCy6P8r0Gd9zJZAnpb68C/6b2iUh/ugR6n8ShHIK8MppYWCjzCif1tHeAeaZSWxIHT9p65kuklpD+WmJ/0znSrZ0FOk8YT9ngPXcenXCtx4UOv0qbGtVOmZMKx1qpA+pnFooUcDQpPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P0ueAGi9; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P0ueAGi9"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc502a179c1so977824a12.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535153; x=1790139953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=lkHT1JyRvhS008VWdxkdT2dXJ/KR28/JRR5Ct81fd/OKws4VoAI/v5iTNiic2lhajj
         T5or8eI/EvCUpOPjSTBTwRs1fRsrtPt+kAkYHeuCvUAuVvfBgpQHLQI52KHZjuDh4y3C
         70Rm/vse3RdEybpXuv6R6ydT3L0lRP35Di1NH77CABKSgrn9SPEPSAm5zUnpWpnsBt7W
         92Dy7A0bchJEwdJuDTqrPQvCkoZcydPxlvDvur9vyndfxOjaWxbVY+XXj5js9tw5xVxw
         v/kjz1KyUkD1myZAxl0YjIYdvImxMNJcQItkrV5o3X6RDpjaQW4YalzgqFrHyIZGZyh0
         Ebzg==
X-Forwarded-Encrypted: i=1; AKwUvByjht9FFwY4w0uUbK7Z0RURJo2/D1VgPzqtU3utLb26gw7eufSJ1+CwdW9aF7l3MNh4HwvGSJ948Rev@vger.kernel.org
X-Gm-Message-State: AFuF++lU/tQyFoMJ6YiQB+w4SczEIDy3F8WqFGwMBhaVwOPWfRFszZ/m
	GwFg6SfoaQAylHCUVSX0KQti40m1gfQ6WUhhDp/iUN4Tlokbi/DNqw3U3/PZMlGY4g85BIf+KeT
	wGU06Qfjb703B3N4co6zABUtTVsobLdldLg5jKdR2etJrS4HIaQ9vm2NRkibRTUTzx8XgE/Ns2J
	GcXetm0dawB3ZOGYtcwwGbBs4O88DbZkXYHM+7sObanVZn0taF2fqXz+3K1vgBoyxHpLz1lZNjf
	Q3eM+PFXoOLAg==
X-Gm-Gg: AYBFou2ArBVN1pr8eOcBKZV+/KaCjWM1NDTeFqctFS4Jfz/SraCRQhiI6LsNSu2s4ZC
	4hZF0G++lIw7z76UtW0QPXGbTQNtaZCu7vHE49gWIQ6xX4hc9FSBEUkV43XvmCbJ8fu7Du+Fesr
	8m6MEzehB2OGAoPD9Loz3Wt4lTDUx5Ih/q8t9ioT0MAW/ZjPAcD79kKKpwMXsgPBFA+NaPpy0q7
	RVzJVnMYXkUfq2zZyUrrkr7f8/HndxrxHmZj4TL3AZyaBrGaQhLLkG/Wt5inQrZRzK+ihhFFLfv
	v6DL/fQGc+jBQbRf2vmKIV338UCKWHUWlLS1ELETqqMSuyYkF9ewHXfAx/q7JHJ1tC7dgHbEwmh
	3WxW1iPirvBnGpKDm+HC5xn716r9lv9RULVNPP5W04Zjzaa5XJtEDwKxFZvyGXxy8IhtYejo8xD
	4GGJZUMBr2lsNsxXStXhsaicU8Df3nYuhC
X-Received: by 2002:a05:6a21:6e86:b0:3d3:aed2:6f22 with SMTP id adf61e73a8af0-3db5003973bmr9225897637.22.1789535152540;
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc50a7c1e27sm855927a12.0.2026.09.15.22.05.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so1253021a91.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535150; x=1790139950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=P0ueAGi9lhbFeMzfjCFdjE0M4gVt8p0TORIUefRcToQHQeAkEK4qv+sYa0SpqlLgf4
         SPhASxE07mw/MbQ6b0fjj0/gmZQvdLNigxj4DiZzgmYdl1cJ9EV3VO+qc8zZ9RneVVHr
         mzHnLxJfguW8JDHirUgT1h0b4vUAzi2I7WtDk=
X-Forwarded-Encrypted: i=1; AKwUvBwWCC76194vWdDdm5Zg/Jwg9EjRFv9tDyz2jWIwD5j3BXRSBjrKjTL5Fty+zAanYdiapKj+jkmHMa79@vger.kernel.org
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817210a91.23.1789535150515;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817170a91.23.1789535150025;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:49 -0700 (PDT)
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
Subject: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted guests
Date: Wed, 16 Sep 2026 01:05:38 -0400
Message-ID: <cover.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware registers each per-CPU steal-time GPA with the host. An encrypted
guest must first convert that storage to shared memory, but the existing
setup publishes the address without conversion.

Patch 1 makes the decrypted per-CPU section available with
CONFIG_X86_MEM_ENCRYPT, including TDX-only configurations. Patch 2 defers
encrypted-guest setup until allocator-backed page-table splitting is
available, converts every possible CPU's storage before publishing any
GPA, and attempts to roll back all conversions on failure.

TDX's conversion callback uses __pa(), so patch 2 preflights every possible
CPU and leaves steal time disabled if a TDX guest uses vmalloc-backed
per-CPU storage. This covers percpu_alloc=page and automatic allocator
fallback. AMD encrypted guests support those mappings and are not rejected.
Supporting them in TDX would require a separate conversion-API change.

Conversion need not preserve zeroes, and the host initializes only the
8-byte counter. Patch 2 therefore clears each 64-byte object after
conversion and before registration, without disturbing other decrypted
objects that can share its page.

The intended merge path is tip's x86/vmware branch, following
commit ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED").
Per-CPU and asm-generic maintainer Acks are requested for patch 1.

This replaces patch 4 of Alexey's v2 posting:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/

Zack Rusin (2):
  percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
  x86/vmware: Decrypt steal-time storage before sharing it

 arch/x86/kernel/cpu/vmware.c      | 96 ++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/percpu-defs.h       |  2 +-
 3 files changed, 97 insertions(+), 3 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.53.0
