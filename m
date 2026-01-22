Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D61340279
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055713; cv=pass; b=ekRVR7z3UiCR7k5QP8eSXGYOms0LNEaM4dKuazeTlHukXPfvLs37TkKono8YZEe5nffZp3NioxmnN+YFJ31TsNSbcd90Qj1mAZD/ZYZVRwvKZ23ow5c8PCGm9Qnt2g9aGxw38se01969eik4PKk/FZAm8elCaRLV7TwMTCCXhBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055713; c=relaxed/simple;
	bh=mH5awB6ralgR77aSnZe5QraaBsnwcsK7oANg9mkpPlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d74uK69WzA/TVODUw4KCiKXl7ECQwR/FlraSISP5yxo5RQUpRSwTXHjJ7S0OEVeVXa48z8CeamvJy+QTa0b2gtyyZ3FRHLr6jtzJVYHcM9QaLzuezvnheUfs3IuLSjCEecsSXYpJ/NqDvNEGi1MgcHTA3mfDojF9nlalpTJOu7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zQy/Dm8; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zQy/Dm8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b78649941so1973e87.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 20:21:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769055709; cv=none;
        d=google.com; s=arc-20240605;
        b=lFyEI+IodQfokXSkodOZTS+xcTvZ1JEPEhC5Z9lVMJbgwdCkpw+2luJeVPIXPZBgmK
         bsMvtr42IxTSC5YdsIJQsD7Fw5932F4CMZOs4GUpYvjeIcuz4nyFP1uSJ1t/vPIlE0l3
         0m5myPujGvor/tGGYO3ZQtd7Sy6YQrEG67sL/bKfK5Yqhd6QCkNfJZKwKYy3S8jN2PfP
         bAykISUWcy34JuRUNOUFn+8kREPWY740iuUwrVFtIm6KyEU/AwpXT6sRUyZnq0gHO8hn
         P03lVouWX8JqJKYwOsnIcZXCCJw481Cj0nazbITH09ADfgr6ipcvOyvI0xzjODpX1Oc3
         tVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        fh=7VN2qHIqQbwRTFln2V3e81dfRx9YgqJulZR5n753m1I=;
        b=OVSjdwlc3o5T6qHUt9LF179pJibjT2BP7woqxPd4I/ASITjG+AHk1POeU/nefk9q72
         sZfckMbrqklZu71CHE+Lea1Qu9D2X7n2fnbomeXbqcdKgELeyoXkP0SakW+el0nJP7ma
         FjkAW6ec1AqSTedIXemDkI7J628L+eXAvcmUU4jNL2rwI/zM4gvKJJQbS5quQMB7DYTF
         0boNB7bozRbVxgnb2X+7+qkD0dO0yAwj4A7GpAIBCzhl4vsBZAuEhUjwnoFSSYDBuo9S
         6Tm5haT5Gxv3cfs6Fy1phS5jMjYxW7l4x2YeABKNSAkAWNiixptiG85f8YJXbxf9YeX2
         94cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769055709; x=1769660509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        b=0zQy/Dm8TcfK/iDLejdkGKUQOOP3jWZ7ooOgqQrJPCLTZPZAkZopKiYUKC/C7+yYyy
         ClAhXuIspjsgDJdrLUXWIvf5fU7cM8RNVLOHF4xa7pcqUFVXjYw5SU5+puHobJPif2aO
         PZ1Q3cGElKY0o9+bhHRNBXB+DMSyGFS3NrchUlN5JJnv8ETEb2TMUSzEhZQKvq3ctDeu
         fRPG6U+awhPadcCc2e79h1fOQ5Thak56rWPGd+9eDu55QW/EV7hYDrPWCEr77D3zPnkl
         xZ40KACcgE0khhhG8tdoQsHlmlcUL0VhwcpZHXQz0PMbivuHp5E0UL1P1LoIVBW9MZuS
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769055709; x=1769660509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGE6hsUQ8af9Nnk2uwraZMl2mJJDDg6fHFgsmYD1lkk=;
        b=rtqXBmDX7DjxLU0tuj+VMBWDwUfoSYsJwQcOrjwmYY8xODIRhVbA9k9h1hYYeQZX/Q
         PZz9qIaLrTjtvyxOwzYFNgfFwq9u4/4PYk927/xcYYrWersvVZJXihB04eOIQri2la/l
         jQRzt+yK6Jqfrpbsl0DICgA8pxfdvfmBb7w6sYAWAnFy/J+lBfLsU5m/RvTnYWof0Uti
         d29aJH7SsvP7mywd0utpcSYbT4JRZGOsl2N6BSc60WAHbkkkHMf4kjuJl0IrQKEsMO46
         sC5LFcRxxMcpUhUiX1InOMhyu3S9TJQvCL0gQ0tGKKE6yqrKRGaBp9RA2Vu+i4JNmaMn
         HONA==
X-Forwarded-Encrypted: i=1; AJvYcCUBrG/4cpJzGcvri8I4UK4M0z4F2sg67SUPBbfmS1Sl7NZQROoHm3q0mP79OzIDHhRo4LOUOjlhzfm0@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhUG0ewSXSti+mLT10KQmWemiUUgp1hrYQJqK82VagZK5pHWK
	LSVbx5LOOGUVrOFnaUqB9DB1eAy4W9/f3xP3wAFxHFmbQVL1hUyjXZq8+JJ7lI9Hy2h/tYv4ncI
	/PuMzugLZ82ysQMeMlt27iidiwIjy1JFAtxz3swUA
X-Gm-Gg: AZuq6aLoeJX88a5LtYDyVqvkkO0BcXvIhg219D8ksvCp63/O/zXdIjtG50YIIXzT5AO
	dTKW6HIL4n+TFRoqx07/va2l8L7AGFVlxIMPA0S+F3a4kVvAZRwtmgCUpF3RHsQbtN2MHW7IU/T
	KkBce/zqz+26WHs/kdLN2WEjRG5nvnrG0ZaP4DGkWxAwgN4OWdhNlYJXvF0rsgtO1g3b0wo8JpK
	09MrhLzexFbjbhawkwV5PdhBf5mpMXz7XhtIAu47KD9yfyq03zt5P3JqhjT4vbONqLgcb8=
X-Received: by 2002:a19:f009:0:b0:595:8927:8a32 with SMTP id
 2adb3069b0e04-59dd9e0ac3dmr85586e87.16.1769055708809; Wed, 21 Jan 2026
 20:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
In-Reply-To: <20260120170749.101e8bcc@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Jan 2026 20:21:36 -0800
X-Gm-Features: AZwV_QgK7aDkPrzxUeGdcAMqS5gjfqbpQkTe0opAcE2mJCNB7DPzAw0bMRr6cbI
Message-ID: <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 5:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Jan 2026 21:02:11 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding nio=
v
> > array and a uref field in niov.
> >
> > Improvement is ~13% cpu util per RX user thread.
> >
> > Using kperf, the following results were observed:
> >
> > Before:
> >       Average RX worker idle %: 13.13, flows 4, test runs 11
> > After:
> >       Average RX worker idle %: 26.32, flows 4, test runs 11
> >
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> >
> > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > optimization on).
>
> IDK if the cmsg approach is still right for this flow TBH.
> IIRC when Stan talked about this a while back we were considering doing
> this via Netlink. Anything that proves that the user owns the binding
> would work. IIUC the TCP socket in this design just proves that socket
> has received a token from a given binding right?

Doesn't 'doing this via netlink' imply it's a control path operation
that acquires rtnl_lock or netdev_lock or some heavy lock expecting
you to do some config change? Returning tokens is a data-path
operation, IIRC we don't even lock the socket to do it in the
setsockopt.

Is there precedent/path to doing fast data-path operations via netlink?

There may be value in not biting more than we can chew in one series.
Maybe an alternative non-setsockopt dontneeding scheme should be its
own patch series.

--=20
Thanks,
Mina
