Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDD2F362B
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669973; cv=none; b=Y/wQbqLuWNExX++jqu7jhAHu120T6C7l+cIYA8PoaWCGitD4pFwgOA5Qx57EPAQMPF5KfnP6wl3m889FeoZllnZohYd/EIiUPHF5aDb90gH2R98Rj0LqZOatzJIWCHIEHEJ/u45lXHApTunK6+1ipHkKtC05hXFDG8E7eTCLw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669973; c=relaxed/simple;
	bh=339QwCmoNdOUhoq07+p5mhlOUQoPA8Y4kjfe9Kj1h/4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=VeskqvYiwAx06p9cvOEOkGV0rCzoZSTGHmvUxTPRFQ4taLQFug4iKNdPPVhqJAuush8ZhXNF/4rzCZWFbbCBghVh+TTr1L7zCSVehhIlTjAWXPjWFvZATjmqIquGPc/YAbkpga0dSdufq3+LMKK2W54Gavq8N3ncD4U2XLp3uJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1iIlHTI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1iIlHTI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc73e322dbso6227405ad.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669971; x=1784274771; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XxVWLkjTDZhg2ZpXoG0uLB6wK5WtCztBheSr28w2OfY=;
        b=N1iIlHTImR6P4mebLCg5vdSX9XtVJlsqGIYYGAfa9xAgUP0E4mBMkaMto1Cl5Ku0Sr
         xRV5GH+GQomieQe21kr3A1PkGsk0qrcMVVF6udpjmjn35wFJ/yqK0OSEBTSuaVOeKx1p
         QD2929oYu+nsKEeDGTH1GbQswjzHOOX5aDMnR+JTdPXksJS9qpyn13SIGPfApu0E6o6e
         gujGVhZ/1quoJhB+yHuC6GnSPeIoyIjIdvOYh+1uuQlmNm/nu0Gub7tOEkjnuBn/YI82
         R+0+qJdEtPYdVwTJL4e9AF1yAJZ5wcUynwL/zcze2HAo4Ks3SYiU/QQ/sHLEvQJQhqdR
         CuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669971; x=1784274771;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxVWLkjTDZhg2ZpXoG0uLB6wK5WtCztBheSr28w2OfY=;
        b=YkCAFztPOEH+q/sWIjc8MFJZzzb2C74LPxC31Y1gy/bdA1uMN3en79K3n89ucOdMPx
         nBYdT3opWX8bDj4j20h3A+tQ5JqroYDof9GyuO7AuTPpMKDs32js1xw7OYtCumkCoKgQ
         ej0Mg0V1bHmjst/CpUFrF0E2rfJ8rFyFsbLChYI/pj6vGbAkuOSZcrgr4GhFC8Z0sEWd
         vcC1DzZtZ8PZwoez79R/w73DnQL45LuE0C1LlC/vHqOAgAE3CVK0jJop8/ddTKTi/BC4
         tz0HgBCaZa2fPqgrid7/YkRCKjA9ly1KJg9EqCFG8fQojxwVPY0C0kE9RMR4ZVtesA9C
         6eaA==
X-Forwarded-Encrypted: i=1; AHgh+RpYY/v1AFytjkLCvqpPyrhiUR05fNA8kCDV1FZ6oqBipdbVo4Kml0ODvY6JifQ1L9FF6rQxH5WTuFnI@vger.kernel.org
X-Gm-Message-State: AOJu0YwaentWkd1M1Db0emN5ZM/brnRwqJjVZfG92o1qaLcOKqnDYbI9
	mlrFQr59qM3zG2x4N1scEU8HWR8nxTK88Q6k5nOViHmJJtQdWEUXrLO3
X-Gm-Gg: AfdE7ckQ32srXP+zrRW8V+Svza2XJgHBzyT1jLSOVSht/EE99trjrS6E4SL/qMA/jn3
	dCjxDmI7aLOUPBufXbrzxg7Y7y1Hebu/ATUvcBl33/DB2mpXEiArFrRsNZiMfD1vP7zb73LELcm
	Nr/aWJTUg1QZPN1rjOwUnei2F6iU3hxp1v7GYNJI/wf8SYxBVLtPCW/wzemA0+MyKWCYSDf7Stf
	QfBXWvsUakGRL6AVI4KJ05HRb5tOsAkWNFkfhDbE0Q19cbQ+0gB96hpr/VgFqqg6oEuEGwiMscV
	FD9FKp9cRGGbX+QBEL8wcD7FsDXVzN9c3CTpq9x9TMaGGaujEJfgUiT6/qcl1LpjiUJZ1CQTh+5
	ZAqZLUPA0wOQBL+1P+0MSFr3qZ5YuApjaICRqrivNrK7uInnBLDmxDOb78JZufSpw0UXIUTMoMO
	0ACSAtUTlIxbhhDC+XL1ZA59z1INZiywiP+7P9pJ+7
X-Received: by 2002:a05:6a20:d045:b0:3b3:1b38:d9c3 with SMTP id adf61e73a8af0-3c0bce1ec2amr13936533637.4.1783669971391;
        Fri, 10 Jul 2026 00:52:51 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 7/8] asm-generic/runtime-const: Add dummy
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org
In-Reply-To: <20260630045531.3939-8-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-8-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995931.1208691.16267083905782992990.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=326;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=339QwCmoNdOUhoq07+p5mhlOUQoPA8Y4kjfe9Kj1h/4=;
 b=+du2Hkd0RyMKi/EB9cZncyqJjA+YBHOqCVom2yvmO99t8UG/3SEUftV+TbybYm/IXhHQS2fGb
 d+Eveyk5xyHAx1lucH8A8KAbw7r8Wb+AaVQqOSex2YBgPMjHQHcvXwN
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:30 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Add a dummy runtime_const_mask_32() for all the architectures that do
> not support runtime-const.

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

