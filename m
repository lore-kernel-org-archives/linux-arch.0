Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361683E0080
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669975; cv=none; b=m5+89cAUzO9m6R1fLakQOPK4EtRxfyF2hpiCYqiutsU56IwUseSs+guuJv/UdqbMb+T9qkBAc8suP8CPZkNVER1nIxoIDKYrMaB7j9L9FtOVW5DU8NTkxpSsRZ3mkXFnk4Xg1pS5G65pEW9aFZeh2/kMNzxdo+H+jScPWTzbZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669975; c=relaxed/simple;
	bh=Ag5hF8rTf0X6/MPKP15IB3NYCgooifLcPCObkTtH1N0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mrNNrWHi12sa6vhufkfJ0monPN7jCrkreku6HCtdsuGteI6R42038/rU/tVlYWmGo2uziatCWCn+bJetSNXZnRYb7j9OAN4PO9S0xvJqZxv3sAvFbpLIZebeb0oIiv5acmGHbdytcjLOrQPQwqFHjYO3eAIG6N9B8PWGwkuUMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqIAlwWg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqIAlwWg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9d265355so626696a91.2
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669973; x=1784274773; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1vKA4/E3v7W7bFn4qyJsED7Lacs/12A597rqBVPmfww=;
        b=dqIAlwWgLhPzaOtMkQ+6uZyiI9GlCBUzHCB6oFOnMhsvlq+ZXClcFipitD6q3onyDH
         wz2FAJGx14X0PZO1uOXj9mk/U+x1DKmms5Y7lRskrADZVVEwtoirIp7mIs29HLfxlP6i
         Kp1zaR0z+zMAdMZNpk2cD/tTtTce+9Vk2Echnxn91jBW5TUQN59TNhA94DapmI1ELJkK
         TdPtFx9wv4Tis8KmipIg5uRsDUHJKhu+qwFcJGyGdR0Eze1UDBgQC0JCm7DcpE+biIb1
         3bsUuz7s+inWfZQ4h/9haq+NkQ9rGqSWCs2RiIvm1fpzhx7ablXN54wwibKz7NrPmtxm
         alYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669973; x=1784274773;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vKA4/E3v7W7bFn4qyJsED7Lacs/12A597rqBVPmfww=;
        b=DXTlqpb8Cq8Z9eQHKgCA/MoJD/LEJc65P/CjelFx93BoIx/8fCfT4iwi+B4r+wL5LX
         s16QDYjs55NQGe1U/Qqi+nK3N+jmiV2nW18CjnOKB8DrGOZVj/4Y9DYuvPVvVl5uvW4D
         1MGUW6tLXp0TIjIh35yTSUa3oJfWuUEGRdDpgWg+mVtF3s5tKRNLdhbqulkw2xdG0OhA
         2ZlsRQDfphNBuxM9k2qw2ggSKnlMZ0Q3G4+9kj7vFLPOfehwLPwWaptO4Ef7E6ZPig33
         K4K6Q6BkCIC6YZG2F1klxWaOWgXucMz/EsK7YidlDDEp5uTuk8VKkFoOWvkq9u97yhnk
         Wilg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7JExS/h/kOsfZpHHG7+VFoIZq0mMDgzq5lTr0z+nLKuJhZ1mwGcPiOdpsSfnq2n5ecu/g+pbm8udS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jd7U3AhggJ8TAnYMuxNLJIucMJasAH6E0STO20itTbL1cAIs
	rEcKfKamXQyFnsXWSIYEnAoSHecgLjPsoCr1+bhO+RultwVyJCX8IDyW
X-Gm-Gg: AfdE7cmIDbjcBT0ys49jxTrM5z3J9npJWZCtnEomxFKtwRBGW9aBLFJOinZj/tPUWzU
	O9HuI1LOsTyBTjwUqNd64IHwVON/3xhtO6+JtK5Es/YpSnk3Yw2GA/6cuvtZrw4MRtARyldUSUw
	rTIyr55olMTN6sYNIiD3ULEuzD0V/kgrxp27bJhFQSlAAWelP7t/Rlhx/uM8HUvKmN18B8NyTaT
	AyjoGaSTr2JItpoDz2/NH3Yh9KQ8jWrYjcXCz9x9UqEW9jxUwqxwM9ZGmoSBLdg89l3nZ4ed/49
	6PzNcW7S6vvBGnA2hHENbZHqOob/YNvB3SSf7OYf3FGRDToDHmpBUe9hRpP2n5HYN0hM/1/Zvo7
	ov0xlBAFnMgrkUQ6mO+6i1Byr+HM2KkxX5qasRJxrGr4holQ4JMjtAQtVsQAAY93hSg1ogR+4xR
	+eudEJIzwAA/0tbADd/HqPRVbCVrmr9x9sp1oBi8Ch
X-Received: by 2002:a17:90b:4a0a:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-3893d530961mr9707655a91.0.1783669973502;
        Fri, 10 Jul 2026 00:52:53 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Thomas Huth <thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995932.1208691.13530053283560063106.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=632;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=Ag5hF8rTf0X6/MPKP15IB3NYCgooifLcPCObkTtH1N0=;
 b=XRTUMqEADW+KZk3nC8Ii+QzcGXzNTGq2bntuuyEk/nB+Q7Rjvlcqlgu4/3V3dHA5sGTlOTVXe
 qfXYMGUnVW7DGepiw3HKFoSXdft6CODFk3hsmUjcgJE6PD6p4836N0A
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:31 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
> 
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

