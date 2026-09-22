Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD9502D59
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061007; cv=none; b=nLZHC+4aQJif+VjaoPXbWrVfra+P7zSuwG7XBpZVSJr31ws0MubEdB5qZ0tckqJJI/+SfKsTblK7XqlfZ4CoW1bsVCGRLTiOWf/jTAdsv0Hd5JFSTyv6mAhdQDQJ/BLSjSxeBfrmwnS0qbC8LjAewjv9SIfW2BTvlv1Vtc+Z6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061007; c=relaxed/simple;
	bh=IT4Omxoh3UL/os4MBcvDO0Y3uwCbEQ/6SyGtTM/wD+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj8CT5xhhhkO1aVDdA0mHSMcfQypnEpo/osNgOhUE7VkyeLneJydVO4oF30gMd4Eoqt78w3gNkM14c12cZoHKjnW4zc1m/DKSFXk2XxLAQzO1J+vxueI6cXgLvmcBWddbn7yj6IjTdqAUUg7U/uhpBOdWEewo5jrZu2bCjhtEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp5YMgxX; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp5YMgxX"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so2311303a12.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061005; x=1790665805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6nOkseLD4E1uvlk7kwNFkZGEal1mrhs8j7yziX25N0=;
        b=Yp5YMgxX9CYvhky9D6dAN4YK1p9JHW++s5+DVfDoeJueUsfWlEhSkXkcZ/CLrBnXOZ
         rjeZRA8zVPJsidXFHGRy3F8ujH2SMX/+4ty5p2fTITtHMaS2RZGUjampVJpNeImv91Cd
         tBMDhWB0wpJ5Hrq15gi4JetzN3Y9AiuCKMvGdNO6vL4QkMXDolD3fqm1eXzXkJ1pQqEQ
         FjWH2eBytgqlq0w9z1rnmYM9jI0otm5qFJh8TvSp+iR1cWg59jbEwg/9+S2NK43vYaAj
         5lXTo1zQbgFBQQ4GLemYfAo4C1LXj6i4tK1qz5yxtqBqcFjQwSfHsucb/N9eWwQG3QJ2
         ub2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061005; x=1790665805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6nOkseLD4E1uvlk7kwNFkZGEal1mrhs8j7yziX25N0=;
        b=fRpVYcH+RRvWQ8BUEPFqr57zKMm1j3rvoS4twFRYEoA/I8BVbE9fpOPjylxD8NZdLY
         CMNAoEjGH4ojotP2vbUs1QQO81HXaG+d5uWVf9DwmKfXzspLXt7GFUTWKR9PKdYtdfNn
         975Hpc6VP9C7Xat+lvme5doHYIpVAccE4E9LFGEBwTuLKO9xEXPwJuoebztMJ/IO60r9
         hMNAq0dEYt1wSEAEIs7n/ZEQE5q++QCEgRsGchUEutM7QlSeyeTedKV9ZtfblE6B3ikB
         31rpbwmledo+5dt7x66wGjrrUITejVEWgqAJ00Dz4z6dxN0H5tq+e5xk3UxOjChn2/8x
         lMLg==
X-Forwarded-Encrypted: i=1; AKwUvByAyyoDwR0F36o4ZRXa+KaaFCduzHvQYEGuUVtNRMA2UXIlUW7ot10hm38+f1/9GXmytqBagJqFLMU4@vger.kernel.org
X-Gm-Message-State: AFuF++mOth8aULFjZLGFZjUa5ZSxkymc2WXHbi9Jkkbd2UX5xt7Y8HY5
	SZICix644qhOZs799iRizjSJyVo3F/Ft76AcDkEv1vJnpZRuNskJ/2bQ
X-Gm-Gg: AYBFou2Zt0+aEJqCi/TEab85/bVh3nkOfGQ6cdNZ5Ewys/nqibO0qvSBP+fX+hPn+jS
	ifocjusrcU0u9U5suxwZ/FS27ARmRRn9jxINC5dq/FGgs+ayw7R2G/bwhPuUC2mb5FNVw0/wcUL
	DDiLaJh0HSDPaUTmCqziGf+Qe5K+26qzag/hh4eeGNbP59Xb5JsIaFCW6KeKVjKnwqXCYLJFItv
	iIPdErdnmEDEC8d+SqmsmJfLflPp7Hd0ajjqRnOEeE+xahkG3BLEvHhsIl4oeeYgFeGLz2PRItj
	uLF2MBAk883OBDui5Gp251lMxcANHCTaQLYioSVq8bpfcUPHcEsvhh9mzCYgZTrKkbGtIAS82iQ
	1AfhG8wnEe2F/5WChlC11DVy71OmRd7QvpDOaVp56BymjCsGekVCWyoYsvoh0dGbU9E/L/S743D
	1lSe93HIbQvU5NH0h1S9jXcErEBBg+ZDM5BOKwHtHEYxTzatTrwgSNhlkPZaCH0lsqfQW/irTuw
	zPoe4Kczb/cA9aY7Q==
X-Received: by 2002:a17:90b:5404:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a07324277emr253812a91.51.1790061004682;
        Tue, 22 Sep 2026 00:10:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com
Cc: akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: [RFC/WIP PATCH 0/4] hazptr: add shared scan path and lockdep use case
Date: Tue, 22 Sep 2026 15:09:46 +0800
Message-ID: <20260922070950.4173245-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This RFC/WIP extends the current v3 hazptr implementation [1] and
adapts the lockdep use case from Boqun Feng's earlier hazptr series [2]
to the current hazptr API.

[1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
[2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

The lockdep conversion replaces the expedited RCU wait in
lockdep_unregister_key() with hazptr_synchronize() for dynamic-key
lookups.

The series also adds a shared-scan kthread for concurrent
hazptr_synchronize() callers, rcuscale support, and an LKMM test
for the acquire-before-scan ordering.

I tested the lockdep path on a 96-CPU ARM64 KVM guest with Boqun's
original mq workload [2]. With a multiqueue virtio-net device
(`-device virtio-net-pci,mq=on,vectors=6`), tc mq add/del x100
completed in 850 ms with hazptr and 860 ms with expedited RCU.
The rmmod workload similarly showed no measurable difference
(1360 ms vs. 1380 ms over 10 runs). There were no crashes or hangs
in these tests.

This is still RFC/WIP. I would appreciate feedback on the shared-scan
design and the lockdep conversion.
 
Kunwu Chan (4):
  hazptr: add shared-scan kthread
  locking/lockdep: use hazptr to wait for dynamic key lookups
  rcuscale: add hazptr scale type
  Documentation/litmus-tests: add hazptr acquire-before-scan test

 .../hazptr/hazptr-acquire-before-scan.litmus  |  49 ++++
 kernel/hazptr.c                               | 274 ++++++++++++++++++
 kernel/locking/lockdep.c                      |  30 +-
 kernel/rcu/rcuscale.c                         |  65 ++++-
 4 files changed, 407 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus

-- 
2.43.0

