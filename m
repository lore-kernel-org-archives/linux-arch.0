Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA62FFF8F
	for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068222; cv=none; b=ji0zKstNtO8A4HYFW+sV08AUmvRrjo+chlhSIBIcrx85krQuEXnXZSIGy52wHHx7V/LwH1zktAKA/NTiyEFnj0D2jPa0pmJTAYk+yPkIkyRIM5osRXFAneEAp9j7n1cMJGv5Tz1BrZXTiSSwW1tPLIJXUl08YezGiiG0gCkxebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068222; c=relaxed/simple;
	bh=0xgT9UAyy6dldeOjLlvwyOSVilJyIrH3poxlzwBN6a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rM953Zvfsqq1Al2mK8FsnhvzUXVHHwxgZktZTUCBd42ORi9415wj/oLtfJRiHcj5o09htzEVMJbGUXBMC/q98+O6nZNnjI+k8FTtzvuFxTq5WhyozuGuDkEfLgOyJWgqXqCHZ68Wq+yXiMBwCxEw5hGAw/ex7uWIpMjdwmmISAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W95ND3Wv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W95ND3Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC11C2BCB1
	for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776068221;
	bh=0xgT9UAyy6dldeOjLlvwyOSVilJyIrH3poxlzwBN6a0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W95ND3WvLW8fbgFbQAPGFt/X+X1mtZKSukJL81E7N1LBYsmrSi3rIvwuYsHXHBOjT
	 xDHGibGgx69wHahu3CoMq0J+zYiGvtQnwv0aatZc6B7GBZI/2SfFlRtvlUG+wt9OEc
	 821CjMHO874YPsxpOIIn5MmT9WX/jTyR9OoL5/1WWykMqlBpS58uNF+rxrBLFc6nBe
	 Mee//GXB20H4CxR7tjaBND6fdzdUpYr+Z0N9wvbkqcHnMAUo+36Js/4GgZe9wHxclA
	 DXZmTztDeYxJKFW9Mt9WNh0wyk/LqGdcdm42gU3nFm6TW6mB0LVcaJ/GDYhCr5mlFf
	 HAambJNL+8VZQ==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso3501056f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2026 01:17:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ82BdQLX59FrUA0nzK4EIHUatBUuDBSkkXBl/4vZeabbiYuXk0ykTrWKVHFIv5OlBNHeAcv4BOa9G3x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8xCQkVggKG74SDcM7NKE/bgBZLXDmkF0rL9qTSNkT/HT65Fu
	qDIQTbavWk9uuDGFEZA1WHY0J/CRKkVySeUe4VbYaB78KEHJ1NgwJfBLo+acTLjUY2A7v1Xpgie
	UQenIGXwMTIKSAosPy/2cLmqbUptojOs=
X-Received: by 2002:a05:6000:18a8:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-43d642cd3a0mr17228065f8f.39.1776068220423; Mon, 13 Apr 2026
 01:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412143116.1445893-1-guoren@kernel.org> <535f3eaa-ff93-4de4-86c7-8a6e46bcca63@app.fastmail.com>
In-Reply-To: <535f3eaa-ff93-4de4-86c7-8a6e46bcca63@app.fastmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 13 Apr 2026 16:16:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmBp09jAhxRsfxOQUGwJfcDi=yn=0P=b_EA0j5pkhzvg@mail.gmail.com>
X-Gm-Features: AQROBzAQ_TMNnMXoKwQOIsDBlTlp-ZA7dGPUKWUKO0eqq1cjymrJu0NCXGNs45A
Message-ID: <CAJF2gTTmBp09jAhxRsfxOQUGwJfcDi=yn=0P=b_EA0j5pkhzvg@mail.gmail.com>
Subject: Re: [PATCH V4] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leonardo Bras <leobras@redhat.com>, djordje.todorovic@htecgroup.com, 
	aleksa.paunovic@htecgroup.com, Han Gao <rabenda.cn@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Han Gao <gaohan@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Xiaoguang Xing <xiaoguang.xing@sophgo.com>, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sun, Apr 12, 2026, at 16:31, guoren@kernel.org wrote:
> >  arch/riscv/Kconfig.errata                    | 17 ++++++++++
> >  arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
> >  arch/riscv/include/asm/errata_list_vendors.h |  3 +-
> >  arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
> >  include/asm-generic/rwonce.h                 |  2 ++
>
> For asm-generic:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> > +static bool errata_probe_write_once(unsigned int stage,
> > +                                 unsigned long arch_id, unsigned long =
impid)
> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > +             return false;
> > +
> > +     /* target-c9xx cores report arch_id and impid as 0 */
> > +     if (arch_id !=3D 0 || impid !=3D 0)
> > +             return false;
> > +
> > +     if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> > +         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > +             return true;
>
> Question: Are the affected cores the only ones that report
> arch_id=3D=3Dimpid=3D=3D0? If there are other known implementations
> that get the extra barrier but don't need it here, that
> should probably be mentioned in the Kconfig text and
> the code comment.

Thank you for your question.

So far, we have only observed this issue on the SG2042 chip. However,
in theory, it affects all older c9xx cores that report arch_id =3D=3D 0
and impid =3D=3D 0.

Since these early versions are relatively few in number and share the
same signature (arch_id =3D 0 && impid =3D 0), we decided to apply the
workaround to all cores that match this condition to ensure complete
coverage and avoid missing any affected silicon.

--=20
Best Regards
 GUO Ren
