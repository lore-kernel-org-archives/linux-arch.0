Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67B3264E7;
	Mon,  6 Jul 2026 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364598; cv=none; b=pOQEiYOS2AN9wh4Uqy5inKS/nqz4HOh8qlEq55a9umawBppeFrTIoRWuj3/AIM0gc+ek4+JJ9s0HAV2C3DVmz8nlzkAHK6u4teb6xJe2tx8crXrN3ZcwnxvVg+RyRhKtAXjtF7FaqJnT2gDL+S0pqRZiDNTpTfQfomO+Hkxz5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364598; c=relaxed/simple;
	bh=SZgwM355FagWdXRVFpFTnTC0f0jqRePuyssaX8ULq9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQElJiFt7X8++WdqkOeBZ4vZC1QvKUuPs9vqD6JQweW7YI+1v5C9e1DtRLJxCz6hnCUQfhllJg0IRxjanUCLZMZCDyrZBQBSRdVuS09xjEJgsM09srSBC+g7FTZi1yUWDuYMOTV0nFzuOaitS5lhgErhR4V3YvqNbWac5KiNfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UeVAjPhI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UeVAjPhI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TulnqDkg59FUxryL3ptCGcm21LX3Mt6uGVOMyyGg9JE=; b=UeVAjPhIMhfIm2xnQeMe5orSBM
	uayF73MrVjbGWrJ25XxvjD2d25sNcK0zKrEuCZ82LjAw0ZU2VY2I+URjnSfvinmrbXu1YmDqqm6le
	lQnl1a2bJF9kSMa2iHXsJay31dO7/QtzAV/P26NJeLBC/YIMhr/eqLnc6nBh5BuA/p86n3A3KefI7
	0S9+ugrrdYnUv7PBoJ/TnAP9FXIUHA+82RsgblFGeidTyscKAxv7hibM7s50UyhHsHXpxwOz/HWZz
	yjqf8JFo4bYrckHItBIeesMLfLAgznr2qV/vSng4KMoVZzw9xaImOty3UnWZrWV4nSv97nxlt04+A
	t0yEeGcw==;
Received: from 189-68-33-146.dsl.telesp.net.br ([189.68.33.146] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wgoaH-009svi-EM; Mon, 06 Jul 2026 21:02:25 +0200
Message-ID: <84ed46a8-54db-4f48-9d59-5c06cd020c03@igalia.com>
Date: Mon, 6 Jul 2026 16:02:17 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: Thomas Gleixner <tglx@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-dev@igalia.com
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
 <87qzlhjick.ffs@fw13>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87qzlhjick.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thomas!

Em 05/07/2026 17:23, Thomas Gleixner escreveu:
> On Sun, Jul 05 2026 at 14:56, André Almeida wrote:
>> As explained in the Testing section above, we developed a test that puts
>> breakpoints in the code to test if a user code being interrupted really clears
>> the op_pending pointer. This test wasn't initially working because of this check
>> at futex_fixup_robust_unlock():
>>
>>          /*
>>           * Avoid dereferencing current->mm if not returning from interrupt.
>>           * current->rseq.event is going to be used subsequently, so bringing the
>>           * cache line in is not a big deal.
>>           */
>>          if (!current->rseq.event.user_irq)
>> 		return;
>>
>> rseq.event.user_irq was always false during my tests, and it prevents the fixup
>> to happen. I figured out that arm64_syscall_enter_from_user_mode() was the
>> issue because it doesn't set user_irq to true when the task comes from a
>> syscall.
> 
> I have no idea what you are babbling about.
> 
> A syscall enter never sets user_irq to true. It's only set to true when
> an interrupt/exception entry comes from user space, i.e. via
> 
>      irqentry_enter_from_user_mode()
>          rseq_note_user_irq_entry()
> 

Sorry for the babbling, you are right. I got confused by analyzing the 
kernel stack trace after running the tests and wrongly thought that I 
spotted something missing. Please ignore patch 1/5.

> No?
> 
> Thanks,
> 
>          tglx
> 

