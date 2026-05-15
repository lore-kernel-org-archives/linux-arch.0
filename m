Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADA3B27CC
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855129; cv=pass; b=gTPTCSUD/P/VAcOvxuza+5IVXTmO4zWhGZ61DpLUV3VfyacN7iA4BdPhQsKAHSCURyFWqHWL5IleiNNiB9fMMFOb08YglC+OdD4riBK2v4uJ6pTnyZjnpzFBpur90dwcKpoALPVP4031TAA6Kh58naZMx3l4lhEdl5Buc9O4joY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855129; c=relaxed/simple;
	bh=TA5ESWaxk/ziiyS01LtpqfhWIycxEsFgwAIPwQRU0UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPhHsWElLRAYWW2hRa/FD4/+chat+T8SMQRKCectEPqbwoRnriD3y+iAuJG6uC3CXKKiaSFeai+yQ/pDL4EoGvOVhJxdGLyUSQ/mcErutH/P/6oF/s0Z2vucMlBj3oIJ3EOBBEyLK+Zu2VPHle7NR/M1sAy60mXdkRlyiINJh14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbxO49Xx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kmAqZPm7; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbxO49Xx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kmAqZPm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778855127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
	b=gbxO49XxS4zc4ZW5UNlsbRzGtqWtTCHvJhOmhZslF7ZaJCZs5usU3Z6Okdd9vvx/43DAFq
	+TMG86nUPKK0oUFm0fW1qrnJiwCMKDdgfp90wfmEp3bMiPpGnqx+OQYK3hMqLoMLTfmdTp
	ucs0xaPnhvN3yluyip5hANDsHmLZJFw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-tz3g4ry6NfSNWtdPQIIxwA-1; Fri, 15 May 2026 10:25:24 -0400
X-MC-Unique: tz3g4ry6NfSNWtdPQIIxwA-1
X-Mimecast-MFC-AGG-ID: tz3g4ry6NfSNWtdPQIIxwA_1778855124
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c37eafd67so19725999d50.2
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 07:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855124; cv=none;
        d=google.com; s=arc-20240605;
        b=HRJU+pLYtFw/UgcFYBjKQmUDUbGFIghUctieEaGbRe9bS3oT1kGybzTSupdegeKjIg
         n2mJk/NGx4YvglHKRe8yjVhlFz2IKkVXJWSzGlglWRiT3DwyAfJCLKd1w08Znx1LZoRo
         KLgqxTqAtkm2yt37IZ1r4AFAw1xUxjm2LckeVDzM5V4sE9Nz3qR+Qpef5zfq1j/AV0pj
         4Wh6Tp2we2ckEJvwKUHuR8jR/RbJrimDRv3U8lEhaHKBx2WNHCAz6xW1N5/ASzKw8sfa
         1VpUUAPd8GYN+zZr9ysSYXeCY4GKw03bGVkLBpxS0w96CuB3+fwQWOIk9QuAFCrptCjQ
         XiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
        fh=/kUoZS58G3BXxJJFSt6wvJhKWrspQVtSd7bVbTxgD7k=;
        b=Xyj+XD7qP+cd7rnUX/wf0Ju12BWj8V1AXfeJ5bs+mjUsYDUcfY50DE5Ka20ne4oJ6F
         xqToDqkEy1Noltt1yt2lYXvi5Y5O1mNtfR3S+SeIorudFjxGgVFAa1ReArRf/Wgpoj+b
         cGf6WIcqJRpaADdQ4rBzmQ52khYyKe3BCHR0kBDcpvjvFfzwnk3/k1Pm1Mwipch0V5Iv
         NGiMp/F624ySMWn2vXoUCMVONAZ3ip/zo4o6YC95SEcTQthYFZlAZxHFHkLNQ+Sc2zdV
         RvT2r5hwoLNPQWRYHhJPm4WEJrRduOmtHNnGdURAuE+vJyNWuYjnGIM2WB+zBNfcbzWa
         z1bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778855124; x=1779459924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
        b=kmAqZPm7P2kazLN8aFT1PqnhpeWMx3ydoEe/A61h+v5zME7GK8LZkuTQYW2OlPyBJ6
         Mf7KA5/24cfQliXQIOLmy/M0+kABsZO0U5Gb2dpoitHO8AM/PYTjn/C7f7OXtJoZ32QY
         3d3QIyZzdr8X2UZHBg38/kM3UYTDA0cDQRE2qiHmUt/QPgDDNV2V0LyHfZiXHgeTRPhO
         UfpEBDprETLXCjthon3nRz7grBk0xK8fxreWjorzjsaltUbEYbIu/dQ7ejZXuyQ9EAZd
         azjkukyNfApgW2ko/Kig2i8hwPfgkhM5zAn2wWrQ2MPxJ2xrCjJ/pfsHfKIYoTOsaaC/
         O5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855124; x=1779459924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
        b=CkGN//Qaaf+Q/udOh5/Q7pmVeUgta/iugFYDLywItR4EO+3WLGyh/zqq1CWp4OppVE
         t3CehJWtcjwRHzmCWYUfsrj0FJW/ScmyvzEhn8Dbum/H5IrCodTPUYv5xONk0Y9MpVWz
         cLCnD3L4cofJJvDR/iv1tARQxJeOFJgxFMyx6ysYAdWhj6MFJvaPdKfhV9OaQEnlCuh+
         gjxxQNm2GayC7zbijNET7FKKZH07o09LoLNHiYLlTBTwe4jwRWIWA+6ejHsn1B8PMbPq
         jCZ2X1QA8r1vO4P3xP6ymSnL2u8tzI4iIAHNdnQJnQE9WIR5brQUzWl+4gWiMEXYC9QF
         cDxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oxkllwoA+V3gpIWWF3SgIn3wY8zo4lMgyrpfdqwVQ1VSUAE/fjDRAo3qeEqduG6nYb+Jm1E/HTeck@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4foqCOxVCHdgLmYvHL1osOJUtM0w8dGxutjHTVZvNaNDsixA3
	QLimGJN5aHnAohLCQeEn4qofuz28mYZ+s7SCvDw0kwew424bpvv9ZKkQ0KU0QXDqKCpjXqVXJjk
	3DwIxT3HAqqO5s+KeYcuEHEJMbZymA38jNccnYh+nBscJpl3QTq35Cr5aRzPvr5vVxnsiz0Wo4H
	MJctK+ox8yuPu/mkZP1Ms5duiDWvysj6xpQY7ydw==
X-Gm-Gg: Acq92OGdzdx3puR2xlFmOC2MlXkhGwo2NXqsJJ/nIaxS2RL3G5hPavGJTOXJedpH630
	7AeMtfRBXdR7XeF6rQTVy63tFMQNMfsPhNnxQ01X4fHpvZ9tDstTH0sPvELhSEo5pupMslY3bm9
	FEePHVbUTfRx0aRfv1FBdrS7i5oVDhodcmXYybbZgZPb/c1kl75KhfpEALaVXgHqoHW2GW/cceG
	kqK0A==
X-Received: by 2002:a05:690c:921a:b0:7b2:136d:240a with SMTP id 00721157ae682-7c95a56fc91mr34928307b3.9.1778855123734;
        Fri, 15 May 2026 07:25:23 -0700 (PDT)
X-Received: by 2002:a05:690c:921a:b0:7b2:136d:240a with SMTP id
 00721157ae682-7c95a56fc91mr34927427b3.9.1778855122973; Fri, 15 May 2026
 07:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com> <7bcead90-7d96-4101-bd13-dde2c5ded1aa@roeck-us.net>
In-Reply-To: <7bcead90-7d96-4101-bd13-dde2c5ded1aa@roeck-us.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 16:25:11 +0200
X-Gm-Features: AVHnY4II_A6w9jZTl5s671EZUUpKeCpv5nVKmn-MiUqfHzgEw_QM_N-JJo0K588
Message-ID: <CADSE00JVgP50vud_3uvvjg6HDeEwc1TsK0E=gSKV07jKtT+vMQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] kunit: Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 3:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi Albert,
>
> On 5/15/26 05:29, Albert Esteve wrote:
> ...
>
> > Guenter Roeck (3):
> >        kunit: Add backtrace suppression self-tests
> >        drm: Suppress intentional warning backtraces in scaling unit tes=
ts
> >        kunit: Add documentation for warning backtrace suppression API
> >
>
>
> How much of that is from me at this point ? Wouldn't it make sense to dro=
p me
> as "author" of those patches ?

Hi Guenter,

I do not mind authorship either. Signed-off-by lines already attest to
everyone's contribution.

In principle I am done with Sashiko's reviews. I addressed all
comments in their respective patches. Some lead to the rabbit holes I
put myself into for previous versions.

I do not plan to send a new version unless a human review requires a change=
.

If that happens, I may update the authorship. Otherwise, I'd keep it
as is, since you said you do not mind :)

Thanks!

BR,
Albert.

>
> I would not mind. I had the idea, but others like you are doing the hard =
work
> of pushing it through.
>
> Thanks,
> Guenter
>

