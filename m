Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911778;
	b=W5HgSc7bdm+9y/hLYkaa1Fqx03r8FAPGkZ75PTLC7ggPWZYm2jM5jtTfpluEvEytQI84
	 uX/ZiFsUexqs2EMy2bVAzbpJo42G2E4J1GF36n5gjqzVsDA42ZgTlsK+jSRhZEgx8Hmj2
	 2cgFECiefrZopFXj3MGabA6OIsodZ5gOlApSajktWmjZzrry2SbWsjgFjSs3V7GK6cW7p
	 teexooJhOqX3o8zepxK6mgsOZPZ4FJEMMvMfLOSCuGU/0mfmKMAZCMsoTSKM4f/7HGCsn
	 NgYAmT5y2AIwjf9348HLJjcvs0uZfc+D/xaJ92VwPceiGnGUXJc+3iCycSqA3xKrekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tAx7/usNPVJ7CoJVtZ280YQTJvtxvHPmbZ0zROmpUTY=;
	b=og4CvpMRnhczqfNegzPHGKGCr/RNUpcZUWog4Ip2fpa+QarzViGNqQDzmf7DnfqTWQBo
	 x2kcpWnGodAvGEhwFSSjZ4GRfsBkW8sgRiVCZ5IvF7USxkwh3xrSSSiSWHwr1iQvc7/IF
	 DbhOWIDi6LfFBkZ6GGmjqEfdKocxMCdiQbde8K27THBq3CtCLMDPzHiHIBEXtRxSQ1Fze
	 BMNCF3fVXoMu2/W72HIrnuypSceCSzzSNyIpEX68fsk54OYsj8QuW2fBROF8MpyM6shio
	 49RUKdCuv+lRC+SGR7Z+t8WVc+J4rooCQnB0Fx32Rd6qjyOeE5aFnGK7He9Gp13usog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dxBFD7eg;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AC606A330
	for <linux-arch@vger.kernel.org>; Thu,  5 Nov 2026 20:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 093AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dxBFD7eg
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so288608b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 05 Nov 2026 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793911777; x=1794516577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tAx7/usNPVJ7CoJVtZ280YQTJvtxvHPmbZ0zROmpUTY=;
        b=dxBFD7egkald1diEtbXOBXzH+9cQFK2KeCaFgwFJNeVqQ39GNskIoMvqgylgnntMH9
         o6cgkIhz7VeqRWc76fFeuaZBrUrsO0KbXGQDOo8UnmsNxd5DuGBZMTkVsx2LFZXyCFih
         xLmHM8Mx07KTStSbatLB7JBcE69i+TN4sfwyGum4R7QrkX6GMQsP7QDdZp7bkXe4WTSN
         kjH+OioEJh4aowCsawhV76CFmgsNb84NAEAQfXPTtwRjk+/N+4OfpAi+RPh6ypf7I9Ji
         LwRr227XUyaN5rK5df3trhjeaIYVx8XGIDVL5DDAgaeqxIBb9EXYuq3EuqROZW7d5HLq
         L0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911777; x=1794516577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAx7/usNPVJ7CoJVtZ280YQTJvtxvHPmbZ0zROmpUTY=;
        b=Tr5QLxoq2jt5M2UosbT7cjhBd5YLlR6GvZSvjkKBOUA86o8Pf/BTA0uL5CTbMcfH9z
         5Ye5ELKJ2KIV2VCOgKXOmRA9RZoxOtfbknrtIlv8EyjubkthzdkJkAQNWSOfdEBliV7D
         rWol/F3kKUVewRC0FXXqK9PfXluIh31zA7A3i/U7ydo5084URpSq/dTh+5vYUY9VRY7L
         uBXfp1RAU0biI+EYPe9/MCA1dJPLDyGJhGWKrHyKAfM+SsyYnbWIAJQn6axeltSqIYc4
         1yGpPk3YheGJQVbrv878wO0VFkqplTjT1l3GDQcgQkRTYHBsvdAO4SuSIPFgHxrE+WJo
         GWTw==
X-Forwarded-Encrypted: i=1; AKwUvBxKr2/D19QY7cCzfd3J75WETVNfmBfDFqRYZtIbLA7gHqD69C5HJWeVCRMZVuIQUaIpYtGgLJi7TTXC@vger.kernel.org
X-Gm-Message-State: APuU4Z8A+pA9cOuUvhnLQFkEqGDyiHGvN3mEe09NGKIaLUnEROq/K7wK
	aod90mRjrxhQcxnNsm+mSZu1PwFnOsXXz/s91sn9PbVFe+WGl8cajx0+NbeRzOwids0Bi5AkPWu
	GDrP/Tg==
X-Received: from pfbkr9.prod.google.com ([2002:a05:6a00:4b49:b0:8a0:70d8:a2ef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f95:b0:89e:89f5:18eb
 with SMTP id d2e1a72fcca58-8b37aaa87f1mr220362b3a.15.1793911776710; Thu, 05
 Nov 2026 12:49:36 -0800 (PST)
Date: Thu, 5 Nov 2026 20:49:36 +0000
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-1-0b4d75dbf35f@amutable.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com> <20261102-halaney-scm-creds-thread-v1-1-0b4d75dbf35f@amutable.com>
Message-ID: <auzr1F0HNh1mazaS@google.com>
Subject: Re: [PATCH net-next 1/3] selftests/net: pass socket options to the
 scm_pidfd test flows
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Halaney <andrew@amutable.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 17:12:34 -0600, Andrew Halaney wrote:
> pidfd_flow() and leader_flow() take booleans that pick between
> SO_PASSPIDFD and SO_PASSPIDFD_THREAD. Make them take a zero-terminated
> list of socket options for the receiver to enable instead, so tests for
> further SO_PASS* options can reuse the same flows rather than copying
> them just to muck with options.
> 
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
