Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B35947F0;
	Thu, 17 Sep 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656109; cv=none; b=TZeW+UKXsARTjupn/uD+ctBnCBCZu23wCckcKjHMuP+iTz3F2LT7wB7WAdoJSqo4nn/n6cTal+N04WYuWb3larjul4T+uEEJS239rqQunWG/9qd17sD8BapV93sHaBI7PqI5gTclzHMG5K4Guav+iHUX7ZEbCDR+aNgCIFjccSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656109; c=relaxed/simple;
	bh=/40qeCAu2c2iCq7AZWVtJZPRGL3BfJ0QZKW0imz61vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9rJeipBzz9bYYTOdR97luYfLaI+OlLkj1lvP52qYNz/OglJ3UjmvQrrX3bCy0tKN+K/Kct2f5BpqKY+OYagnzcPhwAwQgswirENEEUaMVUzGBpYSXIqmIPTMnWdRC+sIkbAqtY097RlvptebkyPr0cx3zHYNch0WvA6W+swO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KL9WhOlA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KL9WhOlA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=AcGlwILbAigYPbHp2UpTCzPJPin2iJgiGFZE+fP0U6A=; b=KL9WhOlAUJRZ5QgUzNtZiS8IlH
	pkxe8NN+TZJcfiAZ5s+JwvNtO+7Ez7pcbfVvCqKU/7JgCTILNHEiKwicbxaW0ivRJomjNkyAkLCXD
	aXrAYB1ZO5XaFp2bW4wK0s4DYGRZnyAJcdCV7Zyrw5ZvWVjpA0TefVpzNB9OX01R9pciJVeiVLCaZ
	0hkZEkTT4t2ZBzL2i+Z7o66ud062Czqazrrf8RKuUgQjfBK+DU28gy8hvFL8MZ9/gYtXh4yXt06Pj
	MuKxucN0l1CdGykw2Up7LWD73GQ35lBs0Xgvpsw8L7YzJzgEorjCui9h3xvRexJ78+aLTqQzzISpt
	F2NpTMWA==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7DIa-003U2s-A4; Thu, 17 Sep 2026 16:41:16 +0200
Message-ID: <23596300-b89e-4cff-a6ce-e7bf54e90c05@igalia.com>
Date: Thu, 17 Sep 2026 11:41:15 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-4-077707b6f1c7@igalia.com>
 <aqqngEKC_CsrS62n@J2N7QTR9R3>
 <d0c5ada8-929f-4d39-9f8e-32860fa5b853@igalia.com>
 <aqvGEiZEtZFEWvjL@J2N7QTR9R3>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <aqvGEiZEtZFEWvjL@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/09/2026 07:50, Mark Rutland escreveu:
> On Wed, Sep 16, 2026 at 10:11:01PM -0300, André Almeida wrote:
>> Em 16/09/2026 11:28, Mark Rutland escreveu:
>>> On Fri, Aug 21, 2026 at 06:50:45PM -0300, André Almeida wrote:
>>>> Based on aarch64 implementation, provide a 32 bit entry point for
>>>> this vDSO.
>>>>
>>>> In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
>>>> make sure to store the pop address at r2 and the compare result value
>>>> at r3.
>>>
>>> Before we add this to the compat vdso, we'll need to implement this on
>>> arch/arm/.
>>>
>>> Otherwise, my comments on the patch for the native vdso functions apply
>>> here too.
>>
>> Right, and the compat entry point at arch/arm64/ would point to the
>> __vdso_futex_robust_list32_try_unlock implementation at arch/arm/?
> 
> So far we've had arm64 provide its own copy (which e.g. might use
> sequences relying on ARMv8+ instructions), so I think we'd do the same
> here.
> 
> The key thing is that 32-bit tasks on arm64 should see the same ABI as
> native tasks on 32-bit arm. As there's a risk that 32-bit arm might have
> some ABI quirks (e.g. due to older processors), we don't want to enable
> features for compat tasks on arm64 before that's been implemented on
> 32-bit arm.
Gotcha, makes perfect sense.

Thanks!
	André
