Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4C41B36A
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970240; cv=pass; b=r8kvD4K34QOyHQuZDIXzohrwy4MVFxSwOHqZGQbvas9UL6nNjIYCEVydzAA7xAtqqvz0I01XVytgPh6qIGuPKHM6Yb5ycgkLoP4f07iN3zuSWp/YI65abzUJw0Zkwt5PjFFkmVXscvdHuTJ8ZEivB4XUK53PLkiLV9rfJEI53IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970240; c=relaxed/simple;
	bh=rHHs0j6a7I//fHT3pf82MG7KfJrjZR5YBmXSmcRKtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/LhDYH/DiFbLi8n1UPw1KXW7XlWt6CJt8VKjZ5bs4HW3FcXLXxPLsM/9+JW5HiCQo0moD1YK4Gi/RKZdew27hxUU2FDB5Bm56R/HLiiN+QoTY4TIo9Ds3v5ny+pWQCFA5c9DCEjmwlKvZKb/StLDBz2Ru3L64HiY0jF+pp1xIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFedNq2j; arc=pass smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFedNq2j"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-6ac83a09781so2695316eaf.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 05:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786970238; cv=none;
        d=google.com; s=arc-20260327;
        b=pMkv4YHm5GeSQA5Q9xLmVMyhTFJuIz+7rRlA2ltwO27ex3FWtXNYfqn/DHHlwng+k1
         eh7dk3SuVG3IibnZ81yqD2bZr8nAk4side6GamVGAUK4ccaa5FA94cHuTintK35rKqwB
         5bMleaxg9EZ8LelPonmMlmENrngadLq41dQihOmsfuYvz4YyLOS2tju2vbBnWewJobT1
         jhVPJ4PfBPQho04jQo9eVLwS/EObE+Gx0weZcQpeqQLHkmwDobj410w0+k0QUmw3eJPP
         5NwnYS31uFKiK17tatamqsIqoc3/dusVgE6j0828qgzmDzqjE28P563nGrvjKLclBUpC
         TLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iu3ggfJ1dkbQD0vLChI5jeIdTaaa9fHYlWca2C1OoUM=;
        fh=nLevxtvAVEGtloYZJUp0tPFJ4RTTg/SvnfbFux7d2ew=;
        b=UiohSO6hLxEwyPzkSV9/PDt9i4jGdSjCNsht/9uWh8CE8yzCxip878WC/pUDh1NKbT
         ivcg2w9rCzlQ4pOpn4Iy800JsbqSpL72gsi0/R4FTyd4QgD/nYfOU7rSqGa3dbsGr8TZ
         ll7RmmtgZluOL+w4OEvBNi/PNXwPHTSbz2WC6LSPXgWmRP1Io829tVF4atCB6pzSEzyw
         znBFbYC6lR6P0lBtYhvSYxUu7jG9fqnAWdCryXjtXmvq7hdtlgQcxKe/qFBaoa4YTL/F
         TOACYWnum4HmNWUCa4mNk0RMcLIMNhHDsfcQp/0Htjde2X82I9MVA1vM1VIgwc6nVBqU
         j2AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970238; x=1787575038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iu3ggfJ1dkbQD0vLChI5jeIdTaaa9fHYlWca2C1OoUM=;
        b=EFedNq2jwy/fjmG839z/qeCVfHxgQvUHRlg/zNRvufflHz7dhDip+BzzQOFDFrtGbe
         P13+IhpSvjFPeKqFmdFFy6KSt82mlRHDRHPvjNJECffXo8lhUU++xjB5nJ6r+sakp7yQ
         eNVZtw2eXrBaS5MLV+IP5UEi9uexSf0/Qmtz92ITwBYtQbj0sfZgIWAGv2bfMss6vo7j
         e2DGOgq0p6x06q5EOZ1ibYtyZbkfvjykImSLlsao+Qc+zGDo8BoGTT4QBmv9COyJukL6
         3wPIrEKe0NqBpnVxvrdBXXTafMTdi+a/R3cNSsNNFg7kL3psLlOixdOWLpkvsgwVOBKz
         L2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970238; x=1787575038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iu3ggfJ1dkbQD0vLChI5jeIdTaaa9fHYlWca2C1OoUM=;
        b=fNdBUzNjWvlLEK0B+yBg0DxA3xTxn7IwRI7dtjl7Qv/FocY6P3bv8ztIHbmKtU8AWv
         8+fknGTz7aYSHau39yNrf7Re0uhEI7CLtjBpa6BXgOLonkjnotev7aDZTuDcpE0F9rF+
         QD+JA/5QHPlBbaASWRtpiYZV8fqGDMXafaye4crFpA9adx9IVkfqvFWyr/K6FTIw63zF
         G5ctVNYb3h2RG4UhUmFlfGOWthMMnLvMK2f+0hc3R6VEY/10f3Y0EP3pIR1HhpdDeVtF
         YICKTho1RfTfDICst2Oz6gGa3/G4h2cMVaunaoxW7OaToacVnwF0rGN4iEZWk8kzl0Er
         OTAg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1RPS47Oy/wcxprw54V2osASQQf6DjMEW1lvzpoQCt7NWrm73KB7bkN3NQC2eZDZe6sbdCnwgGj0iw@vger.kernel.org
X-Gm-Message-State: AOJu0YwHq85MKblBc15w0moN4MNyMezrKy2ZDqRxrpIg5BAhLd9RFJY5
	1BujR45A8TowoPWTBGf00YlHAiebe5SGUEuW9F6j4tosmowO3LtYlXRXcZ671ksnxhfkl5ztrC5
	vOeVZcYfL15oR1xX+ozcX+YfuuQXfwQc=
X-Gm-Gg: AR+sD11Zh2ndlNFik2p6F/c2a7DZJzegOW+Ug1opqpVFEpojP64IS5JdQpvf4+DjpPl
	1hyZtcIG6AXmifckmbgsp4GNjEV+nV+D6+gnrPsMhAMTAVMgmYgerh85jGmBOQP9tOTv8RhyajS
	neLNLm4cqjxADUjHSRp+oU441RshkjHR9VlHgvplgdPS1KyN/5J5dtyIWNAHv9IEiLxY7q08X04
	l5i76QX7ex+MkhWz4ZE4wa4onqdwx4n3P2SsNkOJcSCbbABpaUgeCp7Cblt89K8bF4oRM042NHr
	LqHZbQ8gw6h+jVMygE54uKUsJOjeCeEgxjQ8AKM9G0v9G4AICj/8NgDlXSV+aSNajzo6/ty3ZtB
	u5uD+twWQGGM3gg==
X-Received: by 2002:a05:6820:1ca2:b0:6aa:da90:8bd1 with SMTP id
 006d021491bc7-6b0c5b8dc8amr18770508eaf.11.1786970238244; Mon, 17 Aug 2026
 05:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
 <20260816153811.1085261-5-mathura.kumar.tech@gmail.com> <61e9bf07-78b5-4696-b467-4c0ff462fe75@infradead.org>
In-Reply-To: <61e9bf07-78b5-4696-b467-4c0ff462fe75@infradead.org>
From: Mathura kumar <mathura.kumar.tech@gmail.com>
Date: Mon, 17 Aug 2026 18:07:05 +0530
X-Gm-Features: AcwNN1VLtbvkxKepq4r-YbHCLxnfkYpICDgE7sKoAnnlIFx13jNqF7RarV2VfhA
Message-ID: <CABSt=QTZPCWgwKfNgV4o0fq_qjMs19binm74eX8GApsKs7R09Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Test: Added self-testing and documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yeah, I have fixed the minor formatting and one unsequenced new sys
number for microblaze in syscall.tbl
Should I wait for a complete review for this or send an updated version,
and one more thing sashiko show potential regression in core
augmentation logic but i think it is false positive and i am pretty
sure, as per my intuition i don't think it have any regression
regrading propagating msg count after insertion and deletion of node.

Thanks,
Mathura


On Sun, Aug 16, 2026 at 9:36=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 8/16/26 8:34 AM, mathura kumar wrote:
> > Add test coverage to verify system call behavior under
> > different-different cases.
> >
> > Update index documentation to include two new doc.
> >       1) mq_recvmmsg.rst
> >       2) mq_sendmmsg.rst
> >
> > The tests validate:
> >       1) Offset boundries.
> >       2) Partial success behaviors.
> >       3) Timeout behavior.
> >
> > Documentation changes include:
> >       1) Updated implementation details.
> >       2) Error handlings mechanism.
> >       3) Tests details.
> >
> > Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
> > ---
> >  Documentation/userspace-api/index.rst       |   2 +
> >  Documentation/userspace-api/mq_recvmmsg.rst | 205 ++++++++++
> >  Documentation/userspace-api/mq_sendmmsg.rst | 168 +++++++++
> >  tools/testing/selftests/ipc/Makefile        |   2 +-
> >  tools/testing/selftests/ipc/mq_recvmmsg.c   | 392 ++++++++++++++++++++
> >  tools/testing/selftests/ipc/mq_sendmmsg.c   | 360 ++++++++++++++++++
> >  6 files changed, 1128 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
> >  create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
> >  create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
> >  create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c
>
> Documentation build warnings (from 'make htmldocs'):
>
> Documentation/userspace-api/mq_recvmmsg.rst:96: WARNING: Bullet list ends=
 without a blank line; unexpected unindent. [docutils]
> /work/lnx/repo/linux-next/Documentation/userspace-api/mq_recvmmsg.rst:179=
: WARNING: Title underline too short.
>
> 3.4 start_idx argument
> ~~~~~~~~~~~~~~~~~~~ [docutils]
> Documentation/userspace-api/mq_sendmmsg.rst:77: WARNING: Bullet list ends=
 without a blank line; unexpected unindent. [docutils]
> /work/lnx/repo/linux-next/Documentation/userspace-api/mq_sendmmsg.rst:146=
: WARNING: Title underline too short.
>
> 3.3 start_idx argument
> ~~~~~~~~~~~~~~~~~~~ [docutils]
>
>
> --
> ~Randy
>
