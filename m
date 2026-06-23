Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2C3A960E
	for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192368; cv=none; b=lhdgZ/XcEsCam+Fv3lLtmxymIuCuqV0wTI0AN0PycbYhhOFpcUY57y4xpYAlOw6jtt7IUQaAV0ZRdFAZ8RvR8YxrMkX6yXT/rXKqUH1G5GQvQT3AXz5TT+aWbaM5lSJJtdnHp5adRqUQ60we7CADaEJWaPK4IFSkbGah6KZFICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192368; c=relaxed/simple;
	bh=n+I3lxePERllHyfwEWyDEAhZnniet1N62LffQ9iv1A4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=eLDWuPe/sb7nwj1B8fyRqeU/8mxzfxxgxLP+NgXY6xKnEiF+f21f6Ad5T89nDjKE7g8extjtAzpu5O0yUP3FuzpdPM5JhbGQyRK98vk/OM2YmJZ8A+9VU7R6AADbbhzgGyIyoRLNY9EJA1U4wUYzWZDh22vs79wXoHrodp51fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYcGli/P; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYcGli/P"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30c591fb1cbso487632eec.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2026 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192366; x=1782797166; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euxUr99gVRmTKzYrxOsYTZTBpKcYj3aY+Du6bnH69fU=;
        b=mYcGli/P1lJ69hPdMg+UpqSD8tXOmM95KZ2M03D4tDHK9HJBW6oa723omPDh/LDHLT
         HaP305+JZb1qBBLghQTd2fIl/DlV+5kVPnKgQ9ggaJBhEQPMeV121rcAWMqpMJVmBBGQ
         lwqw2u0Z6WCJdD1bNVENJOEP4kEw966Y72KsovZrO4ODgjYMIgK50eZHg2l23IaxwlKX
         4hw3/qdl+qg0WLA6wz4X7x6MrlSMk2Q4crfX4UvzrBPy6mqHxTurizOUkyQV0V8Hlz7o
         1U0uGtyr3IiNVPiy+4KCLJH8s+MRlBSl3YdnxqEvqCQy/IMrAWfI3AKr1JXlyk2IYzf9
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192366; x=1782797166;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euxUr99gVRmTKzYrxOsYTZTBpKcYj3aY+Du6bnH69fU=;
        b=GxOn2MsMPFc7mt/VeDC/NHC35qMCro4WXXnyzkBEipJg4m/uTDGRtH0rqh8snq7jFN
         7ESr+0RsBs0TEsMDcVew/34EymQX/doIKQuY64lEmqybve5otnbzPcZwZHikuxqk0Nog
         LcLST3uMdY14vlAgawvqWPeyHm0Pa/euNjBgcc4l8yAvoS/zoX7XHGb7pGS+t4x1zODu
         JizoLHgBQTGiNIeMaZbpVJoQFGiG9PnlV4IrXI8x8bRAFwyaBk5hz2y2LuRWBqMmZE9H
         nGDJxVGVT8f0lwNWj5IcMwp8UQPwwNZ2pIOAXuHaprUoT1/1E2OAr1TuhLKA+aJ3XCxP
         MkxA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5iQU28r0B1CgIBe5I+VTUVrrJS8s5QAEqNwU+uKv3Edru7JH5t99s37rVTNdr2nTYO90q2HX06nKB@vger.kernel.org
X-Gm-Message-State: AOJu0YwWga3/jRjDgCK6ndpEpkmfyvpc4JsfcmorKHcR83zvjI+xk5hN
	RhgF+EgfBMM53KDNme5Tas9bHIz9ABhjUnJH7fg2nuLci+X40bF76VuS
X-Gm-Gg: AfdE7ckIpQKeFxLwJ+IglMu8g4RfAGES5tYGWNOwlfK/eXWFwOJ4ru3sk9T80m7hU7W
	lPkis5QsNZnAvSOxSaJRYut+Py0Pl8Mpw6yMUiIudeMSWboLeP6uLCG8BSY7RBFADX7BloV9iwY
	qmp9AQ7uiRygrDzWN3V1GG5qquC5tGdwTwwhIRK4PuHjrWghoRkMhB4i/yo3KlaejFgzhIOcqCZ
	XQa5eWRvCVbGw4E7OFFhKX8iByCwwz26LNi3JeNIGgGRL0/ZYyKkKVw8Eft0yvNqk+Qi8JwfMEb
	SxoMhBqjsLuq8B3TWRS5TBvdsouPHMllFTe12DhzdQzk3w4TRcc6LHF6mFIlQF87ZZj5Oy8ObxS
	FD6XJPG+aGoJPVWOTX/1jFMiHb+jDOkKvRk4+zwl+Cj2dJa2GQnJOBirdbX2/bb6P1EdIXaCs74
	vRisWYgo4=
X-Received: by 2002:a05:7300:fd04:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-30c5b87a4c0mr708300eec.19.1782192366092;
        Mon, 22 Jun 2026 22:26:06 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/8] riscv/runtime-const: Replace open-coded
 placeholder with RUNTIME_MAGIC
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Charles Mirabile <cmirabil@redhat.com>
In-Reply-To: <20260430094730.31624-5-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-5-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229642.10927.5804159175321604816.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=610;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=n+I3lxePERllHyfwEWyDEAhZnniet1N62LffQ9iv1A4=;
 b=BbyI070isif1KhCepDopyZNJYOc01bHzD6A+jVT3UijnT3HrwXWLYOswSXorRMeV+HlI4Inun
 OKgODIqIXrUAHVTJFNoyMxYBsj+Slz8Acjz3vKWxwe3qbx4eUZs6N2L
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Thu, 30 Apr 2026 09:47:26 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Define the placeholder used for lui + addi[w] patching sequence as
> RUNTIME_MAGIC and use that instead of open coding the constants in the
> inline assembly.
> 
> No functional changes intended.
> 
> Suggested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

This is a great addition, thank you!

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>
