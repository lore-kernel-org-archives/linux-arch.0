Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8438E5CD
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052340; cv=pass; b=E3ZQ5hgp+vxQ+GlO2JXZWwDrMAMdvLeWvuL3jqLjr6GuYuTkY1qhLMDR22YBmt2W9zl42ZaYi0HAUSD/kRN5mB4VtIBVcf+D/iqXgClyUrX11IH/A4UIHS8KJ0x3BVxvhZMXdqgfjk8IPpsmJ/vy8D+QuRlc0jpxTCXm+e343nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052340; c=relaxed/simple;
	bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK9655BHLXZzx9fbTKAzqNPmdmyTDsnTG3F5zyjbozuHUIcMQKn1QdoOtJzeOjyKEA7a5CdEEnhfB4BSMD3TXPLlvwa1EnFtOP6e6L23o2LtqHUTU9YE+BLcsksb0FHgFnEQeI8Qietq+zhHpdlOInIhFWpIGRPevnhv78/TuDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB0wlMIw; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB0wlMIw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfd819ae5eso164642a34.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 19:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769052337; cv=none;
        d=google.com; s=arc-20240605;
        b=bQPpYoe4e3yiePEifNqo0kMDFFpsCyuMKkP5x3V8RzKTWRnBxSXtkrX3Lqbqt2sMF9
         FxtcVUkiBwJMTzglgYE+gqt1XyPREwT+a/opvWCvSHUSjwnKT2bQ9OQ4vnDZ8d5GTdMc
         LK5qgK+d2qo/4cP/aRD0V6a0GlTZWmDVDWqtfxxuSR7wNuqHVkPbbQScYj/v3bBEXUsH
         Is3vRed22FbRTET3cb2ZH3deSsIxy6Vh/q0wZMewCBL0b+lXfEh+l1qxC0t4cUWal6Zp
         imgIe+2jSYv2/KrEutJC82Bc+awRmB+BgB0R0ikNGhx9UqDfOskGZguSAA8tDlyz0pg0
         QB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        fh=0bfnnT4sb+DYGlhftyYhYQCoMPXJTCyQ4ujS3RPVqsw=;
        b=AMMrEzuGreUtExEfnWR89jXQlhDMiNDtq/cTW6m96aEHumEze6csFPXC3NPP4qflJa
         t0YZrJUGj5UCltVe7R23Cych9T4Lf5lQCEvOQqAftKnYWdw/aH4sN1RJPUw0S6d47AeD
         WTqxcfXHliS3o5ugyaMfmre4w+lM6v1xstiXrgzT2zmnp4PUBLEAv5gKkRFrz/6SyQxG
         yTNsC+SuAeLn1TglwpVKgya25N/ZaAPg9LIQQodayXIHxU6BfFt3gG/rv9UcT6lS12gx
         odSH52k2DGlqOMYuKkoZux2elKHC92LDVX3ZTtkfnpgVxEILz9+r43xjEiVF+63akel+
         OlKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769052337; x=1769657137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        b=kB0wlMIwZft5yoNg9jtjL1qV9T3g5+odcXh8BHV6L57EOunzWzT0R7s6jr6GTMJali
         0JTXluj+Iae80GCFb+QThteShLYywGJpUOH2zlOLMhZtEWD3cP2KjKzU6Jl4+C87aMFK
         C+Ce3Nlua1Xpi83kjLQUwa32pwDB61/RdyKAswceMlhLqf6j9t2exJiHZITLUApzcgmM
         nLW6Li6KFEnONjAIMNF4MGGiwOyuiJpZFj8hrhfOfmz4iPtWmjzMDrmSeU3neiUIFi5V
         mlW220zxyihQifueyN8p752m/egF3QLsDG58+PuAIbvNBjAKZAqK0CQSI5OMNJjH4yt9
         Fcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769052337; x=1769657137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        b=neuVi1AlUbC4DMdBCJo42sb7GYJoGXiPjWhDuFJIw5ol+VRCHwCHKdf1SEqeRfC5ZS
         6TenaYVMejk/tYT8L/C2uCesiXbonsxrAPCSDqgQgtg3gYfYRuxsO6FQ8mN124RNSOsG
         vtUPdwDDymA19nETJZ074MhEl3CEh9l3C0sv6uFJE3OpFKN94q5aAAcKhbGyAlSBh5t1
         GYr9bXazy3+lVf6ruKV35Yvo/D15b1aXR1ntmod2rVCT5w65Hy6TrO7PVhBkyLXTX4LF
         ZG65jlRXVGsErpNWs80jVJNiCYWWNep8AzZcjYcbaaOEi0XdrjzacpDlJeU9HLbSzOcS
         NL0g==
X-Forwarded-Encrypted: i=1; AJvYcCX9v2xVSyqPAnGI4tmbuFC/6lQTX2uTGtphH3ks1AdonN0AladImJsyasvuzl7i003VekLIhC7ESINA@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTGpJZInJElkQ87AxnpHCGO7/OzKYIF5l4tTdVVQ1oepiBg/a
	rtKeu9MhCk1MHIfqe+N8FL6TYXUOw/tO07Tb1qhuO3WlcTzkPhjIKeeOzai4n1wu1+5kQxMj8y/
	mSRiy14b9y2FYaTg6vmhZYAsJ+YqaAqs=
X-Gm-Gg: AZuq6aIYHuFQeBWMIzISNkm356o8ZLCVIvWQPy3tcTpaJwyX4SsS72J2GFjTgBDFbp9
	8RGs2aAq6yQMPSI83Zn9w0pcy5/Yhz4ZryrlYQBLp3W5wZUKl1CUhGZ7kFfvVvDf8vsUgTO/v8l
	+CUg6mWCUS+RaxalhMODT/ns+gT5COTdQgvo1Vx4WIZ3mOBGK2BQf8Jg9rQUJQjI40Zo79RbAbK
	IgyYcudg2rk1XCI4n6XiKFxy8ht6d/zAIbufWQpxVNL02ezf4NXstAYJ9VWT92J1l0RhzaS695z
	mnpkAQ==
X-Received: by 2002:a05:6830:3982:b0:7cf:db69:5475 with SMTP id
 46e09a7af769-7d140ab6895mr4490648a34.24.1769052337402; Wed, 21 Jan 2026
 19:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org> <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org> <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
In-Reply-To: <20260121185021.446b00e8@kernel.org>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 19:25:27 -0800
X-Gm-Features: AZwV_QjAIr5HWq1OvyaswWVCAIdwEzJFXqJ7idBVevJ43OdVoqWduskcsKDBYHI
Message-ID: <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 6:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Jan 2026 18:37:56 -0800 Bobby Eshleman wrote:
> > > > Show an example of the three steps: returning the tokens, unbinding=
, and closing the
> > > > sockets (TCP/NL)?
> > >
> > > TBH I read the doc before reading the code, which I guess may actuall=
y
> > > be better since we don't expect users to read the code first either..
> > >
> > > Now after reading the code I'm not sure the doc explains things
> > > properly. AFAIU there's no association of token <> socket within the
> > > same binding. User can close socket A and return the tokens via socke=
t
> > > B. As written the doc made me think that there will be a leak if sock=
et
> > > is closed without releasing tokens, or that there may be a race with
> > > data queued but not read. Neither is true, really?
> >
> > That is correct, neither is true. If the two sockets share a binding th=
e
> > kernel doesn't care which socket received the token or which one
> > returned it. No token <> socket association. There is no
> > queued-but-not-read race either. If any tokens are not returned, as lon=
g
> > as all of the binding references are eventually released and all socket=
s
> > that used the binding are closed, then all references will be accounted
> > for and everything cleaned up.
>
> Naming is hard, but I wonder whether the whole feature wouldn't be
> better referred to as something to do with global token accounting
> / management? AUTORELEASE makes sense but seems like focusing on one
> particular side effect.

Good point. The only real use case for autorelease=3Don is for backwards
compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?
