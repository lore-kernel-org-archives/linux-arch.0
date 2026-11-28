Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795830680;
	b=hwBo+rQftES8/jr39hqJj+OxF6RIAwqKDIJo1fFu2w+PKtzT8NMBrywTrUwX0LCQypvJ
	 httEPr97jv9UpXxsTyh6Bc4ufE6L4O9jxYeWU1xSUAdyqAEAr5yYfmANKTKaukmV6a0xT
	 2vpQqeC9qkYt1UeMIhd7ON2g8ZqmQE3nIPQJm3ygEUqRuBVFdXV7b78kQyylDMxd9oC3F
	 W9do4b/XI7cghCHfjoBQH6MB63IAM3vlNGmTbPpt0yfAXiFiGBfbE4+kLQqYrG70uZVrD
	 0WlwHnTqV6NxxoHriBjHTPpaO9jc0x5jcb4oooNmL0z/J4n63y3QMcwrephI7Jd09NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
	b=iLqcATG/yWE420wgWCep2a8snhYQj8BQoIiHX7jsK66rPH+yuhMfAqZwI3GI2cIMgkAM
	 g3Exk6xxM/2Ao1eeghObO+8FpoZFmIcbn5FXQl+4mrIAA9MOPCyK4V/U7/J+ojtTVLMPi
	 ox1vJrjEYqPghz6QuEJcDhQDKMkcZZAn6mD4H2fVJPHFyvnhu/v+HsJTw1/fFIBtrPp7I
	 YrGVr0bVImgK2cjEx44H3Lbn2/HFPgx4d5iDdF/us2Zzl7zqzuQ9vOakhaOgE8E1/ox/z
	 2WJBwG2X2PVdY3GiVuwq0/lXrAOMLOUkAh2dwyed+8kPEU0B00j6Xs55lTo8c6b7IjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFA606A323
	for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2026 01:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEFA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1322752566b.3
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 17:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795830679; cv=none;
        d=google.com; s=arc-20260327;
        b=sG/UwdtjguJaCbX/j4XBAIp3aKiUIgr/v4+cfzU8Z5KJN9Ape3sJrOJkPVOUXlhev3
         ok6+jxFfz0pnieGW1Chz8wPFIdenDO+VRfm0opoCLCgZ6BMQsr1RRIyyOEqb/n4DegAJ
         AU1GejeY3ULT03V/4AVJoChdB0yBrAn5qM4qzquzE3t9VhjsHnUDqLLrLmS+1DXl96oT
         0fU20p1Y+866OEyLLuHD9NZAB6gjyYAJmzbPakDuymIktY1ZJ7XDiyyFal7WwBU/pqkr
         3sQWx5LtxYF50cf+VgHO4LsDgeHJGov7PDQTWjDCAqRj8B4hBuoIplqzmauCn0HW08m1
         9jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        fh=j0HYYtyzR3poGDULOjpYrGAO/0nH3YOfrPK0WMLAsdc=;
        b=ZrS0ZaAi9xYWu1BJ1nSQvaaRnd0LQjAqIJL8YzLPQ9vXLznH13EkW1T5Z4uVkL/fgL
         P7yGM1TcMwTGcicuLe613HcyqKZ70o0PhPci3fHk5/qV6zj1A1N+Jsd7GHtKvvIt/LpF
         hq7qeYP1T9ly87dfsqwHqM+hf3hiLuCjHs/xbGsYgrvnFTS6Fbo8DxPSlUU1yeM9Xtdz
         oxgakNt3w/rD+GChUAqTJp0zjLOU0gfaQ2bCibgbv5+w7Wdf7vsimGMkB27l1imSKTBk
         iXTP7oRSBumxRz2Ymb3b6qb831Yfgd7/5cT2L+mKI5pbkQmGRdobc2/O+DmAE7R3Ttkp
         b+VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830679; x=1796435479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=XLosXPN4XY1X7SNdxkqBL+OmW6RyoS3KUKiJGN6VkhP3L0yhHIWAe9gfCGB7c23JLd
         lHNLLgTgGaPV+ANwny7auVJWhylTPy7tn8Qbd1QmlxO7gDNExEWgSGEhy30NAozJQ+8+
         +xKv07hbVc2PMmC0nQwONM+Snu/fB4CVx2Zu1RVG2ABrNV3bydSS40OT+TsJEZK+JELi
         MFuPTs18dGi6k3X7RKL9C6rS6PY4lyASR9cQGoX1ApSJvF/sCt8fWc54v5qN8Mgd+424
         mRGAbRe9QyqlYYy8UZHrD36MAiba/qdVjAz2hG+uSVag6rBQPtZrBpUV+D6X33j1iq7k
         51pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830679; x=1796435479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=tcizYpuFAQdl+6f1BKk7qQtBltbUicaa3SwV3+1QdOGniyX36AX0M9OJQD3rF2vlOh
         A/DCBe+z5A1Oxhd2U8iA7ehCdDDGQ+EldmrUUcAp0tvnYgDuor3DLCRiG623QzL0D1Rl
         GCHhewjL644Vi4926y79ZXs5BQO4/cziHBqU15lM843WRdg1VkUcZ6GzZ6P/IN1aZ5hB
         P4XsqHbuOdN0aZsTtZNf7Ieq3k2rgmmifiEU4dFuwNZCW8t5M1Q/ed9h2TUoNZbbe2yV
         vB6dXV3mOESwI60vfnHzF08zZRWWV6taZxAJP8ej9tkuiGkK1B+8URM215mHE233lp1I
         Mucw==
X-Forwarded-Encrypted: i=1; AL+hErEvuCIIRNdaB7qqPrb4PFXwwWuFpe9CGbg9Ula3Ut4ovwvlCwcXHIP/GKn3jTefsW8x7MZMiPj6Im/m@vger.kernel.org
X-Gm-Message-State: APuU4Z898Piq83XKN1dO6e1bYO3Y4ggOEX6b1FJopzC9ISczkW64NGy+
	2KCSqob/CLNiFT9jwwFUte9vjchg8QB/Mlzj3c4PgaxfQvhCGIacs8Q7GYCO6lyaHW010FCFiOI
	BavDr5AtTIgOA8yfYZTr0MW7PzOIl/Zw=
X-Gm-Gg: AZFdTZeQBX6peKEW4njD1jdXb9SeMgd7m9+D0zv8MoDjtmCbZwgOftfMy2gkVJ0sFnA
	KcHTb0zGeRBzwfwpiATocnPA00SeA0z0BxpSEajR7rW3GrCMaNsiSZ3JqlVdgz5vNgV9YfmkMxB
	ZlQUyqkC11h1jvJn3AuWlLTxgEjxiQE0He0oUxEH6/xbBAqmUROvLMXCLKkw8b6xcfCQAXzdCUB
	FfoMKvhCsO4t8fTrCwZx3RiFIQ/+DV8Hzea/U20FWXPk8dCDkzW+I10rOyLTrGI9IOLy1+irzK8
	aIj37TyEzPlkR80sYN5Q2Vucu9uNFCbZoniAX6tKe7gkMTPDkv+386d1wLHbV0HiKK5WkYi1QnW
	sEsT3VRZ/hDF/vvLQ99V250Jor5QM93fGh7hC
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr1724212966b.15.1795830678877; Fri, 27 Nov 2026
 17:51:18 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awOQDOel_72Xwjm7@kernel.org> <20261127214103.542291-1-safinaskar@gmail.com>
 <awn-ioAuksHNV-Rc@kernel.org> <awn_Y7oI4ckfsjSv@kernel.org>
 <awoHex4LVst2JwkO@kernel.org> <awoO9R7YF_5_6dHA@kernel.org>
In-Reply-To: <awoO9R7YF_5_6dHA@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 28 Nov 2026 04:50:42 +0300
X-Gm-Features: Aa3M54pCi2p8qLdocdLXd3OCMkn8g_j_UUSVEEax8LAEOxwj1oFmxFAoHI8_4lc
Message-ID: <CAPnZJGBnFyrmr88OsYkMwtLiR93z4g0NAuoMurcnhcYFXz51jg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: aleksa@amutable.com, alex@amutable.com, alexei.starovoitov@gmail.com, 
	arnd@arndb.de, bpf@vger.kernel.org, brauner@kernel.org, 
	containers@lists.linux.dev, corbet@lwn.net, dhowells@redhat.com, 
	ebiggers@kernel.org, giuseppe@scrivano.org, hughd@google.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kees@kernel.org, kpsingh@kernel.org, 
	lennart@poettering.net, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	luto@amacapital.net, neal@gompa.dev, oleg@redhat.com, paul@paul-moore.com, 
	ptikhomirov@virtuozzo.com, sergeh@kernel.org, skhan@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, zygmunt.krynicki@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 2:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> thinking more sequencing than data structures. I.e. I have a game where
> I need to end up to process creation without embryonic state, and add
> just enough weight to kernel to support that outcome, and that leads
> to ~2K'ish LOC of extra kernel complexity.

So you don't have embryonic state? I don't like this.

Let's assume the following situation. Userland's PID 1 is already running.
Our container manager attempts to spawn yet another process into userland.
As well as I understand, it should do clone3 with CLONE_INTO_USERLAND,
and then execve.
This creates time hole when there is process, which already runs inside
userland (i. e. its PID namespace and other namespaces), but runs
container manager's binary and have container manager's mm.
This invites for bugs. Other processes, which already run inside userland,
may somehow take advantage of this.
For example, see section "CVE-2019-5736 Is a Very Very Very Bad
Privilege Escalation to Host Root"
of https://brauner.io/2019/02/12/privileged-containers.html .
So, here I like embryos.

--=20
Askar Safin
