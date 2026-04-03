Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD238C42E
	for <linux-arch@vger.kernel.org>; Fri,  3 Apr 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236154; cv=none; b=RILsX4UA217TudirRZELhg7ZlIWQp7h7nsCzfOwyI+XiPlksAhMQbdQU/4Khz3pl548ZAyi4OGgzMhT0W9pykURQZslFiDzsRKw/9evufru1rWx4Bx6sIpl9JYfUEPf3Zf+ZbiFFJ4znLBnu6kEbPZ7e0R0dTtEgEQJnfM2K6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236154; c=relaxed/simple;
	bh=GklAvxgyBLgL/5Hju3ganWywKwn7WpBAHxlpoD0BMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=es77/2jYTzFKGyto4aMGhYgQ4uMEhng11fXFncAxS1cNutUSRfuboAF/GtyUba6G8xVmqgzyDwl2LlgydWVOqRa/HWAZ+WB91kDV1/LHzrNrrWxtsQoCN2r4Kfn5LbY8qLkjqpVxS5BfkCacmqDhMlaP/1pyEvUGoVfafQAYBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKEKkcBW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKEKkcBW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82418b0178cso1021347b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2026 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775236152; x=1775840952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gzhwRJQGIxN+mKtMWgTodgRGugr9lBgvbN6cnb6yxA=;
        b=VKEKkcBWhgw4rSIms4fCmRYXq7+jZ/kBKdGctryKmZ0d+ojxvQGpq9SE88039pAZ6c
         qlcqySUT92uvAQosO0D6ygnaV3OJHO6z3z4VQdnhVA/cFXwcHJcQ8wzMLASEvXN5g3Zt
         gFCZiJgzc3iKzl1IUJT1/pwa0qNdaE4Zcvev3mN2xoeWRAQDUClMdDGmEUWm3Ep1kha3
         hsJ45qYYJ54lQfvnJsW/ok5k5n25MKn2DezMjgspP/c2GsjvbzWrhYL1bCm13QIaiLe+
         AgJKzUp9WhEeCHwNM9gIW2VlkV1i1qSNZ1Ll2xyOGPU1S8Al5qqFNR/1wU9zwKUjmg7E
         7D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236152; x=1775840952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gzhwRJQGIxN+mKtMWgTodgRGugr9lBgvbN6cnb6yxA=;
        b=MI1bOJ7s0eXCRL629NBKXCsI3IpuyiypHBSZDQ/6F8OrwNPiDfP7IkYr1fqOM0UHQp
         xCI54MxAFys1G79/yZMNyRVgvBBoLgWNv7h1RAsK98OijOE8FuQC7Fyn2Jm1DrfjQlzD
         17OGmVj0dLthor0TTsYbWbmzxWMealNhKl8nQ1m1cjmCRccwo6ObS4WgoOQtC2fD1F5U
         ParAS8ocMjvP+EidVULNKMeel0eCeL4s0O3F3UhA/ElncclG6z7iBICC3Vdt9UFmS+le
         a2KXitpqup9CZ2QY7O+fa5NJU5tBINu/cOhTg8kLN3fy6h/v7xdeaMK0XxLKcHBYsiaV
         3dBA==
X-Forwarded-Encrypted: i=1; AJvYcCWsLdGe48BUTt5IHhLLmFbfhdt4zQpZfjn7UpmJDD7nbU0KsXep5AnT+14Y9xjxNzweVv2IZsYRasrC@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXBt9Y8ufvP3j9uLmH/QTJK0Hwyu8qNg3XMWV28jXrNIrFpg2
	2+fs+IlmzC67WhzyE828eKSdIDY2w4kwFfTqMVkRyH/NrOvOO5nQx3mX
X-Gm-Gg: AeBDievo6S6/aWjRcrs6ODWaqtiUCwL3mjqV7UlHuzwD41iq2ryunjim62M2ckY1EKJ
	1k3Ldtj+arEc2E4k5kE5Zc81y8tp6zG1ODRvHzC+UiMsSSNTanrcVLXbZENRdyVPC1vBD17QgIt
	zfpLyWAyDxdDL8aJZULh8GSnE5yArCUl+2tMbv1nN6Czb3SZ4m98M23a50NeESJ6Npie0DFNj6V
	DhKuBJkvNfsopvIk8djgufG8vX2yKpp2VTFpbbSfMwCFPGTj+GX9Py2T3OnXpewFnw4aqKTWkZM
	CnttTGpHM3rxjV4Z1EVLmv4pyB5YdRRRoBlu5NgZoRwCpwzCQSESbzVCpv8NZ9uJbNH8olzL/sk
	heWo93KkcKk90P2cje2HWCsKTENYGdXrhVIF6Xurbxw3gPiMSkGFDv92KqerPOuRShNpIwI1Wj7
	ICULsFasVO8pT8z2tfF97/l/bEwGsNs/xuKPIXLtaDkg+qe4EzB7cipw==
X-Received: by 2002:a05:6a00:ab87:b0:82c:ebae:3cb with SMTP id d2e1a72fcca58-82d0dbac75fmr3481262b3a.43.1775236152067;
        Fri, 03 Apr 2026 10:09:12 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3c930sm6588725b3a.17.2026.04.03.10.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 10:09:11 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: arnd@arndb.de,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	pengdonglin@xiaomi.com
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next 0/3] bpf: Refactor how the verifier matches kfunc checks
Date: Sat,  4 Apr 2026 01:08:54 +0800
Message-ID: <20260403170900.58659-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The verifier contains a lot of logic like the following, scattered
everywhere, which makes the code harder and harder to maintain:

static bool is_bpf_rbtree_add_kfunc(u32 func_id)
{
	return func_id == special_kfunc_list[KF_bpf_rbtree_add] ||
	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
}

This series introduces a new approach: each is_bpf_*-style set can
place its entries in its own section (.BTF_ids.##sfx), and the linker
script merges those per-set sections into the main .BTF_ids section.

When merging subsections, the linker script inserts an end symbol
for each one, so we can derive how many entries each subsection
holds. The kernel can then walk the entries in a subsection and
get the same effect as calling an is_bpf_* helper.

With this we can drop the BTF_SET_END macro; BTF_ID-style macros
can live anywhere in a C file and are no longer tied to a strict
BTF_SET_START … BTF_ID … BTF_SET_END ordering. On top of that,
all BTF_ID-style macros can eventually be consolidated in a uniform
way.

The current patch only partially migrates the rbtree kfuncs. If this
direction looks reasonable, I can continue with further migrations.

The end goal is something like module_init(): adding a new module
(kfunc) would only need a single line at the end—like module_init
(BPF_VERIF_KFUNC_DEF) to perform all the upfront wiring. Another
benefit of BPF_VERIF_KFUNC_DEF is that it pushes us to untangle
messy verifier safety cases and make them modular, so they can be
expressed as parameters to BPF_VERIF_KFUNC_DEF.

Reaching that goal may still need:

1. Further migration of other kfuncs. One issue worth stating up front:
there will be many .BTF_ids.##sfx subsections, and a large fraction may
contain only a single entry. I think that is acceptable; avoiding it
would mean keeping some logic on the old special_kfunc_list path for
those cases.

2. Trying to unify other macro families (BTF_ID_*, BTF_KFUNCS_*, …);
the exact design still needs more thought.

Kaitao Cheng (3):
  bpf: Teach resolve_btfids about the setsc type
  bpf: Introduce BTF_SET/ID_SUB and BPF_VERIF_KFUNC_DEF
  bpf: classify rbtree kfuncs with BPF_VERIF_KFUNC_DEF sets

 include/asm-generic/btf_ids.lds.h | 26 +++++++++
 include/asm-generic/vmlinux.lds.h |  2 +
 include/linux/btf_ids.h           | 92 +++++++++++++++++++++++++++----
 kernel/bpf/helpers.c              |  7 +++
 kernel/bpf/verifier.c             | 44 +++++----------
 tools/bpf/resolve_btfids/main.c   | 89 +++++++++++++++++++++++++++++-
 tools/include/linux/btf_ids.h     | 83 +++++++++++++++++++++++++---
 7 files changed, 292 insertions(+), 51 deletions(-)
 create mode 100644 include/asm-generic/btf_ids.lds.h

-- 
2.43.0

