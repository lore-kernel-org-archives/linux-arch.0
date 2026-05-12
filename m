Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1B346AC4
	for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598337; cv=pass; b=aXrbqczsjexfrFVc4oEfGgk+4H2X37Xs1jGpFTUGzMev7H47lkcacMcZf9Uxk3iXUq/rnfi3PGc688MvTea1eMpE1EkesNlf/3yRSyW/PIGk7/MBeSDHaLDXXpmaZQ2h8mC2GRlZW3D0Xz2gS5vDF663Xlgr1d9yuFVsFchpwnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598337; c=relaxed/simple;
	bh=Yc9da0wDU/GeX1+XjMTk9av+bBmiHdfCu0Hae/L1BKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Yl5tA5aiP7lQ7obh/5CmeJ1YEP24stQ7rwVPwyNMKLM6FQ0aVoUDWnPkvYBVxsGWCVNmWTdloWjkoXV2PjMbiaA++37gCZRCr4Zqsy2jE2kPQRiRyr8IPVpE+lTcMZSVIiQfhYRLgntAGarfS3dTpDZXSTFXIGRBjU2i8LSQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFQs5Asb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewWkVXwP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFQs5Asb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewWkVXwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778598335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
	b=dFQs5Asb0SssslNn4u2DaL0rTcfsVqwoUQCkyQDtfR5NcMMrmZPE/OBzjd1Tv2lLG8iYN6
	KU/JohGE8OvOd9lq+QCP7dAvTG2NZphmgpUA8PALhS9x5w8z5WramV1CoUjN54lh3XKNcy
	lJ3pLKcgXTXcjngu+QKtE5G1cflZMj8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-h4qo_mqnPUybVeh22M0JqQ-1; Tue, 12 May 2026 11:05:31 -0400
X-MC-Unique: h4qo_mqnPUybVeh22M0JqQ-1
X-Mimecast-MFC-AGG-ID: h4qo_mqnPUybVeh22M0JqQ_1778598331
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd795b6288so114453397b3.0
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 08:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778598331; cv=none;
        d=google.com; s=arc-20240605;
        b=h7ndXwFvwrw+Kj5dPliJjfJWTPgQQtkZNgjVeFzBablO37PX5INUClQEcvv8hENEsY
         DU3EhbU6WImaGHpgRZ1CBsMiYKSJYLxweHg8j/PwMa8XgqNXThgGLj+8RE4M367rPwQt
         sJEH0bHWWgVLfkEMRsAkQ8KARwZ1BNeI3V4dHrWUC6dNhMbz7FYt+9IVRzGcOgvEFlJE
         i+sxg/9sD11+6scZFJHrCFhGS6FLASoZutHoauAw957RwyaPy2+Kci+JAyfXbudCTcvb
         I2ez7KIhoCI7JOR3xk5PkRr+Pmmv/OkLmcZTLDPNvkx7hsmRwt5ai+iBfB/uhQwnsRyP
         UGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
        fh=l4NPzqZCKo19/1rxOFRG6Ax/kP+mY3at6JICbDBXfoI=;
        b=JpW6le+mZph2PK8SSBAbH8bR6WiQMuBI+WYwCjo4sJiKH4MiZNn55NoADDfC13iIoE
         0TITtUP+GlrCtkwBG7Ad5GV2CS5jqtif+MxC5loDPJjseCpOKDjtZlcAlucIkZNzu88b
         d932OGsmvhyKevBWPgK5yD6oa0hHRnqcu2KokNocD43dhy0K3pUtIiFEGMa+O1MWAnOo
         GpZdn5e5EWnNrwCnBRZZ0t4Ji+hxPh3OAjmlk3xK/Yk2C0sGW605YkAMHzQwjDJ/HkzT
         X9PjAZrl8rKAJA5kEbH8rW520HDMD7GQfJkWIjGFgk5T05MF/KmyuHkAO2Kya7ljy9Gq
         2fkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778598331; x=1779203131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
        b=ewWkVXwPkmCZ4XFrslMbpJ7dm1h7H9AlNeXjD4q9j5CcOAw5wxZyAyQiiUl/6HUkyb
         5CAx7JBrlIfZf/BGNlQfXZ+al6czoIK0sCFwoDp1QosILvQ4UsGQ5jk9kRs7n2U6b2a2
         H7DcviGDXUwq1RZS7elQU8cY6hiQkzUEmTOVHHDZUoUrAOPh9cKZnq5QHYOxbVLHmlOy
         V8J/jTHds/l5BMAcgyySDS2G6RBmE26ROVALfA155CQw9Dg4q2cbBvWvpVI3mTVW5v3a
         IyOJjoTjj9dtYQirRqZdbSICf5wc+NphKTtAOxyB3O1OUi33HaBsdZuMQpj/dV3DobBG
         CQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598331; x=1779203131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
        b=jur5iFMwxpyapeBCWbNgNcP+MFrHTSVW+zfrFj8YPP4ZFhccX8acOEOARIFwh5kmE+
         0skK3UMZXrDcxeBv0nnbHzr5s6fYfmZA1jjrGSHPOwgqes5pjtgNUenzJue6FQlV5eLZ
         sY4DRIyWzoREvwfEij6dcjHJNedDvRfIvmPcQijAq+hag17AZoXgcc7P1HxHrpDHJsyE
         dR308ox+5AkNwh1EdUPJbjWoeOlZi0YOji1RNaxuBn5HftDLA2xhJqUYT09EMq7KnaQK
         zZWZUQ44kGNEGsiDI4XsqgpT6OaQVIPm8qKF5VdyfzPovn7/esllFhHL+jEBfmEHZU6D
         dMKw==
X-Forwarded-Encrypted: i=1; AFNElJ/g4bZHjbdUrK7ohbi4eYcZSaRISSHZ9Cwrge3wOgbDdRI7331T09fyczHNBfjT53o4ItS/V+7ed7CK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzja/U7SA0iwssSfrHeEIto6UsACu149Q1x6f9Cf3ocXISxiKrE
	v1MIsUo+BHiTmEKkufTFoInBy+h/8sruqvihFJ+Iipg89if9VJ7uSct6sM22ABU/bp4GZrplsTh
	aOkn4mOCL1vX0SjVPgLWmvm61cu2u9uAzHUhdiQS1rmvgUucS1hMGLCtrzhQ21mHGteQDIl344r
	/9XSaxw8yxyIC4xYjVXyH6ZWdI5WZeuqZSiEH0MQ==
X-Gm-Gg: Acq92OF/0VoHb8k+q0holx68tG/L6Ecck1SZvZBu6HBk0e07KHZxyXan2GW0lqz6Bwv
	UdwZj6PTUjrJspK4USuSWVozs0RvGg3cpnobNIMmIt2BAyZBP9weP9+rra9m6nHjkoV2Yv1pssA
	vd8kmr9SEa0+FWgZIQz4f4OHdjLhExUbcjpYjv4M6CNCdWG12ogZIVKji8A2xEc3WeHq5GlyLMn
	lp3Ug==
X-Received: by 2002:a05:690c:34c9:b0:7bd:6a98:58d3 with SMTP id 00721157ae682-7c50f7cdf32mr36554577b3.18.1778598331008;
        Tue, 12 May 2026 08:05:31 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:7bd:6a98:58d3 with SMTP id
 00721157ae682-7c50f7cdf32mr36553547b3.18.1778598330230; Tue, 12 May 2026
 08:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com> <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
In-Reply-To: <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 May 2026 17:05:18 +0200
X-Gm-Features: AVHnY4IjDWzPTwv7Lf1EJ-4smElfrpc1pe5LEGC8untQsvEPzH-woMO9H8PAPck
Message-ID: <CADSE00LNoc8KgVWR=7Va-Phb2U9sDzS9wntWckDFm66Uz89bnQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] kunit: Add support for suppressing warning backtraces
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 1:52=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 08 May 2026 17:02:44 +0200 Albert Esteve <aesteve@redhat.com> wro=
te:
>
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrac=
e.
> >
> > ...
> >
> > Solve the problem by providing a means to suppress warning backtraces
> > originating from the current kthread while executing test code.
> > Since each KUnit test runs in its own kthread, this effectively scopes
> > suppression to the test that enabled it, without requiring any
> > architecture-specific code.
>
> Thanks.  AI review has a bunch of questions:
>         https://sashiko.dev/#/patchset/20260508-kunit_add_support-v9-0-99=
df7aa880f6@redhat.com
>

Hi! Most look like valid concerns/issues. I will send a new version
addressing them then, and monitor sashiko to ensure I clear
everything.

Thanks for the link.

BR,
Albert.

