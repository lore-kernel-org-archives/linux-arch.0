Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AD30C62E
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355578; cv=pass; b=a3K2/z8lZ0QOSrb8q13B1RE9lgShHCzKQjQEoIu1X/SxXpJm0IEh3mIZNJITcqBk8qrOrD4glIQ42y/8bUtIW8J3/Uxg9oZ+zC+XfqyStNve5m8OlEgu/ATygUyeeuTIV+3s7txhzKxsVaDyjZfBIlzHKsvUVua0OgDi0P5w4ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355578; c=relaxed/simple;
	bh=t4c/prX2kM47f73KS173peuhIQJkJQX0xyrhbtLBLqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoI9rMhn60xoBW9LSYIX/a4fbT74tDjmELkJo+D/s001kLGcfUObb3QZebnaN7546STmvBrGjC5iwEx/qhaiJ2zW/07A/0na/SBs26oIiejvblKFBOVv1s7KK+TVTZFZYzJmWh1OeFWZDwHSS31/fh+cr1BSzjbw5ECg6AGwsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmYQtEHC; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmYQtEHC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso657a12.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Jul 2026 09:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355575; cv=none;
        d=google.com; s=arc-20260327;
        b=cPvNhlXBXG+7oNSqIBbWXwqfuq/UBZt1D5CEljfimA4sl+Nq7putYhwjF0dw64slOX
         5A8nNBTUvJzJFu1KwECNtLIVnpdbXjGUvb+lC+1lZiUwMpmnhA5IFRvLxrJWIaJ/FAcJ
         jqdXBiwmfG3JwZVOSRbS91mR8VxOegwOMLBz8TRN5d04RXaoNmV8vFtde5/usie99mbN
         4xHIEY9UZBpISBAceGvDbCSCFQ+B7M364Uuk1nq4cylEt9fm9WhsovDgsPUtv4vF/fRJ
         /2q6hzpK+PUsZYFvtR5jljDPUkrLvs5btpVj6TEDtLRS/OJIWMX0d0FUJ8vQK9mUIrk1
         3PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        fh=amy2evqe+LVfjURbpItB8KiqiDGc4Qg4ki0ENw/FsSM=;
        b=I8WlpfWSAtT9G0ne3CYmhoy/VhgEeTTAviXgzeaRdql8zWlJDz6AVJ/UP5ulIQZtBG
         mFZjG9eD2vaFqmV+O0WEYxLKUvNBsbmMbFpWApWUwDO32w3R9KCuHeUxZI6cfXBjdcvO
         hnhBMOdG0Z1P7onfLystN+oHohwWY0zLhdH7OuMZ3j6YrwUVVmTIHJ3NRN5fF3lC1mf1
         byV95w5jwk1PizTbK+a06o5tEwzW088IxghTk/c4jiCgSCV9r9sPXXadNoM3po+ButI0
         8YLLWhDtqwTDj19OSAm0iAG7gmeDUFEcL62zShQ7mytDspoKup8mFt11UNbPekiNj1PL
         yT6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355575; x=1783960375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=EmYQtEHC3rJK9HuS6kuhKNlf3FDP85kdds1TVxEbvBE2CqtRgDgemp5I9xUh9tnBu2
         Pmm0OgtS3uY0N6QsXw910miH8lxqm0bfHjPUhL4Ek4JBY/zoqbl9BkzdUqaA0+5tD5RY
         rNO7Q//VJ149kJcW/XbNYcj9t9FzcZOHRhA7SmFrY/sKor2xHrbqUgtQtSVmh2TSjyBg
         JwYG6Qc5DXlYY+dByxKM3AGG8A8irZgfL7etu+XqHtZtwqifu/muoHjp628twd5cB6Mj
         kWqdZlIk4igcZMHlTl22SlmXY0Niy5uHDkuTGPbHsXrpYvXzGyUDAI0JWBvdEefs12KE
         tSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355575; x=1783960375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=ChiMILFyQI9qStbv3RufSfJACvBZLmFeU3jEezxT8VjihPXe7cCwvwm7AOS9BSZkVp
         iH63FxZthAkUVZkNJZKOuDUMZzd4OKhewnl8dP0wkusm0ZH7YPoRrCzkOQ9NNVk2zQ5t
         L8UBywIBLrnPXa43uoqAmTl4DIpUUzqX6VyZT61fBX0XjITb/b0r2Pzw4BL4W2gnw/tR
         jsYB+VxYeFzh5FAbuleb0bZey9tCmz8NRmoac85YEQ+lT2zZYJzKE02jejtWkJOE3qj5
         283agj/HfTvik9fFQYa8VFd0rjk3GVMA3H4j3HuFvbpkZ6YyFCbxXTwbxQ7kjgI4Y1tF
         31pg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0znQevOvZtx0OS1zds5QYrrrVtoeMK/xAUxsEdizjNG3FYj+I9kwKbOaNg5IL2TaX7y7ZwKI/mKwz@vger.kernel.org
X-Gm-Message-State: AOJu0YwOm9X11e1WI9+AHnQMQEfysBDaRDa7CslTHeV43L3FUg8wtLci
	vb8rQbX4jQ74ffAob9xRzKsylR2MihpoPz1WcqQFLVa5FzSrYcr64ugOlg7qXGWAbw5KZTj5Ygg
	EqPy3Oz4lyvvIiCHi/h5k3LVz9D9o4PNQ59k3ejUv
X-Gm-Gg: AfdE7ck+xoWd1MwV83Bui2IuahF7sFRSkLmFRDd2vX/mKjPLmMjxIe+BD+POogM/x4Z
	fgJ+G/Jxj8r9L7MmTKAT6yhiyMNfe+Rxp5jhvnU0c2ztlY9PN/oPkSbawpwGE5Q/Orw+gDVHr+l
	r8I9XAWhGFnPTxLY4GN50+NRewI9T2XwcXItJx6flhrL4tki1UtfCjWISskzNPkEHZ1QhYB0N3m
	XPgBPVpV8gEMv/0WTTe93OO2UjzHrYoHKxlZjWREa053q4jPRTLi8r+UKbmS3sLnsZmSVZCTyw9
	TfyyieS4tLMIjptoJ9Kqx8yOfapiNvEyozuSZqb2CtluQV7csiVKem+fzw==
X-Received: by 2002:a05:6402:a2c6:20b0:698:aaf6:88ed with SMTP id
 4fb4d7f45d1cf-69a8d5ed3bfmr4552a12.3.1783355574513; Mon, 06 Jul 2026 09:32:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner> <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
In-Reply-To: <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 18:32:18 +0200
X-Gm-Features: AVVi8CeD6mwq1gcY0rcYzICnjlSpXjKTO3gnqdNJY9gW__HUf8Q1MpIvTqehCOI
Message-ID: <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:52=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> I think the straightforward solution to FD_NULLFS_ROOT would be to just:
>
> - make it always available
> - refer to the caller's mount namespace nullfs
> - work with fchroot()/fchdir()
>
> So I considered two chroot() use-cases for the sake of simplicity:
>
> (1) You want to isolate yourself for the sake of lookup
>
> (2) You want to isolate yourself to assemble a "private mount tree" but
>     not really be in a separate namespace (very odd use-case... but it
>     helps to make a point).
>
> The problem with this approach is that everyone who chroots into the
> nullfs root would suffer from the problem that any mount on top of it is
> still visible. So that kinda makes it pointless for both (1) and (2).
>
> Also all mounts that someone else would do would also be visible
> allowing multiple chroot()ers to affect each others state. That also
> would somewhat defeat the purpose of the chroot(). So I'm not convinced
> this is what we should do.
>
> IOW, I think FD_NULLFS_ROOT to chroot to the nullfs of your mount
> namespace is mostly useless and just not workable for unprivileged
> fchroot().
>
> Instead, this made me consider whether it wouldn't make more sense to
> allow unprivileged mount namespace unsharing for both CLONE_EMPTY_MNTNS
> and UNSHARE_EMPTY_MNTNS. Look, there's no real risk at all. It is
> literally just placing the caller into a new mount namespace with only
> nullfs in there. I fail to see any attack vector here. It's literally
> self-sandboxing and you give up access to anything that you didn't have
> a file descriptor open for. It's actually a bonus, because you don't
> need to use userns for this. You just throw away your filesystem state.

I mostly agree, though we might want to gate this on no_new_privs just
to be sure - you could theoretically have a setuid root program that
gives the caller more privileges if it can't find its config file.
That's kind of a far-fetched scenario, and in reality it would
probably fail because the dynamic linker can't be found, but there is
precedent for other sandboxing stuff also requiring no_new_privs, so
we might as well require that here, too...

(I think it actually might be fine to just make chroot entirely
unprivileged as long as no_new_privs is set, but I don't think we
should actually do that, that would just be unnecessarily playing with
fire and would probably confuse some security monitoring tools or
such.)

We should probably also reject if current_chrooted() is true, for the
same reason we reject userns creation when that's true.
