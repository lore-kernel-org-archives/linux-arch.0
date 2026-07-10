Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C73D9035
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669968; cv=none; b=ec4vOalrDqQ9P/biYblv+TanfyvqGvWQpN76/WuiUOa64EhCOZscNYuS3FZeCk8w84w5W1mN1KEDnc+paf4tB0voaW3anZUAL1L3hFPVYwzHBAqSkEhscQzuTqwJL2YP5PNVdrzlpymOSogjg6F8WHZUwkiGWLJkhPhi/zcGFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669968; c=relaxed/simple;
	bh=D9CFIdORg3KDPUuWXmjAR2RsP8Zpq9G9I7JzBgl41j4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ok+z1q863XQkKCE7YD5Si949HBYvPYAWPQaTx6+eLMjfthksL7c5xLWpphnQtmXenVfBAZeDHUzskgNpnWaK7OwegAs2KzUyJvrCD3G1LGcDzg/Q4vLyu4M507RVvKwVhq338GWJgFWJt36Lma36ScI/k9ZcE9ju9cmRkiIZWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejiWIZN6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejiWIZN6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso882336a91.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669967; x=1784274767; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihT/2aOY8wGTL01WDNL3ZSISpn356Jmov1yxoJ5Q2Is=;
        b=ejiWIZN6XA5SZFKmedWw6IIGdlixVt7BYNZhVsY/HXsflrRXZTTv4OoRq8SuZ6JlwU
         9Sx5a84PXjyPTl0M86Ghsa9yB6RlCtoZWEooRPJT5jgyKuBzJh/yU9L4QmXNRdaywx0m
         Pi3JDLt+T3tqFsisEn1XVVLbatQhwU3MzYY+0+DqIFqjmowQDUIuKrZYca5yk2vhVOoB
         L4Y9Tvq8aQyNrefrbmhvzdZB9J76cqwN77mF5+0TBKfrQjXUYN2esv1nZOPRcqBrXPPW
         ZgCuwg6reqBmQtKUMVJYftoLueHDXEI3y7UHUpAIi7GJV+WiykpHiQ/L4NYCNcn5r4C6
         eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669967; x=1784274767;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihT/2aOY8wGTL01WDNL3ZSISpn356Jmov1yxoJ5Q2Is=;
        b=EL9PzA/lXgDxIGC2QTpccarGcyo2MZQKYdJbES3Jqu7FNIZgwH5HC3ItMbWUYnQi4I
         a1qLr/cMUJN5iwtXJD0dZbX8EqDafYAkyu011bPujyp7g3XCkllImMk+2MtU7n0cE3HN
         4Oxm2TbGrBRBWvyuVwb20NI4KJiJppcwp8X8Y+fac9wwJG+COXPrjklH9MJ8Mgy6oa3P
         Cv2StblKi6xFE0/AV75zbfO7hqF7Jv2D6YcIta5RAH3cgQxQ/0GNvihNCDHreA/ziujq
         pllAIX4/fWCM2z9AQddj+Z7c8gicLWBTLJoruF3OBGjgVNB7Z2k1LG3Mn0l/pGQ34G3X
         T0kA==
X-Forwarded-Encrypted: i=1; AHgh+RoLumzuwVuHwPBbC3fGt66TH61lrxD5DDL6On5LGsR7aBRrwnJ4e2GGE4BEoloWGfcbkKPu4d+s3s+B@vger.kernel.org
X-Gm-Message-State: AOJu0YzphsmySsznwxztRDvB69CJQ9DCxB/cxiemllkhpVit+d3Oz/WE
	vosM75F8LpNtGTxUB8JT1CLxg4zMlU+WwAsZyqzxKMnLZtczb6/DhHxv
X-Gm-Gg: AfdE7ckjSX5BGTVmplAJ+/fL5T77Gbv7i9yz1FfaRQ62Fx5L8QrgSen1Y6CotWK7wbK
	o0HhT/QNf1Iq6ovhKYkDqHO26KPs0GmuDQTHmyYsbpMU9F6yhB8fQRUMLeQ5lmgEUVNNFSTu7L4
	qSEAsyKLUwiN9B6lU/dcTU9vIbcM03fWrVKBgycfvyiF9OzNSZvEapM7mxCVwFMvJwypOjGiasL
	3Lhzti4GnJ2FHNKEgJU00UbOnT3InBZIxeHbNTDIZzs6x5gttFpMpQ5AaJZTX8pSq8sjhD+bdYr
	gD9B5HvGxlh8/A9e2fyxG2D9QPOeGfSG2Yv6MWBpGhD/4KoVzkXS1bMmb1+hVg2U4Ph/7m17j8G
	KP/V5/vG3S5Q/UlzU0bCvf1InkOX6yjmM1IfDcHMSxb3BWQTdFr8NVfQyeNDyoyqcz/0rji1PgF
	txsHKiMQDljOeyTIKTbnPtLRM+/nEQY+UwGcbduE78
X-Received: by 2002:a17:90b:254b:b0:381:e73:3c2e with SMTP id 98e67ed59e1d1-389416e7dd1mr11435912a91.24.1783669966472;
        Fri, 10 Jul 2026 00:52:46 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/8] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260630045531.3939-3-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-3-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995928.1208691.248201589452077852.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=559;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=D9CFIdORg3KDPUuWXmjAR2RsP8Zpq9G9I7JzBgl41j4=;
 b=UkmRaKA4A5laoVQOHeU6g+5KHEhNh4nXv7y+97IHAPLwPizJjZc9yUiwBeTb07rPCZ5L7YjhV
 y/FrmXvAxlqDOKl91ohFaIJIf6Y3Z+PQbXebeX3Uf8dsWUwOiN5UCOq
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:25 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> The current scheme to directly patch the kernel text for runtime
> constants runs into the following issue with futex adapted to using
> runtime constants on arm64:
> 
>   Unable to handle kernel write to read-only memory at virtual address ...
> 
> The pc points to the *p assignment in the following call chain:
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

