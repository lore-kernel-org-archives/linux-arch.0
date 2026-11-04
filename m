Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811551;
	b=2BxQcN1Z8TwbPH5ewnJZIqAb8AYlkX+w1LT+0FhRvaLFQTRlKr2nxtbgmIZZbK+zAS9n
	 lNh1jmH8gPH5BGLqBX09UxEGegaQbw6uEXNM0RdmCXptaVyQoGnSe/7qzzuouk1Cthw+2
	 mxj2I4iKddD19m5B5kOgI5bGA8tMK5nDFqftluwtzN9OFh/ZM2rZqg5Sr9IGjRgpYhKKH
	 GSI9Wjb3VUKD6/gwFSrjHz65n9hAW2Hsso6aRpj0c/cMDXZogi5VP+cyu2eT9avUX/jdr
	 f3/ZTvroy2ae10pViEAGuDBYsiKffRdVtwi0kPSA84msfJ5vRHtiKSmlsKu+ykdbMTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
	b=vPzJaNJ/TMXoEyl574Cp96hK0Wnl38LBJQW78SBDka1+5bQ4ixvNSEohq9txeWd15p5u
	 6h8bMCQQTvcfNd90BBF4WU5N5cqRPNpqBezZ3Chr8V5XHWl/L0MZbTBcp0n2H66NrcbbI
	 4TwcktDe0c2JT7SVuaCsCjaDH+vIzpnxU/cgMzjxPWqxbjzzHQGAx6vxdHyqwvlDKiNmG
	 A1hw04bGlusIvW93AZxaIcRx+uStfmH8UIl3vIRAxTS/yMbIflEaTftQafnp4HdEFCb3L
	 XfElMEJ39hbHDHHVHm5FZS0dvff+YiiaPaUiXED/hJ1YHp9gNCy43lxvwzMtKezxrZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y31TZXeY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACF606A33A
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65ACF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y31TZXeY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so1603301eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811550; x=1794416350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
        b=Y31TZXeYrMNub6CD2yl7wXzZNwbZWHH3eZPG51i7cMvXQr32hmTchJqFckujdmLaR8
         jO2Ybm5+xBQyyCmBfBHUjRxLSITYvm9VfhBZYZctszoMyWT4bemxe4sss/bovxPT2dJs
         k+J4IpNPEe0CddeXVyA/Y7b552MrHB98y/tpmtR8JuVo0QGTEi8v62P+yHXrxe8Qf5FA
         77OjQ6RMgvgZGAeX6Z8tBsU8YO6c7QSqAvOBWbc/pFX2uzgT01/mTcE/PcARiYWsSBj7
         CUZYZ7MlzON05EWeaepGCCOYVGQQlBPbEz6X6AJW+QtO6e0nH21GIU5VM6lSbedpHUeR
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811550; x=1794416350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/LC+6R33q10vqghO7crsZlwQEV9fByooirEbdHEQuEw=;
        b=Ay492HRenhEBmZl9IzJOkNjmlLjPVY8q1ZFTuosI0K0E4ZGylHzQ5/Rv7bXT2Uljyv
         pS6oLwzs604f3trkz6U1UfAX3ASDT6FAaTApZuIG9egGk85kDC5MA0IK5a4Z5OAG0hca
         FKmSXcffwRiF9OYNNgxu52NwVfS2xRGCu+2oTl86N1YICgeb0WGHwRKMqn2PMtPmwSOF
         cf1uBXEKZMAUtUV3LA6rIgivRqEbghScOlaa9LxzJZrCzJ5vlQASuhCHAFu9HVhRAJEs
         SQfvIISFIi24zVxbxQPp4mZM0GT29tULrMZhaeM+M9PRnD8zYx5jcujoSiXReOIj4CYq
         FPUg==
X-Forwarded-Encrypted: i=1; AKwUvByVs+RPdKu6NNO/YzjaCHPSPJ1q/rUnwrxRF0in9tKRR44Ih80q/R9pf1ocrQgdyEwzlszp+ASzFpQU@vger.kernel.org
X-Gm-Message-State: APuU4Z8lfnU+rpLliD5FNlATjWENNijiejcNBtoQMc52C6Uqz6NR+CzU
	9pKU2015DqU3IwByC80zS319FSR6ClMlJOyLeWHSzHk3JVlmKkhrKb35
X-Gm-Gg: AYBFou1ocGJu64D6xxXVI/L5eO9MVUuvQLg90esRahDmuiy73I9tJd9WH44+P0+Lj36
	L7bSXsq4Rkv0x5rsfjhwJl8lxW5pBtQmGm0mdWUFgXcjqQzD8EwiaKLTV3MIwy0/W8Rxt+qbx4c
	Z1TGR50QGZZAMH8DgD7EkD8NL2WIaICrmLxgVukO+60ZkZjYU8PqCmnilZvZeK06CX63JwruRyj
	9ZQOOfWqU01n1g6cNyLbV/ucfPuCJQ/k3Im7KuTw+PAk+ohEP7VjXIZRJvdBc3Sh8kxeOHMG1XF
	eFKGL9jY2fw9aSr9oPgmt0oaAePuIgCwTQDYhaxm4jQZs6SPusDgB1t2SJdkmSfaLNDEq44pL2p
	otgJRvDXiDmyGK8eI7vKCsYoa3TTirqnBI04MgNW4PCQK/NyANgSBIe9+nXrve67eAdRopXBSdo
	pEgqOh68cQ1Ca9+c/amOzEeKLaJ6f5/G1AQK2ZWVFV8KpFsjZX0A+hD5stoyDB/QmEKGUfgJPio
	hhQzekq5kEtJUohG1qC79RDIU7HHAlmgbQ+p/CTwrH7bAg1ljqXXadqOBYy3ODuNstg/wnjDuUP
	5BVz06uicJjsVJncEXufQq+49BOyi8DwNR4g6hw=
X-Received: by 2002:a05:693c:8945:20b0:36a:2999:ea9b with SMTP id 5a478bee46e88-36a423c346fmr24991222eec.23.1793811549996;
        Wed, 04 Nov 2026 08:59:09 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:09 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 25/28] hazptr: Select TRACING for HAZPTR_TORTURE_TEST to enable tracepoint
Date: Thu,  5 Nov 2026 00:54:43 +0800
Message-ID: <20261104165504.2430480-26-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hazptr torture test registers the hazptr_waiter_enqueue
tracepoint for its hot-address scenario; select TRACING so
that the register_trace_*() API is available.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b500e96ea1c1..8fc6434a05d1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -27,6 +27,7 @@ config RCU_SCALE_TEST
 	tristate "performance tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -42,6 +43,7 @@ config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
@@ -102,6 +104,7 @@ config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides a kernel module that runs performance tests
@@ -117,6 +120,7 @@ config HAZPTR_TORTURE_TEST
 	tristate "Torture tests for hazard pointers"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
+	select TRACING
 	default n
 	help
 	  This option provides in-kernel hazard-pointer stress tests.
-- 
2.43.0

