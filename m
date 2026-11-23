Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393279;
	b=Hx7j4km8jhRsupH+gjt/Z+Pvezaav0KzYPcY9lVJ/W4QR3DELCukBo5QOBk+BI2Ty74e
	 fow9Vp/PbddPPfX1tzxMbp02h99rhJEk2Fm2qxnKU9wRdzJSW9hiicC3EwzbnpexCzayN
	 WPF7/+cPG6oq0ujQRkQdZcTKRDNOPlUjAIgTgqsRD27/F9L0MCv5N/FnDgE5UdTCzx1BJ
	 i0i2zxcUwGMyRDBEjm6HxrA563IIsiSGa4RB8uRQuSIAE4wsRgi6QRKSm6Ou/e1rrN3BL
	 ruIUMLjMnRedpGbaP6dWLEQaEBYzrXawxfdZYF7HLZDCQolZeWKOJ83hlYLdkStUHhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
	b=yn6mDwg+O3CM1FmSIf9Jq5y2pIUCod6b3kVnTy96dBnN70nDlO4uO7dKSvQ8w1RGOP3N
	 fVMpQUdNPuVZCa8YtDgAW64I1TiD6ZNQ/cQ7gSCVAPfJ/4eS+HnxEw0/CQAsVmMolyCId
	 yDnJ6w0UYYjJrelk50xUOGFEqWMuXpPo9IViFUfdYDMcrKCQkNOHEASIeKJgt4XRBhW+g
	 2l/qGOloYPVExIJA5STTAzD9DcZjJYZl5gIbzlNgUsnIzd1h+76RYr2ED8s9gSrSvEOho
	 Xo/mL7lCptOC6Eae7aSidI6LTHSbk8MaZjK+zbTCDeyWsSjs+E5CKPlL6qDn3InsZlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28457606A32C
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 00:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28457606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ccca948203aso2664777a12.3
        for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2026 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393278; x=1795998078; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=Ui7qLXEe5JZSNGGNnJt8YRoCIU9BozHUuGdwiGGRpRdbVOmZeySJsVDdurWv9z6VuZ
         VmOigNcxpt4gus56H5t3tfeT+jMthzm64QEJc2zAee84tuc3roRSTwD3Kv0m4dUfr0F+
         4ugqeQMPjbgSS4cdMlpNKVGn/lbd6gTEqFW9TDBlFLcgP5yn4h8g99RzjC8XXY/+LFBY
         IwZpe4ZfiOfxC/PDMkHtsl7/7xATK8AceJkZH0IS98SuaBuBBITDhuqsEsnfsOQEZ/PP
         u3myvmJEKPylm9aDUWQ7+IckA8eVXYDNm+iIKJa0jJHfttZyD/rjsrlkR7z95OGmKQPn
         RqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393278; x=1795998078;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=nzb7g+cxYtaT5FWkKoxhPnZM66PaAEAPtcG2AJryAPHVLTztMMt8CMTBduSuL8JVhD
         shY7QgLtHIaoglTn3Sfj1c+IwQbwwHjpLSvRh0aEiRgWOhUKedYMN8Ch+woj766tfdFk
         Qch0zHgl9mftNsyUuBnhCDI2gNtR/cjIW8IGLc5hadQUMFmEmsc6+4XMYeClJ1xS08U8
         sH4IrX+jZgNDTxIfLYmssi64HQGwNKnA/acGt003Xm9+PUNQW/S+/EzFVDrAu9JcgHKo
         0/vQaTsdEqIHy8yB5d1dJq+CEX33Yle7W71qACdFxEcNrpO3Y+vOwAYw/Pryd49BeYSD
         AJlQ==
X-Forwarded-Encrypted: i=1; AL+hErEKj5g8oT/IryavWrH84wRFzyPrNGcCUvdR3EOi2YTlp19vrI9ks+V12nTT1d3imtVbDPOvJb88zhsD@vger.kernel.org
X-Gm-Message-State: APuU4Z/6/1cR+3KYOu+AhpwL5N6zxQkL7mexT9/D7g7gDCz3cGtb/FNt
	+NlX1aAi+gbqQFsKezEL0rNg2YigeS30XgFhdd+YSgcr1hTgWofeRnSC
X-Gm-Gg: AZFdTZf7XFY1hhf8U5sGXkY/KDNTWQYq12uDESMnAMVy04DaS+0Y8nsm6kS4G0gBXdC
	x091dHxSGn6R59U4XnqHrTu03Jd4835IFKYrvb31Rx3qZzEgM9etLE4A1BQ8fa5xbenAjzoNM2A
	YKT6MqnU+xrV2eiLPsgjjLEoO2B/3mbdVgooi+tIl3aFjHWnscDQnY8IQsFLM3OyiwNiF401yqc
	fS0LsgN9T+cInQ7v1Q7doHnSsnVDw72IbaAD1ejajvtftPvYuabws/v//lDHS/5TYzPcTJtrXnD
	oTxHcAELTzScVEvAl4v2nLHvGF25oNIEmnk853pJGUoLOsbIZ97lUTPindLhPYgVEIwn6NS6njy
	DW0vMp+N4/7mSTZWFcgVfN27ToyX1orPIIsMsqAEdxkGbja6zeKpwmveP9cDAmMOxjApwfQZ2FJ
	ZnstgOSs/mbZydgoavRDgjFkUr3lPAt7Fni6X4iIJAPup+B5SD/4t2VAD/U7NBVx7h3HyCdtsLb
	9JZCP8tgAKGdqAlJyOCxVtU9aigo/wAfjsh8mHf5ueLvWFRDrTKjCJAGekWVrc6sHI+lN8r0oYh
	e8AzCycYntkUmy96zrSVyudHUCPiq8+RoTTsaMjr5Z6rSYHc7CHfDGoOnd2GBhzvJo9gAbZMzJ4
	VS7s0iLUJuVOJShcZPqDFdcHeUgwlMGd/984=
X-Received: by 2002:a17:90b:1801:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b41c8e16efmr9088622a91.11.1795393278264;
        Sun, 22 Nov 2026 16:21:18 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm4860403a91.3.2026.11.22.16.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:21:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:21:16 +0000
Message-Id: <DN25ST0D5K1J.1NI5236BF2BPY@gmail.com>
Cc: <bpf@vger.kernel.org>, <containers@lists.linux.dev>,
 <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, "Aleksa Sarai"
 <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski"
 <luto@amacapital.net>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner"
 <brauner@kernel.org>, "David Howells" <dhowells@redhat.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton"
 <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef Bacik"
 <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Zygmunt Krynicki"
 <zygmunt.krynicki@canonical.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 11:35 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> v6: https://lore.kernel.org/linux-fsdevel/20261122011809.2667684-1-jarkko@kernel.org/

v7 was sent 18 hours after v6. v6 got replies from the bots only.
v1 was +2559 lines. v7 is +5782.
All six findings of sashiko on v6 are still in v7.
None of the seven versions got a reply from the vfs or LSM maintainers.

The way you're spamming people you're only reducing chances of anything going in.

