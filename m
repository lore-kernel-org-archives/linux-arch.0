Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B834CDDF7
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954291; cv=none; b=onRVSya4dXQZhylT4/E1yhelwDMAjYOOal0TKQg7Tu1Sg3D77Zmo+EQwrcba1dM2M1bJQf+pQ0/vhsGdSVtNwHPCqvRNEqeL4D10bdQL63VSfy3ou03QPrizZR+gBZT2UMP3n1HALujtgIa5lMmBmbyd+NkeniH+TZg+wV3gtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954291; c=relaxed/simple;
	bh=JSUi6jGOR+sqRHiy4l36vCIY26WJfhaJOy9Cv93ea0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8oJAoFEyPUm5EnWZTYZR5qFeOhVbxTWX4THlo0G1CI5PO7J7DGCbY49mBXO1pUWhkxNzVDR/KQwXFW47INLMYzXXeY1Z2785SlFXOow+vpnGIa/XjAMGSrNnXvkDjjBsnsfdQNnm4dTwLc/Fn5U5iyv0wlsx29uRFTXaiLPTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4RAErdQ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4RAErdQ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so3412064b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954287; x=1791559087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NVMCekHj6qwvQ/bhZYOpPPGlxEnibRFNF07qSpaJNtk=;
        b=A4RAErdQVJpBv/YZW5aIj19C1g/XNt8ZzQfed6lR4la3CC0Gq3vCoNO+AMWrRNA2mJ
         sAVaRiRyzWeUNCWsDTDiqpb/giRA6KmjaJplZVR3Te6eiFfpcIBqB7yXhZdlNckOAUw5
         ewSTg6LatmN+KiUHiYxJN0tWx4XZ6CtvjkZCmqXp6IED9AdP3z3iBtjn6C+2tGTXOuPA
         mcXMPqlyH0loW9oNq95AqtkpLt1OTXyhU/aRi7oK/Smb+TmYUIJ72l6Z4d+sHT8FksI8
         XDf3jCiYdMCBgMkX0gg5MGZGdEt9p8C/4NlLfRpxgsUJOdaNAvq3XENxU0tKUnohoXDj
         9Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954287; x=1791559087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVMCekHj6qwvQ/bhZYOpPPGlxEnibRFNF07qSpaJNtk=;
        b=gwDOQPNIHZKhGkhifxi0FjbsuCOp8eifj76FXa05uahRpiQa0fClkMSh+ATk9PwUld
         dzjgqkhfl1CY7lan2XW084c0QRWO3MnVzvACb4Rd1H2+b259K/EhxE3nByzbM1iXHi4y
         l3nUGybQKNSvr/1YHB7WbU83z++csiQlRu/jasutRsdZiNo7J+BCHRchNwzP9XCxxWjN
         lYjdgUe4VR6JTvv40ao1uqhJChUCvHLVJzlcufQExzKqZZ6UYKYJAd0xuuolAP7DW5Ee
         vHfXWFQ1gNCNQWLrWmPwjeHbVGTL7LQtMQcm9T5bjn2rv0kkrJxCMHRHS5xpA2fXFhSP
         LO9Q==
X-Gm-Message-State: AFuF++m66afoveA2jZ/QyamYiaW3FdY5N+jIDQq3el2vws3QCyowmG/o
	h0d7tupfmOseX5cVEbQXWMmeVKYXXOqJPRbbhqZbW0aWytosrRtvr//+
X-Gm-Gg: AYBFou2ohIqAUGxqPS8aPXL/zwoRYZgf8F6aFYFbVVUBFgQYZ8XrQz+dfBeKzV9mHwm
	vdijJ547HvP792eVLJ1MILaolzpMU8Eaoh1FYlIrF6YmmFiD99mtdiNHcNMJVP2FhVngnR6kSEA
	UqenKJlfCeOZzik3z2hEeuKpUlG8Q7h2mFh8RFUenDWpI+mR8sQHsGECsfLi1fg/9VkikpJCLXM
	0vx91L9mgZMzUr1h2ueBmRNim82VtuzA0bZUAxF/HWieox2NYI5Mrn9Fal5tnmC2MjeyAhh0orW
	hBySXEHVyH1JWxB3DYBLKzI+lBxM+NffQnHbeC7krARkJ++8WDpLa4nXNIpLAsPKhvAXkylD01+
	l2wCc8ziMRdfDpFtqF1M0i1DN4xGTqR4+R9uqnSgUnSK397SpUycAFQtKl02kIG/hW4Q/1vF6Ba
	sLYQlwDcF92qxSKROOHfsTt3YayVk3IwlZykG81jQbfCjSBz3pJi8ihw68tZpm4kuDcJpKSjf4I
	mq3DV5eA62TXqHmZw==
X-Received: by 2002:a05:6a21:2c04:b0:3dd:a195:fa25 with SMTP id adf61e73a8af0-3e0bd22c7d7mr2662146637.74.1790954286607;
        Fri, 02 Oct 2026 08:18:06 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f73551f2sm1166635a12.7.2026.10.02.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:18:06 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: arnd@arndb.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 0/2] rwonce: Introduce {READ,WRITE}_ONCE_THIS_CPU()
Date: Fri,  2 Oct 2026 23:17:54 +0800
Message-ID: <20261002151757.3605081-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rework of [1] following the discussion with Thomas and Paul.

v1 marked the got_idle_tick accesses with plain READ_ONCE()/WRITE_ONCE().
However, the plain variants do not distinguish an intentional race
between execution contexts on the same CPU from an access that may race
across CPUs. This distinction allows concurrency tools such as KCSAN
to tell these cases apart, so that stricter task-vs-interrupt race
checking can be enabled without false positives on intentional
same-CPU races.

The first patch introduces READ_ONCE_THIS_CPU() and
WRITE_ONCE_THIS_CPU() for this purpose, currently as simple wrappers
around the plain variants. The second patch converts got_idle_tick
to use them.

Changes since v1 [1]:
 - Introduce {READ,WRITE}_ONCE_THIS_CPU() instead of reusing the
   plain variants. (Thomas Gleixner)

 - Expand the commit messages to state the KCSAN rationale. (Thomas
   Gleixner)

[1] https://lore.kernel.org/all/20260920085434.2918331-1-kunwu.chan@gmail.com/

Kunwu Chan (2):
  rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
  timers/nohz: Mark got_idle_tick accesses as same-CPU races

 include/asm-generic/rwonce.h | 11 +++++++++++
 kernel/time/tick-sched.c     |  6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0

