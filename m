Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792637632;
	b=QcY+THBMJp26d99l9qMriiNKbG8J68ZWD4B1P1tfjjuzrEizUwOLVBJ44+agphsC5wKG
	 9U+16dLj/QEIN+eL3VFNKnXE1+AfohjG1FucxGPhwQuYgl1rw+xDCbilt6MvQJ3kBKWcI
	 RP+5gq58fzuajJjNmjznHMIZXzH1uj9DSdvVYRTjnhjsch9xnRvOSsCc4tZp5MzRs+dVY
	 hrFzJVis1nf64U5z7LhICo9Gq78EybkLB/2nuGrEZBT0RjuyFDXLij3pcZr8a6tQrzw1v
	 ZOleQ4e6pL0zA/P1o3CRnUr63Db0yurzXyHmU6nafi1iI6aGJdNoD0z6jc537A9BenA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=zbfgt/yMFhGFcKOSfDK087QGwZarUOcEfG40wIEhB3C0zq/Y/VjuxqJOWZOUkGnkkOr7
	 3zp5QZBrfCXzO+1Lj3DxntCo6x5F4e+kgCaXlwbeeH+hMozuHKsamgE5O2yL/isvKOm4V
	 RnWSvC5SS1L6KxoGb7WWmuZDvBb4bbvYo9yVAm6YTMOUVu7Nnxpe2ONBsQyCLUAm7KCSl
	 z18yCY6plnrFmkNm28ov22AQjsInJLnFzynJicqKkWfBQVcrcqzY0apQkBukpG+A2hJuU
	 OncGdPNBhkrkecRC8j/bJs25rWVrdyuDOzBh3Vf00bVY9wvSYmtCuCWczRJIcHEgZ4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=fail smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF6606A31E
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BF6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so195494366b.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=UISU1dguXGhfMOOrqT0YDTXK0AYXFv3CPwxwDvjwTVF1F1bfcytyjQ9/l6iOqxQdMX
         6R/Rm45btuK0DGTZ4AlBpU1TY8swyVoQPwk7bCdEST8NBjTuQKzpuFoeDv45vBJuDqU9
         hqOcmaE0dka4ubU4KX5F1i9EwNiI2kzjVKR1C/UAhwQwRIpT1BkXnW/uG87wmBZ+xRpS
         AT6WMcsFiXihLdqZdSi9VWhyuKKL4H/2cmKXFESEco/jkuOwnEfsgCflI3UOrwh3oSI4
         kcOtB1GvLLnJGw7xj5HVqI2zFTzL32sXPBauywvDszAbZGTgm0pIVpV7WnpafRDdB4jd
         Pisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=pH4ssNZNVKMBapyOFk2rfuzuDwLaq8oE8tICpNYFAB4=;
        b=omSqawk70WpluFmD26olW8HmSvtrQy6AqsUy4hvNnAoeMa6wYRgm6NpaDAcc03YSH8
         4/+mCodQF878ACEOS34H8lvGwncI1NV7oBwzKcl7pxc03jWuWNhrupY7T/56cVnqG6RC
         u3RIPzwGnBzztSndZ5t/oS8MFSsJS450sFGAssVTV70MzZN+kXJFgfC+n/Z+vSdrnflC
         u9ht/fPt+hK7c1Lgc6n570vOj1gj7h010FlRVRtoWf+DOsAp0JxjEaMCjA2jsYlBcO0V
         8ZKhI/MvILYo9Q4TMkHYPmtU3CLChLrAB16ylfROsF7Oj6E1xUwkglkjxSruHKTHkHX9
         LB0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=L9hrNcFe9+Z+tOgZ+kYwUcO9I5UFPaJ6F72xa3EE/Hk0bS3pOfwirmD4V1Z11dxDAT
         Y6Hoh1oDDVsAcwZXxyzRY3VuA9fnq95xojPOMx/reHYDmhk0tfX4nTbWMF15FZkEpeA4
         YO2W/xUpfFwzEZMKJnMxuTZhujTIHpHonkHG8GLpuqNWqa3gdG56wkNk18zVMvACX/1n
         CuL5AQTkxKL/8k4+TMQ3K91ClYhCU4GdUWLHgEBz47FOonP4PwaLMVn/taGTJolt1Pi+
         vqN520xxG2RjpR5meMKeUNPSvGcYKAd69e03jHrmjotKyEzjCc8vvIPLWR1GnezGgfMA
         0CqA==
X-Forwarded-Encrypted: i=1; AKwUvBwkyxJW08f68mgdIt6wTKnP7a4eEKr7Tvzfly2z+MEfITm+C6bvZuujoPalyVfEtKfwIP3tfQQkuX5S@vger.kernel.org
X-Gm-Message-State: AFq9FYK+NO7JybgK0KagErw3Ysy5pXALdFm11wEO3NjfyuopXda3onyn
	BlTFanMoVz/kCfeWCsOTInHYjj0lkO2DY6ROJIOQJZHuKGKTuCzmelUdxXjmJGHbb6/ASVRARX2
	3BkMHFOWVllJ3KR7hYzQMh8sUPg4Ciio=
X-Gm-Gg: AYBFou3O9RSzGpHmf3sngIKW8K0ascawvqYLOO5cbbEuAvjGgxr7g+3DtjWEkFWn7yP
	fbMSjxRGzB2C5nVJeWhAp9uJZ0EZiwgn6B1gwJNNaivrEDBsPI9j6ILwMMFVRaI7/i+vDJbyJp3
	nuFAQAjq3IS5wwNqDMvA+TtkKvh4HXEGXu/CtCQDsmK2flaHi4PxKkXvOvkvN+lyblO9AQoFO5l
	J6AQc4/Rv6kx7oNAE80YrmbmkWZZMPi/vt0o0jufCsIxEmIXnAw8gbHv1Xp1TxfiPEyOOs+BIym
	yaM3RBmELFO25MyV5n26zZ16l3aH/T7VS+t0xPbDv+7VvdJ0I+gt7cWwitUAndlHCfOnXpuTd1X
	orMJzsxqQxDycDorZDnNvmFpXDnqnWImqffnMMbUuR6n8iNuZj8Fp3cAjoA==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
