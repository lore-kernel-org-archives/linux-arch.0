Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90E3451C6
	for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144448; cv=pass; b=oLuVsE/TXAI0PT4E5Mb91RUKLglo3cFQXZCKz4yzdcsWG6e4Ov7Odz6bXtx8sNT1R78wqXSCvhXxFx0SqWwOczcdVsVlRxxjo3UXBmOdf9YKJSxqjL//u6eW/wAhK9Byj8wwp3yeUmYyM8B4pXNig0BMi1H8XC/FkyLE8EXSklU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144448; c=relaxed/simple;
	bh=rK2Egzh6q853mbTXFboVhWeZblPwY0a+u6ln8hIdTuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9WAVLFPIiJtVThp74tdeM3u9Lj6PrZAtoOe6gpa7vGNdZTB0OFE5AdI4GT46IJjEQ0sP6T96TwF3EhhuUu/t8Ut4hT1vbsHtaRxuD6e6TcGKRFRCnLWd/JK3cKqGUxOfqqlAolV/TgmHGYJ3E7tEqY+YzWVbr5/U8M56U1LdXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJxocY6g; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJxocY6g"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso60375ad.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2026 06:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144446; cv=none;
        d=google.com; s=arc-20260327;
        b=C5Ee87Btl0h4IDqv7C6DChF92I8b7Yr8boAK4kEkKBSbDx9/ekq2cZ/YFqovyoGzBK
         KuUtYQIjbStifoEExEgoiRNLF9XEgfDY6v8hwEjVw5smEiCTogczD/Sd23DbV86wI7ui
         EF25TtGSqPGndABHTkZ3+4lcIOnr8BJ+6DxXBrv/n1c/+Re0C5K7ezx72XLyD6eE/Pac
         kUOoVx8AWpMrYVssuRQUXieLeVR4N6vBse2ymaaXDKDAVkvUIsiCbqmR6wmycwuDrMEt
         GWVLUOzxYZguj1j4PEWZGWbslmY76nE8X81LF7LbR/aW1W2HYe1kooPEbYC32M/DXxuI
         iAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GezpThl44Y70B0Hz4cyOxzGojsCnraFYxDTWdS1cEbw=;
        fh=RMwUWRTuyQt3nHvP5YRLwIR/P+oKIxNZzM9nX8sgNjw=;
        b=Y1F9tVmVX4zhSZHA+gu8vOancNAIlw5otG0iMNOQ/7nJ/0Y1xpSD7DuzsmCC33XVwq
         PpBkttkuDUJ2c4f6zl2WmnMyY2MlENDaq87oltOHiLoiTKSt5AgYwfEMgy+CrFa8+wbk
         Qtls3iCFqWROUl0NRqL7avA66XiP7xexW1fBIoK7gBObHcrmDfzsAnlsUSOCqWxyCCUl
         9/bDCQe4vrL8yzXu+OpdUO132e0AiCuGL0Fl+hsIieqj3jRgGDMIBtoZOorlW7xF5xIk
         Hy0/v5UYOTl2JUes0c4rJe1tvyJ72xOTqin4y6qZI+waCtSPLWxsm4Lzrzp9DqvO8onp
         HQhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787144446; x=1787749246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GezpThl44Y70B0Hz4cyOxzGojsCnraFYxDTWdS1cEbw=;
        b=NJxocY6g00cbvgy2ynL8RgeJhs+xlIHNyiMm6P/iLrgytAvjYUxL6wQ6d7iMK8m7xP
         kdzPujX4WSmQRnAeKynJI/uZz8/rJmsTU+ynR/SLtKNMZUwq1hq4g1IRCPMdAIuNLcRX
         k87hGqUhyAi81EKXk+Kgj+Xi4PP5kVMHdUwWx2ea3UZ9Bs0OxuO8lYrQzeYKV9Zq6sVU
         4SsA+BRqN1H3CtSySqNNDvOyaBQgzKITC+XyAa9ihWhRJp4NRLPmcaenqyj9dTYl+ADl
         rKlpq2QzIsEW9OYL9ex/of6qGb0OdGmwglJ+iCEUPjoJ8B/SMwcY7+62tXFXlQA/AJpc
         7Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144446; x=1787749246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GezpThl44Y70B0Hz4cyOxzGojsCnraFYxDTWdS1cEbw=;
        b=Al2rpPl8hym9ubYgxA55wYfT1aawjaxjYN5E/m9cDY1K6SAQT8U2pr7hv0Ldn4SR7F
         5YdpnqlL76eq5GKF0jQn+f/V7PsTLUbuAayBsEMlcYDdQ1gyS39cdBztruRTGmuvfEA7
         /tJCcH4CQkATlxmhDXkIZxK4LvmkBolcgr/GE+7bTFXEPVlgB6dPtioNgIRRkLjiA5iP
         AuoPQfXwzxGZ+u1Ur62MUsYwmhI7En2hIgdZ4WplOpGXOxsTmomcfcl6dMS+Erpoi3yN
         KDQk9CdMiYAB6btrEbANuHPXnosu6qNoiGzFqmQh1Dyf1w7sQkMyygU+BLas8dJi4BfN
         OPKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtL/HjiN8lbc8PYMKTBB3uEcg3nqGiC365oK33DZjtF0Wi+a9eZNKWatEX9S28LnMORjwfOCDWty5I@vger.kernel.org
X-Gm-Message-State: AFuF++kf3fY8Uy/YZvQoapXs+7CoX7AXIhDgivbDPK4p9byLjzsdjqKa
	W/nost2GxHfjk1DLD05/yYUvMSYnCFMPJ3zNQD35T5iqD7Pjg88WuSX51vW8TZSxA+KUGeO3keF
	hH79dVtmk+LlmMN8h/wXE6vd/+QtJQTTsfUgtFsfX
X-Gm-Gg: AR+sD12u6u/+YaxHJhjpEiwMzpPAMO8ex5AfCqrRmmj6K4U7m/gnh8jhkjEIWZRl4xU
	sLBJN6ODVLHiK66p6sHfS9ns4ssSO1Sb1k9+y3XxIaYrYoSsvNAMmorxeVdGP+o2zT+gwemHEoL
	X8c924vZ0PFlEFjCGk3akBe5zILwhEoXQ1d6KYTSOj+PqCAdVtdI+ggdAnxaWMaf6Fu33JVv3qw
	HWU1DdFyv0ZW3aEoXPSxbecrmjr6DrkA0y3a6lCje1XFz7wN5OhTXfynfkJSMrxhrbPAaEvKEnH
	intbGwVeW2tylaq4kCCOI0uocZWcBq+wnhTBjHQJLfy2cw==
X-Received: by 2002:a17:902:f68e:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2d5fd165544mr5258175ad.0.1787144435047; Wed, 19 Aug 2026
 06:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220151216.873182-1-lrizzo@google.com>
In-Reply-To: <20260220151216.873182-1-lrizzo@google.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 19 Aug 2026 14:59:58 +0200
X-Gm-Features: AcwNN1WnBQvp5Fq1o28r0khTikYlwZ4gDfMVCZNCglJvKeL3RPuJ-A-KBMtuduk
Message-ID: <CAMOZA0K55H+tcMzyem+gUBfRzyhezPwuGULrOpT2FMahdCBcDw@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: remove vector_lock from apic_retrigger_irq()
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 4:12=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> apic_retrigger_irq() grabs vector_lock, but this is not needed because
> any caller of this function holds the irqdesc lock, and that suffices to
> protect apicd->vector.
>
> Remove the unnecessary lock.
>
> Thomas found this is a leftover from v2.6 when it was truly needed.
>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Ping..
Is there any concern with this patch? We discussed it back in February,
see https://lore.kernel.org/all/87o6llwzd8.ffs@tglx/
and tgx confirmed the lock is not needed.

thanks
luigi

> ---
>  arch/x86/kernel/apic/vector.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c
> index bddc544653999..fd0f133b379fd 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -1002,11 +1002,8 @@ static void apic_force_complete_move(struct irq_da=
ta *irqd)
>  static int apic_retrigger_irq(struct irq_data *irqd)
>  {
>         struct apic_chip_data *apicd =3D apic_chip_data(irqd);
> -       unsigned long flags;
>
> -       raw_spin_lock_irqsave(&vector_lock, flags);
>         __apic_send_IPI(apicd->cpu, apicd->vector);
> -       raw_spin_unlock_irqrestore(&vector_lock, flags);
>
>         return 1;
>  }
> --
> 2.53.0.345.g96ddfc5eaa-goog
>
