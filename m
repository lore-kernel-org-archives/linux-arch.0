Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63B1FBEA6
	for <linux-arch@vger.kernel.org>; Sat, 12 Sep 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789180969; cv=none; b=CKIxke8MZSAREvnJgFGBzrXNm8UEfuTDiAVzRDGrhmbpey7HIy8MiJeWnHEx7wWWMPk6qwFfq7cq+3JcJRN0+diQync+ONrywFlzugKSOeChkPp7mP6k/iLY0uDlGX+8N18lXWZfMYr5/lpCEppovtBaCPNagHTaubntNnj/YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789180969; c=relaxed/simple;
	bh=9f7h9PLAGNr5QREiP4rXwCLceZZ+OvQlKMgj7JBEccA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsHFYAdcuXGoPbNpKi/gBJYERf/8JOwcWBZ//L+xf9NUHt6CvVWvjBVVsjgWfpOPbVEzxbP9e1eJGwgZbxlbmTxRcZ5m8Oo5TMhcH4r0RZnBtHqwnNNdhNnqm+ONqVqjmPidKC+mnbKx6UN+yDeLasmbiCMlHN/x71N0x9UDwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PklKXUbH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PklKXUbH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so165735a91.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789180966; x=1789785766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsxAOkX7Z0gktBYPmfGgeg8Ie2GzO8n+hdt9t2tFXNY=;
        b=PklKXUbHrl0mESqR6cCz+z1uSVCL/gU9evRoA+t0HTJ5g2+6IN+gQk6SRzR51PcG84
         4002eTU4pfv3+VCXOFlDjL7Lhu23TUl5pjvlrWc4IzDelmIA+KCiZSI+sZv3udFhC5bZ
         64W7dC9js1bAqW5Q5Trfg6lsqco8XFiofhwDGEp9FYHBdz/3mJ5BPY1eGfJHgdr6JBds
         YBWoVrAdFpAOgcK322tiy7YDkP40ncS9Wjvgd15OHI4TkDoVzOkHfETd1zBIcSl1bDa8
         tYfcfV5bUiDXBG9scdFCWHimShA3Z65iTE/6GK5r1awOxvDDsZ0P3Qk9gHkdlftd2R0K
         RUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789180966; x=1789785766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsxAOkX7Z0gktBYPmfGgeg8Ie2GzO8n+hdt9t2tFXNY=;
        b=l4+Fv8X7nLjTyz2Ki3JWZ1fF6D6EEhJhQk9WT+kaBpEGPmnUkxWpM7eGiHX0tZjNiM
         PsILIHQUd70F+xz7F9tcd7rrCz4KpD8WRW6fkYpwEhXkcCvbUFGK4vT86s6nxaZRz2aI
         JezeOIa6n3t75EEaGfmNOmzF06/z5KeEuTSVfYoUYA5rLoBW9DrcP0+jO2ji2DvtTnAm
         JHiFtNJrunjLfmjtwkEAVMiPvXsfxuGNeH2xCKT+M845pv3k9a/oFLwZwZXSsvXdTItv
         mux67M+pVz+Y6sJuWKYKMLsnL74kWKYMkxTgLc2a98/0HvAz/aO7X2TSz1+7DnbboAaU
         bj8A==
X-Forwarded-Encrypted: i=1; AKwUvBxS3tCAKG8sEdV9/6ZGXaWxXmWscho7JvLMccADua+yHSQznYe0OOnxdfHvJ1QsmCDC4pJ16Apa8a1L@vger.kernel.org
X-Gm-Message-State: AFuF++m+TfwmPFz1T9TaMgEdJ5kpXyB1tO2PPSvAAZM3J4J0yIqHcGgP
	Y0kJ3ZTKayAuZvO6fIF0b/rUTrjyrXXnf8cpp2U2h8E4i2B6PEB6vVve
X-Gm-Gg: AYBFou1/Z5Gp6gSQJ6cytRbezZJBlYjUIRAmu70HIiaRcNpQne1jOwwEmRgTR/yKlCw
	i3nwUpyi9R3C5Bn1Hke3qDsm7glXM8x8/DZ45Haj9rJVH/82qyZVZ1TDvdKdcT/WdSOq/+g96QN
	zgCoJu8AiTlAafBvyZ2gNlmy3DbR64QQgt6BEmD69KlYLgEP3LE94hrlCFAeXqod9PLMPqXD1u7
	P4XRiqch1KlflJg8X08JycOIDHImrg78bLBPfuen4Wbr88rRJ/6EpkZGIOOfrooMxZvTXOvGTPM
	+vu8K8JOtXSPWiubAPbbJwrP45qdQmykzScyW9AnEN37ihzI30C7G4lNTVYqo8tpgROUxCNH64K
	SSmVrp3Tp+w1iqc+mzleD2iBceFi9UL2CqcG91tjwzy+bJsOew6tuWzFzNimtQ+eVbG57FkVmFm
	d9EYsoPgZp3sbcw7tRjW3VhrWA+YrIgCx7Ink1NINmxubg+3k30bJIYgspeEMEwfOxwXuBlbpcq
	m1M93k+CmhgukTXNw==
X-Received: by 2002:a17:90b:2588:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-39dbbe87b09mr1694147a91.2.1789180965146;
        Fri, 11 Sep 2026 19:42:45 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d950913a6sm7879099a91.6.2026.09.11.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 19:42:44 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Documentation/litmus-tests: Add SRCU fastpath litmus tests
Date: Sat, 12 Sep 2026 10:42:23 +0800
Message-ID: <20260912024225.2872265-1-kunwu.chan@gmail.com>
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

Changes in v2:
- Use a filter for the P0 scan result, as suggested by Paul McKenney.

Tested with herd7 7.58 using linux-kernel.cfg.

Kunwu Chan (2):
  Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
  Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test

 Documentation/litmus-tests/README             | 21 +++++++
 .../SRCU-fastpath-anchor-before-scan.litmus   | 57 +++++++++++++++++++
 .../SRCU-fastpath-scan-before-anchor.litmus   | 54 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus

-- 
2.43.0

