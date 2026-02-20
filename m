Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEB24A069
	for <linux-arch@vger.kernel.org>; Fri, 20 Feb 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600343; cv=none; b=j40Jffy6Xkn38t6WCm7abrgY0eSE+SDUk0ydUJCr7B7cBMvv+xGHpTOg/HbA7S4zVepxuTydBvlWn7rUWLtJNHKSQ9eJ1+N3JYhr7Wat5ga5kjeCYINNCSbNCVt8IwSW4J1Klrs0lJbHSnzY1KEh90m5zfrCXhxtxxtxVerLx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600343; c=relaxed/simple;
	bh=DzlOWW6aB7lpJ/SzjzXXIUpoY1JoPREbSjUZUop8aYU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rpcXXa7G2Beo1HeCkcdPP7TgO+0LvuM70Xi+zqwT6OGiz43yK+tdk2q8aFFG7nMuEjAsjgRZ5JeM8SzzApOEJbT1MSK313RHuDsTq8+xoTDvTAkmraiGrB0DhE3nLGrhlV0HniCpyap8s+mdliAjTjoImOS2PrXT8srJhYEq9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gViqR9hf; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gViqR9hf"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b885979bfa9so200403166b.1
        for <linux-arch@vger.kernel.org>; Fri, 20 Feb 2026 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771600340; x=1772205140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BglHJbHO05XrjVy7Kw1qhRY3apE6BRfv6ldh6GG9pCo=;
        b=gViqR9hfGaz/0iH8l5leUkk+vkKI2njGZMY+dh0xdduAze8wT+elzkZWl44uK11ZT7
         YyrUxaexiG/mOmsHJDfhRSniUNE8kKMSypnd6UJkmbkeZ7i16waH8VP1Wxo2gyYK1esc
         B+XxqENtTQ/ByqspzNg1Bvvw2CXEM00Rdjkexa6nKhsKhAP9PfX8kwZljELJUnPZAqZY
         SyfoPXMLrVUXppzpuTUq25Lhqk/qagFNM8FBFq3sI/g4C1EWd476wcydm5DA7FaRB5t8
         +TqW10Ra6J5Ma6Ia/bnuQqLDyEYnyaQrkfXKC7WvXUBW/s4YYq+gp6h3l7VjQY7sShbE
         ZM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771600340; x=1772205140;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BglHJbHO05XrjVy7Kw1qhRY3apE6BRfv6ldh6GG9pCo=;
        b=Yqx14O/HtzQ/aKx6Vo33Zm6IHMK5uIbfYQWmU1E5PYR8qeGJyij0LKauU/ObqDBdXQ
         s9KhEawTmpYlkE2bp7KbyntcEAq0bNIXJ2D9dNbD6NHfZ2Ioy59ZXTifeJsazOl+hLeS
         9JCVxa2UVvOO+m0LPhBZVlZPXz5ZoNouLJiJfwwMGIHDZ+HEX0NnRn9UhgVVC6jWaaBO
         KRHn8WeEGnx0b9BRIV1ys9i1AUXZ/c2+rPNNRMB/VKoe/pjR4ZBp6K6Pvxk/6CO8Ofqy
         0v8RxZsJmKb6uIwP5NDrQ1AIh1KY9IxMQ6boyLGORJt4WqcLERRzlAoFvDBXdQ/YgovY
         3r+g==
X-Forwarded-Encrypted: i=1; AJvYcCUb0cLVwIShe5+cNZJNri5sUa863sOposYR9Z4OS3mq46UooV08+yDKmt4EYCpY2Jhul695pURdeKuD@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfcZi6V9ddUICaPgLUnFiAPHKsG7xZNz29rnUugvSK9Nir/Se
	5HTyyzD44WxgSZoE+qZRD2vKDXXsSvGGGHZmkVlsc6NJoiK7xqvZNGP3wOt/FccrEQ2S7j3HeLu
	J1vbiag==
X-Received: from ejcqy30.prod.google.com ([2002:a17:907:689e:b0:b8d:e68c:f9b4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7311:b0:b89:9631:2425
 with SMTP id a640c23a62f3a-b903db149cfmr547363066b.19.1771600339889; Fri, 20
 Feb 2026 07:12:19 -0800 (PST)
Date: Fri, 20 Feb 2026 15:12:16 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220151216.873182-1-lrizzo@google.com>
Subject: [PATCH] x86/apic: remove vector_lock from apic_retrigger_irq()
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

apic_retrigger_irq() grabs vector_lock, but this is not needed because
any caller of this function holds the irqdesc lock, and that suffices to
protect apicd->vector.

Remove the unnecessary lock.

Thomas found this is a leftover from v2.6 when it was truly needed.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 arch/x86/kernel/apic/vector.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bddc544653999..fd0f133b379fd 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1002,11 +1002,8 @@ static void apic_force_complete_move(struct irq_data *irqd)
 static int apic_retrigger_irq(struct irq_data *irqd)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&vector_lock, flags);
 	__apic_send_IPI(apicd->cpu, apicd->vector);
-	raw_spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
 }
-- 
2.53.0.345.g96ddfc5eaa-goog

