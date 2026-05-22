Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAA368277;
	Fri, 22 May 2026 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487923; cv=none; b=Mul0o5ferEnxC0Ho7RqCtJNpHqeKzK+uD0ivz+L5kNBe6CpT631NCzxRnVB0HJDUgyLcpZeBeMBue5bPLKeL/uxmXfp2SNXT66cLUmgQ7TE8ovPnx/oqXXQT3PhFUnN5lzFxhvSS/GUZfGHGm+GvnaRLyG8s45TGy0WBhDzMWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487923; c=relaxed/simple;
	bh=VEFJLEEAH2zEOJ7s2L2xk0jr265S9jkfyIWFi/9YKlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbSFBi561PPHS6eizcv6dLT9nmENd54KCvX6eMSgBkuoB++1/pcCKPsWC47uptxLtpQKtdW4+Nei4sW5yB4Mfhwnx59usTFz1xmd93ph+R7YleP+FuAuln5wR5lQcjkb3prhColdu0aztEVvIzVfDdLP7G2myYC+jyzdeJh3MCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jCYDm7Sw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jCYDm7Sw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7GwqEuPTd+MR1zy5VZznoGmeEK7GKNhmlvjLDNCzxYk=; b=jCYDm7SwyA+L3wNOxm1f+uSwAE
	+4vC4I+TruXzHAcmMB7sul7EBVJl60qJ6dMtGzvNYM0ej9kn9yz4LlVrS6DxBefc5a3ni36XRnXZ0
	Yg7lmbmuMWqCTQtQ6ES3WHZc8tZuajOQpMZ/6AB21HmiGvIc7mMm6ZoIH/nsQ2ZRjiiO6Qy1zGHCD
	wi+erIveQtxha4Mg2otBnN4m4pdJqj6QC75CZzCIgfiDEVFVebVKjCKI1YUTCtVvNSS/642EnMiDO
	XSWHw/2wrFtzvNymlwH2qN3LmEQXd/9oE/hnw3UKNnuKXnVpwm0+2kQo5HOpC7QuLo5fx2qooD/dB
	ui9+8gqw==;
Received: from [179.193.2.40] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wQY5M-0054gC-EM; Sat, 23 May 2026 00:11:16 +0200
Message-ID: <2db4a7df-4395-4e95-8ffc-d7043459b454@igalia.com>
Date: Fri, 22 May 2026 19:11:07 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
 <20260428110054.oQNT-kMn@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260428110054.oQNT-kMn@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Em 28/04/2026 08:00, Sebastian Andrzej Siewior escreveu:
> On 2026-04-24 15:55:59 [-0300], André Almeida wrote:
>> Hi folks,
> Hi,
> 
>> This is my take on implementing the new vDSO for unlocking a robust futex in
>> arm64. If you don't know what's that, Thomas wrote a good summary,
>> including the motivation for this work and the x86 implementation:
>>
>>     https://lore.kernel.org/lkml/878qb89g7b.ffs@tglx/
>>
>> There are some loose ends in my patchset so I'm sending as a RFC to ask
>> some questions:
>>
>>   - If the process is interrupted between the labels, we need to check the
>>   conditional flags and clear the op_pending address from the register. Using
>>   objdump I see that op_pending addr is being stored at x2, but I suspect that
>>   this isn't stable, so I need to figure out how to make sure that the address
>>   will always be stored in the same register.
>>   - So far I have implemented only the LL/SC version to make review easier, but I
>>   can do the LSE version as well.
> 
> I am a bit behind here. In the meantime, were you able to check it with
> 	https://lore.kernel.org/all/20260404093939.7XgeW_54@linutronix.de/
> ?
Sorry for my delay. Yes, I had to do some modifications for the test 
(will reply to your patch) and spot one error in my patch, and now the 
test passes, thanks! Will send a v3 for this soon.
