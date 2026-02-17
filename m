Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542D3793AD;
	Tue, 17 Feb 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362504; cv=none; b=QfcXuMB1RGAkXs3iXXLFC4QalYPrzp/g1ICIgStxTLkhmDqD60xN+3QDCdO4GUG4SFWni+uwQaVav8viUP0pfvpHlwOGu+SkPx8pHJ11w2qS0672DUbkS9WaAD9wAtJYxmGAg0UkIlhTQm5EHbMzd0kB0bjh/3xscYE79MY1joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362504; c=relaxed/simple;
	bh=1GDeeYviNIJWCltLZuopzNrA0y022LklHsQSqWnqfJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgVIZsgTURoZbG1PTBO+MnWQHxtku0ToJnMABTzpTuaj9fw5HIN3SkijjwH8n+gM9c3ZhHYCZLO8USlxx9fJ6IkvvUuUlOuXLRqTT7V1m3bzQvW1SBynxxKkYVgDYIbe8zf+lXx2Ag+IpA+1JrNyWiCEfVOHwomumpp/zWtFgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbI4LiMa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EptX0v+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbI4LiMa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EptX0v+q"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771362500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GDeeYviNIJWCltLZuopzNrA0y022LklHsQSqWnqfJI=;
	b=PbI4LiMawjfM+H7hx9bx6mf670na8IDWbX4T7VjcXybX9mB+5uirnd1Yh813T9/Sh02IdY
	KO1FnBFwNbItq1zSI0BVl7/yizLGwOnrZqEVABZPVH80SLWUO0Je0x/PMza5UOTvg4DdNl
	NQ4g3EBMYIY0gTOeiayLBtsjgjqeWje+90fonz3htyh0epOaJA/yDYH86UZyJQQi4HYGVZ
	Xbx94IU1mmYLCvGnreXhQzAX2e0E5dtLL2o2acf7PAEO72FOZLWj7vNOvDLo6Q6wAw92Po
	F06nmmE2UX+Y+Zg+yV9KpR2FsP/Q7qMyk0NoXJ6Xg9xy/zXA09SNGIAGQoBY8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771362500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GDeeYviNIJWCltLZuopzNrA0y022LklHsQSqWnqfJI=;
	b=EptX0v+qUXx9IL1S3D2KFaJD7WK/WVu3czh2wD6IZ/JKc6Adh2JDaluYFBR0PSoilJqM6F
	q6ffRbXiepvKQGAQ==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [QUESTION] is vector_lock needed in apic_retrigger_irq() ?
In-Reply-To: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
References: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
Date: Tue, 17 Feb 2026 22:08:19 +0100
Message-ID: <87qzqjw01o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 16 2026 at 21:44, Luigi Rizzo wrote:
> apic_retrigger_irq() grabs vector_lock, see code below.
>
> I am not sure if this is needed, because the function
> is called with a lock held on irqdesc, so I think the CPU and
> vector should be stable.
>
> Comments ?

You're right. Any action which would change apcid->vector has to hold
the descriptor lock.
