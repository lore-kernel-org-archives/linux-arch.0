Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2A3054EE
	for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266404; cv=pass; b=dKc0VWZu0cuwD2ynfOIcpcCifM2G86mH+rJ/Jnw8bUll78HE09pyP+kaJvYevTh/5MDu3inLoQgP58SNy1vvq+YBp0bv+asLo1rTrM+0ASIh0bwsGBWw3hMIdOjtRxYl5TENy5MPDNw5Gmpc4oav4oeLJIgBhGZ8OIR+8rJRRpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266404; c=relaxed/simple;
	bh=KV9nkGqyTHCzH16M0zr6yOquFuNMaQs5gUPlT8AXuWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N75TuQWubJv7CCZYQvviiEoMtzAHekG6NhjdUdxTtBbQ7pnu0BOExOOL+x9dFAK34O2tVgo580Isw2X302tf6xfE93T8f5gZRRPqypbK+EpgRnBt24OSIfxWwTLZzoCDsrT4gAgTl9AwqfeWSt5QhYFHlTHYnn9kWjeiVocvQa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVxYzdOb; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVxYzdOb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5091ed02c54so77761cf.1
        for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2026 15:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773266402; cv=none;
        d=google.com; s=arc-20240605;
        b=kGLxnFLU7EnJbSYtsGI42CSCouGVW+nZu72I10ncGaFNESUQJTWsyB2qm+Tp+B1yvI
         S/0ZFoBPBYIpD5Dhe0C2hhZNjvzluuwCBk5VSv/SGqfzvCslxCNqvSplEeZHokvVpPdm
         EKGCTek1WAtKIgmg40uaLfv/pgtfQizn+YHXIIIRU05abBRYZbip2pNfAAXmJRKrhLL9
         Ezu83njlEPAVZcgxNYb9ti3SVCW6imewio78rSFA4rGQu7CTPqVL7Ap4oDkt2S65OYNI
         DRAS2NzeTPFmJBTpuPoyeDxlqvFqvQxB4O+IaPPYvuGqYCoW3zXUBEE07nzzEgKPK2va
         phBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/KedjfWy5Kjar9/btvlIUwnd/7kYotXnwSFyBrJ2Fo=;
        fh=GTzyJH9C7zcHsv3CxaUd7U4D1NIGXi1V1CMw/1cjbpo=;
        b=avioBQkXIJHTnqSzLDgGXa1x8T6smXnK+r1QXIIySsCRy9UElNVH4Uqm3B4LuisVlg
         EG5jN6W4kKyNtnc3nnAbnBschtUww/HSRCdyZm78PSKsgqRgAn4n4vAyHCsII2/pXGoW
         C4SrJjMtoFzY526ekvDfC30LSoBrqQjuyUhyl8+v8tdYIV+H8qJ7xPwP4KjEjD3WEStu
         za14+12WDAmjKvMq4ubcVPsbiDSAk7azpgPt3+rWwM5zZegSC6aoQsfZreyZ//MidH/T
         YttO3WthCjsr7brKaaF1JInsQXSZMv2pXjjJTWfqj3VvDVIR6pHHXXGs41wBHsbbq33p
         yVlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773266402; x=1773871202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/KedjfWy5Kjar9/btvlIUwnd/7kYotXnwSFyBrJ2Fo=;
        b=UVxYzdObuE8nUbkD2avV/19rDiCLMT9Mj4sE5XPTqpIqrrtdLAGUFRP+hCrncWF7wu
         3haYqtcTYCnvIc2klnV6LQYFVj3Pj4C8KZORgMuDec1ZL+1AdmPqUIy8A/HQVIvTIaRl
         //gHB9h7M279nPkcphp8AI1ev7iGvz4y0l/fnyVXMqsr7JZNF2XaFBO9pwXnNNXIPVb1
         hgJ5MPm/oeHVR6mXoTWY9dbHO5JfeeyAer187wKsgHVuPrGacE1+fAy0Zr4Xmgtpi3gr
         cMyLNp5+VJYhW9F5F2rmeEgmALyo0VmFGQWNH8PV/Irir2kp/RFTxY/evIFiuqFI7LFt
         MLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266402; x=1773871202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/KedjfWy5Kjar9/btvlIUwnd/7kYotXnwSFyBrJ2Fo=;
        b=fZgbXHF9elexUNlLW1Ht8lu5Nb8TKnuwq6AIEFiuj4Ekh3urs1jvHclUv5rUqYvHvD
         l0V6eu+xy8X+RSV5mpTdUT9ZZHNyTUwbseqKbsLzWf6aOdDUDdGsug3WeHN7lsRFioDy
         9/Hnp+/+4XxFwPufFmx6lGDGJChez5yyAYWZN2CEXmeoWG7TlNDnCXzK5lAoSqI+pFT/
         2dO3tp0w9x8K+sErfwnK8aTDFqwGowgyux10fMB0ypKHC/ZeLPV0yXDQeHNaZ2tKN4iY
         k5471ZNuhtyURrcAdlkiiw7SPOlcWvD/LtBV+TaH7S+8ucJFkkgTJmHblhE0WyId03zq
         C/9g==
X-Forwarded-Encrypted: i=1; AJvYcCV1EfAyMMmCK8qP4DT54b9YO4+2+3lZR6As48P8U0SeERh0sqGio11GSAOa5z570UaaQU0CAaeXpfVS@vger.kernel.org
X-Gm-Message-State: AOJu0YzieoJEoobuwDGgxsReT2UCfXObwUvdhiiaDPyfCWuupwWqnDbm
	bQdq07uMTMi9Utp4W2aXVkPW+AL+CI951iULappqPnfUpUh0WebLxNZ6B0Fs6Pzzs3LduKZcKHK
	Qkf7VovJqzE8M3rMugwLO8MM13mU8zBlB3ffHbrEd
X-Gm-Gg: ATEYQzxIpnvproHG5XGzGGkTVcAfhd4SQeE1lDR6dY4C0PR9dAV38KMwCstgPjgebig
	N8RZ7gDyUsCX/oddE8R8Plmm2NiOu9wZNxuTZx012N3omTWhb2KWeViyQRsvzvw5SNTeuhyLgs/
	ELoJsI/ITFs5q3rrfhLSX2akQQJgxLK2t8zNcUUMp4J6FhAQU6oQLx8FhEHvTApA9fgyw7DyLjy
	mXYoifDlB1cCSCQtLR0hT9QagH2TislOh8bZfUK9CgeB6I5kpxevYE9D9azRwPeivDvLRGAxaNG
	2smmJrLb
X-Received: by 2002:a05:622a:350:b0:509:72a:ae59 with SMTP id
 d75a77b69052e-509480417c1mr4291741cf.10.1773266401066; Wed, 11 Mar 2026
 15:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220151216.873182-1-lrizzo@google.com>
In-Reply-To: <20260220151216.873182-1-lrizzo@google.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 11 Mar 2026 22:59:23 +0100
X-Gm-Features: AaiRm52ipaDg0AOnuFS0crd2gONcPDRiv4mJlmuJXZ2F7Hsq42gx5EP5HcomsF8
Message-ID: <CAMOZA0Kz8k5cf-rPQXGEN_U8AwCqN+gyt3d+1bfU0S1-rXq90A@mail.gmail.com>
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

Is there any concern with this proposed patch?

cheers
luigi
