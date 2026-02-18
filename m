Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985C1E8320;
	Wed, 18 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447800; cv=none; b=bglcQVYcOF79g4BG6PdQPaclg4dscYXslmvrrYSbvssVSQm6sxBVBtuCq939n7yt9lnb8jrMnRSQ71spS3WF6/NqpTRXshtw67hoGPhkHQiSEOaWtPEy4S4SUsQuLRmo0VnJ6pvxAZeQ052PM5BO8sJSeqQOShHuqBe/472O6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447800; c=relaxed/simple;
	bh=O7jCqB1LzGRmyzFixtt5nhIzwmqbq+PyRe37vlBONcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2sVb8pAtwlyDWW7u72vSVY2F0T0QZNQPxnNHrQxm0U3QAZDzoh9/fHsPrAlbzsi+uFVYt+IMRUkw0ilSEDpeHGJh4mM+GcI3AWPOMFNN6Rsg59OzKHmpwU89eXotMU98WBOpt3LAknPh/0Mi460fC7epBl6pZiBtUBFjkKTxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ke7HU0av; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3KZtHHT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ke7HU0av";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3KZtHHT"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771447796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YRbJ7sWZ1F/MsCEpfwcc9kIA5hPyIXS2Vne1Gmds6A=;
	b=ke7HU0av8n34RNAGPfFQM7V+Cqv44w15wRVQmYfr0lsmUNCDO/AwpPE296GTUIK0YOUFYD
	2wLm8GHVMqwh2mbfiKQtGkNeVzVuSyi4ZzWZyzxG2KxnKTaascAyaJYiC6vC4OMW2nufew
	QrEWVSUizDN6U1//iineDno5/PazxnAH5Zk+PZacOMsY3IFMCbZyixFGvcMFmnEi0f//IY
	W6Al6/RqIZOlBaMovRjbp1nlsjxHJBYO41zpQdGuMJokFeb7EEJY3fGwhDNlxX8n3elm9T
	p3drA5Ibdy3snpAZwFo9A04gAX/lIoL9FO+Ko1bgrAArK/N0fHfHKWTW/VCPdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771447796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YRbJ7sWZ1F/MsCEpfwcc9kIA5hPyIXS2Vne1Gmds6A=;
	b=i3KZtHHT5f87lz4yCeC2nyMtW/zi8wyJD1lxCLgfod20O9HVoJxNCJ/ls83JoxQJh5gvmD
	D065Ebxn+7ixTfAA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [QUESTION] is vector_lock needed in apic_retrigger_irq() ?
In-Reply-To: <87qzqjw01o.ffs@tglx>
References: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
 <87qzqjw01o.ffs@tglx>
Date: Wed, 18 Feb 2026 21:49:55 +0100
Message-ID: <87o6llwzd8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 17 2026 at 22:08, Thomas Gleixner wrote:
> On Mon, Feb 16 2026 at 21:44, Luigi Rizzo wrote:
>> apic_retrigger_irq() grabs vector_lock, see code below.
>>
>> I am not sure if this is needed, because the function
>> is called with a lock held on irqdesc, so I think the CPU and
>> vector should be stable.
>>
>> Comments ?
>
> You're right. Any action which would change apcid->vector has to hold
> the descriptor lock.

I did some archaeology. This is a leftover from the v2.6 times where it
was truly required. That never got cleaned up after the whole vector
management got rewritten and the reason for the locking went away in
v4.15. Nobody noticed :)

How did you find that?

Thanks,

        tglx



