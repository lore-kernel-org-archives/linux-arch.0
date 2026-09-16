Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B984A3867
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550192; cv=none; b=XcbZk3KJepiKsr/a3sT5eaiVkfRlrjt0Se7bAMrt5P4oSgQCPsePISTswSz87Xb3MRwfBA3xdsAYVkLzs1vErcswF+YgUGWAkKVTEYHSTWfZ+VYbsKIiVuOmvLmXm1NAGHcXekkL2wpElgUH7Et6O7CfZl4Q591Bi42wciKXbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550192; c=relaxed/simple;
	bh=Cv3GiW+cUXijnfwKcWCdwib/ps1bMkQSsnmAAjeLFWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9Me4fvYw7RMbbbVpxEJZhNAGjEjEGoTUcBitaTibtha/xVJXrAsXnB5anp4eR4C9xxXlEa4u9fSu8jj68RV55cd7Ba0updeD4AB5GVvUxJYgJcYQhndKtEP8te2U7KIk0klhdl7nbFW4l2Z/MDk3fbvFCpRkY29np9yovoCmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiUnKXYo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiUnKXYo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso508500a91.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789550187; x=1790154987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzRkWt2VZCbdlSo+rjm4taEDOl7SYR+tdxu2b2xJF3M=;
        b=EiUnKXYo0rdaIa80f2HpK6o0H48HCzzvBQ1eIZACtQybu9ybiEj6WQRgv3ncJnT3SR
         ppUXRtCCZYoVVhVXWZd1efkoin/yMZuMG9lsShc/Pz2JVkFIoFsL85nS/+1VnJZAwvGd
         xd19boCLPxKrZrjJzvPsgS5Jw6+JzH89IvCX12n6qD5Vlkke0qapkNca/H8Lt6gvUh7B
         1panIRkCnlybLoe716JegaFEgWERu79g0mxu9qrQLKUO234/9L+av+dsy1hmSAfYGaAQ
         FxOEgxvoasqCIIMi9psSusaLn5iQTOFQ7J7ScznSymV+yxD+t9ZgCjwOqaAjCPy/PvnU
         M1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550187; x=1790154987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzRkWt2VZCbdlSo+rjm4taEDOl7SYR+tdxu2b2xJF3M=;
        b=wxp5k5YSq0yHTkhL7oHbETzj6+jufnesDVGr0ZpKY1xIvFW67KzHiv7UrMg892P458
         /0vl+tLhPJiqn3VuACpW9qMRcjDMLZ7xLToyGm3a7fT2mvtHSxmvY/t8TngBTYTK0Za8
         2qONSE8dJV4cszM75+WETKjkQi0K8XanLKF0871E3Dj1HlsxfPnFG5K/+pC2wkxo/efQ
         Rq52XiNhGxi4aJ0/1nAVjyZvx0J1xf0/KVB8E7nk7QAkAp+nvyUzNFYMcjxVMTARgEGi
         WIfMX8HfIHVIfe2wLD2DwSIeAqmYV8eZ+mrvIHeiJUnCf3gR6hHhKeGhCPZ7LdxnUt4T
         desg==
X-Forwarded-Encrypted: i=1; AKwUvBw6TzGuOVJncTzrdKuyP02YQtVqD4Cbs5f+f28WguDpLJ9SrAeyplkka8NtI6+/nSKWMhs1VJX9kqm7@vger.kernel.org
X-Gm-Message-State: AFuF++l/cjr46SWT7AwhzTJ4v55jLmcmsiXZML5Ev1jTdrX5PZhkMksX
	twoMxDJqMi0yy1rqsSYGvxIggG9DtTVWVonRqxr2oQdVirJuUh7RoPIr
X-Gm-Gg: AYBFou3xymKC5p4IltWZKU6BePLlf1jeRfz5357BOBg2YfVcrKAPq85KKBBTNEbI6lQ
	SRzemqkJKlt7RDhsJiJigpoi0HaT1MXht3MPjNpJ5bifRQw9S8V0bDJozmdOqADKBSpR4vjM+qG
	gSkVqkH4Fl34QOTgRCqbqa3oHjyEWMuYEot+puhLOZ45eiIcmglNXGqk6ggYAa65dgffXVNZEcV
	QhB+VyXfMZX9W0cdaGWYpUGN9mZ9Tbkae4Qh5yphRd6E8dEt8L8LzLbyMcMnj4qcZm+fsxRet5z
	JHi4IOlWzn4gvQ/Kr9rqjjLDifR6vlsE2n2ZXShE0hV9jWeWCOAonlpLUgbz+rith5tzUObT/BW
	E3+3faBtlyARc0E1S/PZddSTFIzem0amHHqjaC8w4nVZOh8fObFPfDtkfrm2nYh+nxb/eVRWU2m
	sbCIqREZXlBpc1agwDg2/L4VtvnGJsXvnW37vJWKKhoYpuycyWIs5FkZCKJaEaFOCSW7Ohq0Zdq
	PkJWysibyJNja3lsQ==
X-Received: by 2002:a17:90b:4ecf:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39e1e49a802mr4752714a91.16.1789550186814;
        Wed, 16 Sep 2026 02:16:26 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e19a2c2dcsm1414916a91.0.2026.09.16.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:16:26 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	corbet@lwn.net,
	akiyks@gmail.com,
	luc.maranget@inria.fr,
	j.alglave@ucl.ac.uk,
	dhowells@redhat.com,
	npiggin@gmail.com,
	boqun@kernel.org,
	peterz@infradead.org,
	will@kernel.org,
	parri.andrea@gmail.com,
	stern@rowland.harvard.edu
Cc: linux-doc@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v4 0/2] Documentation/litmus-tests: Add SRCU fastpath litmus tests
Date: Wed, 16 Sep 2026 17:16:11 +0800
Message-ID: <20260916091613.78352-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the SRCU fastpath litmus tests from
tools/memory-model/litmus-tests/ to Documentation/litmus-tests/srcu/,
as suggested by Paul McKenney.

This series splits the two litmus-test patches from the earlier
[PATCH 00/13] srcu: Round out atomic SRCU support series:
https://lore.kernel.org/rcu/20260907075829.2073224-1-kunwu.chan@linux.dev/

The two tests verify the memory ordering required by the reader-free
synchronize_srcu_atomic() fastpath: the grace-period anchor must be
ordered before the per-CPU lock-counter scan.

Patch 1 verifies that the anchor-before-scan ordering forbids a reader
from being missed by the scan, while patch 2 shows that reversing the
ordering permits the problematic outcome.

Changes in v4:
- Remove the smp_mb() and critical-section write from P1, 
  keep litmus tests minimal, as pointed out by Akira Yokosawa.
- v3: https://lore.kernel.org/all/20260912024225.2872265-1-kunwu.chan@gmail.com/

Changes in v3:
- Add a critical-section write after the smp_mb() in P1 of both
  litmus tests, so the barrier properly models the lock-increment
  to critical-section ordering in __srcu_read_lock().  The smp_mb()
  was previously vacuous because P1 had no subsequent memory access.
  Suggested by Akira Yokosawa.
- Adjust indentation of the SRCU entries in litmus-tests/README.
-v2: https://lore.kernel.org/all/20260912024225.2872265-1-kunwu.chan@gmail.com/

Changes in v2:
- Use a filter for the P0 scan result, as suggested by Paul McKenney.

Tested with herd7 7.58 using linux-kernel.cfg.

Kunwu Chan (2):
  Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
  Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test

 Documentation/litmus-tests/README             | 19 +++++++
 .../SRCU-fastpath-anchor-before-scan.litmus   | 55 +++++++++++++++++++
 .../SRCU-fastpath-scan-before-anchor.litmus   | 52 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus

-- 
2.43.0

