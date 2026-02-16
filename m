Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31762E03F1
	for <linux-arch@vger.kernel.org>; Mon, 16 Feb 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771274881; cv=pass; b=lY3ZiyTk8FKl9DD/hyl2pJ+mbiyt/11AD5wV0nIjP9U1u+VL9xZ7QoJkLWzC/x1OIv9npcNjLXlUUtDmW7oyIlpMI2bBCX4fhNJ6aUK2+qHom/CkORhYcUE94NCs6F0XBUdXoNgmR6/QPpQbVdunYwZdq0r6Ol2jIbie5ALW6Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771274881; c=relaxed/simple;
	bh=DngOmKB3WZ6DE0uokMa/juBluHWHC14kvz2Zjv6iO7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+HI5XWhx9MfYab4CAfhGBnRc8a8bmu3GLpBQTMY4uTgGA1syvbbq/eDSPyKZ9hri3xR/Cspi9AukpyX2+btSW9aZWmg7/h56V2yW26NeVPbcoSNtykRRCjQtRfwxaW3a3Ic1slaFKxRlJhZtA8WiZtw4SHZ+9nsJKfvI2yEvTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aze5a/F/; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aze5a/F/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a355aedfso894831cf.0
        for <linux-arch@vger.kernel.org>; Mon, 16 Feb 2026 12:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771274880; cv=none;
        d=google.com; s=arc-20240605;
        b=YxBeBaM/7KI57niuLCPTWLRSmHyitB2RUT32aMYQEaQOwAcIxFf9sdsfb0K0vSwinC
         dkSoqBGGqeM+TBW+DGRnETJhvoCTy/n7fVxtx0aDTX2EmirxIWYMs6BFhHyCct4NhAkY
         DuS17LRrsTkKKyciyu/clX6feRy/ZsG3Ix4fHup3fIz0sSbMwzrc0wjINvvz+2hxrAyf
         KoOHmASOvJKlsbN7dMYX+AqL5lZwdPyjdVLRR9LkZsoWNHlwxRevMt1/XZ0nFvitYf9w
         rRSlE2SnmvQIgCM4+XyQZwIhCUQfOBlIpGR9FyqEP62cb4KHX3AIlwbbgcK6TXfIUomf
         3K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D8x8Jk6tyFJVOvl+c1hyzU/mXIgjVvBKv8NRLmfCfLQ=;
        fh=dYEjBivI/2GblDFpMMguFwv7UFGIS/hQphqpxCN5qEc=;
        b=IFTAcEHbTJYkXMnZBtnQLNBE7Xk2SeW1LQyLb/imiO/5mHKJkdp5PBPaQkTMC1ifgp
         Txphv20CY/1z/NWChF6zHccn7zGV2DQgRilhna5tWdWzWr5tvYFlYclExrpQOGwb/za4
         +aLwV506kZNNptPK3veYzzrfQjGotD4eCmbfMdMrUBOOksemXeDO8TPMoyxxzhkoLihD
         SVOSue4KmW9MH8scYZiplaPkNxkR6DUoqVGAAm0hBKmyHOYVLS4qc0cu35hHmCniPc7P
         Z0Tr+YjrrJpQnUH5jJh0SyxREtONEznJ2aePCI9tKFN5uJed24tiA+m1+l7ddyZrIFrx
         li+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771274880; x=1771879680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D8x8Jk6tyFJVOvl+c1hyzU/mXIgjVvBKv8NRLmfCfLQ=;
        b=aze5a/F/XJstv8RBbQ43k9sYDVgOEC4UR9tQf1xxn88sLmCB5sxAXVEgE2quD3rxRQ
         4xs+d9ktIMMxmOeP1sXmJKDvbfXsGmznXblxTl3c8BnfrDB/g3OkkGsLtDs5pX9clzPf
         u+25Sy2mmZqAaXKQyaHMGQ9/q1kyPPyKAEYN0WrbUtm0om8JU7gpDjr2JK5tW+ezhiBY
         yoqcuW7+zCJ+bYPxErc/fOtQSX6xe7bVLGUwp+ViffShKChGrT8hcg8hUZm/XMuCLbhu
         CUWgKEBykFTaWeNRTHBeHqo0CYXoNFB3yReTB/rR9lWPJ1WOX7cqSen3nam8pcWZ9IlN
         UH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771274880; x=1771879680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8x8Jk6tyFJVOvl+c1hyzU/mXIgjVvBKv8NRLmfCfLQ=;
        b=LH5M7pGzW3pU3QiJ4sih1RM9PIXkMEFdNyQxrg0p754VMvfzqkS3OlMNZOs7VQ6N0f
         6xs5G8AhAg8Ame4NbKGX1ORC95dQZSDhjSjwsg82cMPdowC0JHDn7U3du+QXLEaTTPNU
         iNpcIImz3Iprz3fC5HztMcko9S3YR2TfujRFJu11JavvBS1madeKL7n8KTPI7hJsJC7E
         3BZ4kTnOG+pLEflO+J9YN7aHzokkavVt1V6xcu3NScKyLKcHf4809oiTbI3zxMWskgzE
         X3Q7YF0gc9KBJ/ae6ojqMFt1pckN3fvi2U41qCIwrj8mQuk1XLe1/lAF8JgIyXZy7LVN
         FvzA==
X-Forwarded-Encrypted: i=1; AJvYcCWO5IuVyLGo5wF/Th2GmrVon1WKsCmwAg2PmaPtRHjaUTXJgxXFCTcJwjtwTobJkUWoxUoaJE0rN9HO@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0DGkh7WxM6fni0jfIl2WkAvOpxTmufCAWPCO/1m05Tt97YuZ
	pztRD9iznOMzZxq0TaMAApqtiDbRMR0pvZ5nXzyyRN7j+tSVfa73EcJZaOWEk8hUZB7hk1Zhb64
	ophBikOHWnzWGFRlaQyd5eSil6aVSqrb+dnWAvNel
X-Gm-Gg: AZuq6aLj8BrywPs0mkIHz0W7giZSJMGdmO9VmNjDEecO7iKaGujoe1Th7yid4/5IQZP
	zOkRObbMPlhzN2yo6Ztr59T+LmaOhefkZ4BapgbjGnyVz9tpe0BykRX4luIjwIivzAdpBEpj00L
	ztBWjIceQws5t/OAoQo3j8tftj7nnAVX0BqKuSbTBufC1/tO3H7vcO4UsVA/WZdZXEfXJwenfjS
	b5TyRkfsvDwlP5lo5QF6Jsq/NIriyWmd48jp5jsRhbf4MNBCCVNhHoM4dqHQ1iXb0A1a6euqCLe
	haXWbPwk
X-Received: by 2002:a05:622a:5f06:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-506cdb53e2fmr9658261cf.12.1771274878166; Mon, 16 Feb 2026
 12:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
In-Reply-To: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 16 Feb 2026 21:47:21 +0100
X-Gm-Features: AaiRm50LsehiB1kUGNKbCbLj7SnL5mb0VaFMH84rQA3cLrFREx5jqZZvAtFqS9o
Message-ID: <CAMOZA0+2Bb6A5hiXDxNAsMryj-5Y2caGYPAempNvabi3oC4Xvw@mail.gmail.com>
Subject: Re: [QUESTION] is vector_lock needed in apic_retrigger_irq() ?
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

apic_retrigger_irq() grabs vector_lock, see code below.

I am not sure if this is needed, because the function
is called with a lock held on irqdesc, so I think the CPU and
vector should be stable.

Comments ?

static int apic_retrigger_irq(struct irq_data *irqd)
{
        struct apic_chip_data *apicd = apic_chip_data(irqd);
        unsigned long flags;

        raw_spin_lock_irqsave(&vector_lock, flags);
        __apic_send_IPI(apicd->cpu, apicd->vector);
        raw_spin_unlock_irqrestore(&vector_lock, flags);

        return 1;
}
