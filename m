Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4039E184
	for <linux-arch@vger.kernel.org>; Fri, 10 Apr 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806871; cv=pass; b=Gf1/4NPZgPG2959b014LBqx29ip9lbqEV9sAfcAXeKplr4lu1mGpSr8pnphuOD33GRTe2WE6rIqlQ5jP8X9S9Ipbz79dzj024qpGpwac1c1IdmUCmacn3t9B23z4EMS4qpQmbWiL0QOAu5iEnvskKbueCQQOT50KDX7sYf4h8N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806871; c=relaxed/simple;
	bh=IDdcP5PunTf9H+4SJfKGmj4edsKHuDSLPd+6NKyAilM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTRIz+ry7xmAD8iE9aZClhk0ItxoFQAA9DWvksy5Vh36lFkyQdFUindz9gRM3Nu0z4V+i6dj854iIMIrEEOJvl86N+pdqOuXTbfd4WuTGDFT1EDMaNby/GVMQkDNEw10D9C3jZW6kZNisHeHeqApFo2RqXPB0xm0wpeUQLxc+7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GST7h6Cm; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GST7h6Cm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so658315b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 10 Apr 2026 00:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775806869; cv=none;
        d=google.com; s=arc-20240605;
        b=THQbVVCYEFKftNs5urAop7dGYYjcNj/+fneMavI1eCBMKnWUHTG1OLmCd8ThDqB985
         2LKlRg9zW2E/OoEwDLtzRFg36dX65Xp2mJfz2vmDnQk06FAcDCT7gGcoWQ7GivfaJLLe
         V8SA2cmtDeOEmagzNnxu51HWDkazZHUfUEUWZdTUMU0g7TXilc1Mvzm4SZUUNKJQc3Jo
         1pEjjau7vmw4BLExd09v9tQEf5ZCN187RppyA57SC8zRDlfiCAwog87Q24JkU3Af8Z9W
         Kv8cZVACA0cYzbHkMQMINcAVJGFGtg2+Bk5GCV0wDWyuIWIoVQjTgaNFLbm93IjZFxgU
         mFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        fh=7/jZsCh0YQwMJ0A8CkES7YtC3w6PzDkXicmGKqUCQtc=;
        b=VdvQE4LnvCnegSV0mKh6OUS+NSjjvx6T6TWBN28T1OEFH0hFiEXHbS26QKHPPgSZDe
         A98vZG9QvXrmzFzG+peRYCqVKM2yXRanINvDzGh17P1NrhBM7lFy1rMes6xpV+kzPB8w
         XVnolZzkXI/XWnYuOPDvO9YlpYdjAhuRu02L4yGIkdOoBVyvfDvTNv7ftS8oLM3hUj1u
         WhRZAUOMyJvjf0pZ8YIiqHQw+zMh4p5zla1yuPEBe+6+XpH2VSC/RBdtQL6V+THp0cVB
         aSQKkDeFhCFCzX72fGt+SRjaT9NH0fKaehbpPFQ6waNukcoUF9Eu1jn9yd5hOy+GIwEP
         OYVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806869; x=1776411669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        b=GST7h6CmGd9Vskhfb3E5VH7x2RypNzKRMUN6oKg+fzHYWKzGqteRGVxjd7POFM5ci9
         Lzv8Sr4pNDKNZV68zUOM8T0S1+r6yKsqudBYM8I/KyV/PA+eF3wCdhbHl9vHNECCNteg
         C0gjS/xM4TtW2stqphc9Ua2qBfDev5VuPTa4xH/TfwPQ8v0IigGcqhYcmKPCrd11UHfk
         BQ2h2WOtm9L+LyubNPz5wxTRfDu1WIOVHQBwc/qgGu5nrnanm645vcFzLOGC7FM+BaR1
         LdJYbwVcEBFpw0E4HzPCDEq8cxGeBl/e/ew7nt/oLfMeBzmtnAurwUcItp+bXbHG4qsM
         NW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806869; x=1776411669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyUDLe9op6fro+UTV2QPNy+ybN5BymQB+k0QJvZZ1Z0=;
        b=EcpS5yE1TugorUCkomeU/jSD3EikhldnyXVH5r+a9zgwEhY4nuiBuAt+gi9EGDf6gp
         ixiDnvdewrZFNSayH1F5h377iw5GvsItwf70roJ4p+10nboTdqrrU+mRLrAjqeYfrRXf
         rV/qMMUrT891fNzMZFrPmNIt4LH9B2ou92LqWYy51+9gXdI3H5JlCShIwcVa/+P9iPfP
         GU5i9cZlURRHdNQCEGehVVq20bqDajEXLh9CTJ0CrnISh43MLh+JwVYVvgK0bNNJHxH0
         tCgGvMFXRyqWkNCqA/T+Zviml2pZ/fj2SaTlUUa2c3AXf2gJm5VpzVvKNLTKHB8Uk7jO
         OdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUViHqKQXfQdFIlWKOS9rGmk1N17k3QD3T8VsYmpHqKgDQuG1GpMWvQj19y7vwMls3zkEjYw/A0dKzK@vger.kernel.org
X-Gm-Message-State: AOJu0YyuK/7qlaE3X0uZOPVICxjd59118fLFxFdh1yi28gFLgzSfD4Dd
	dwI1Y+Sc98IXLHokEJuh2vTUO/224ZSGO567hAh6y1KBStiTyPKROvWGAYFcSUPRbV5Vvya+b2O
	iXrvw9BSVJ8TTkgIXLN3RZWm+IWtIWbc=
X-Gm-Gg: AeBDies4KCRsHfjMSV/qQ63xxSwnBBR9/Th6Lrp3fAuWnGn0fT4qxeeNOWNU99BKitx
	S3qsl5n3NwFzNm5gIheT8P+G9I1g1jhPVG+lNi8kyoxnwbmvpiDE3cRd2cA1yXALcuAlJCoK0Qk
	wfoOZnQgpquvQZTb2vXrvcR4CtMEAUB9veInTQbNy9HPnIkxVKDgAGeBm70/9i5OdWIJR+/Ax/+
	gp7FE5xN9/NMmCsBe1kmyszMyEumTAnHV/EG4CCaSHE2Okn2yAF0XtY9dp3feI49kAlR4TdezdD
	ke/6pCZx
X-Received: by 2002:a05:6a00:4c1c:b0:82d:2a2:1b57 with SMTP id
 d2e1a72fcca58-82f0c2de0d6mr2666948b3a.51.1775806869429; Fri, 10 Apr 2026
 00:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 10 Apr 2026 15:40:30 +0800
X-Gm-Features: AQROBzCc13uK7--1sLG2PO89IiJKd69sYH7-2kYxtSyBLGpYrIlbJBmZfwE8lE4
Message-ID: <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
To: Florian Weimer <fweimer@redhat.com>
Cc: GNU C Library <libc-alpha@sourceware.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * H. J. Lu:
>
> > To enable THP segment load, ld.so opens and reads 2 files under
> > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > /sys and is expensive.   Is it possible to put such info in vDSO?
>
> Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary

Does it cover

[hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_si=
ze
2097152
[hjl@gnu-tgl-3 linux]$

> vector a while back, but I don't know the status of that.
>

How can we get

[hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
always [madvise] never
[hjl@gnu-tgl-3 linux]$

--=20
H.J.
