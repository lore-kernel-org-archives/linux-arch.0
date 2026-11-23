Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457311;
	b=XqVKoe3v1oC5vGcKtlotKLi55ktm9RjBrlQkssOFV+JfNViN5nPhROCS4WHltlKlDmUb
	 xnQoLS83Q5JcBgbmq4pl3Kji2HJ2WUx2CMB7WNrupgS5xWIud/fFLuPgVVeyOrSDcThUS
	 atwrCStMEZARZ8w/ISeypbNxwhHe4NiTD+mgzSI0gB2Ee7wEcD2QBd48L1p4edY8VivTM
	 s9k8Ryy03FXpauIGzK3OJi+3noLxvzfrggq+ppO5X92v2WmtZedUgwTvVEEtueLeswbTt
	 kPS9amPJFvr9n/w96SAxhaSZCTfYReswnGRR3vd9H4wCLrVBggEJUm6cUScfHTTIMUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
	b=a7pGto6xJ73nwjs22C2vBE+8H+dgRHHnq1nVhon3/vNdhFBtPnnwJH8kplM5eTmDwhha
	 BMzsj7p93b7n95MzlyvKMg09Bspj8GuwMFFC30ZgOR2Av5N/ky/45owfZtsdXJbPHPSCz
	 aqigc6jescuvs6Cuha7Jlla1aIL+ESfIVIg+8FoXDJMaKoWQkHIjABye0ufcKaP6ximp2
	 0QOAVDMDKv5xR9OxdA3m71iZtFimYRzTSZwSDR8pxkrDwTY+so/1VFDqSZWBf+QhvLYv6
	 SYGwe9nwzCundlH8UucjgNgGzuoyccceiVy+9vNt4v9s5oqCSsVYed8o6SSvhPM2+Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=un+KrnTE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CD606A31A
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D27CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=un+KrnTE
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0dba37a7fso28770817b3.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 10:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457310; cv=none;
        d=google.com; s=arc-20260327;
        b=FYxUEw0/7qcln4mZ5FZUUM51/vcWJEONBVXPboLwYjimb9qT2uvsSMPg/gEC1TnwO2
         ZAO+gbfr0RLKYam5FbaiIbU8ZXjs0oeG03IW8pkzWTphAAp469zjRf9cgIT6yUJH3tAy
         qnsU5yaa/8tNqHM+yuvoyZn4g7PLelVIXWTK5KpxDMUp7sPX4kO2qKO7RL0N6t/cUlUv
         muooo2uLZvQWgiDG2bTMLb3B8ecrPumaul/Cf1ZwXgl8iuqgvejo5MfTD++PH3gGuq1j
         mBxDx/dDQyzmliS3zEeRmNbPFiLecJxcDg4ofTMey68L5/sUyc9SRgC2nXs4I5g5iMKN
         GLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        fh=J0mMjwVTi1i56fSYdJOsx0Wd5af74qmNDEhG0oRiftc=;
        b=FFtFeTFg5wy2N7CDsbLp8GWyDDnJgA8aa8i1tXoEetD8/5siHeh+K0drxYHSWm4+Ad
         8O+UuCzD6xf6+/ugIu16aHLTCNrIbCwo+Facwut2bwZGSz4R5QQs9JlWeh0j9W/8uXz8
         KJCv5YZJikgd70MaSkpV2usT01oALzzZ4ZhVzO+obDAS1vqsjenPi8P8LivDRFzLoEs+
         zRm2h/TdaGbd4vue+Ty/TL4gQl1N605Vtys4NxJyuwBs2OGe9omP8tmtzP8OVV06oMyQ
         M0XYephvJBcBBmE26jKuOIrog54mCtIGQSbK9BzxWWNeC5PWm3yA+nW0AWmtm2g0j7/h
         DoSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457310; x=1796062110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        b=un+KrnTE20u4uKJ0y9QdxzvTq2vJ/RVHg5bge5mrgE5548sFECDdSkyp0EL9VmSZlE
         ojWp0lHAYTFrWPbdWm+ukpizQSfFUNJE2pLjjPiSR2EwdTiUsBdv7r1OXfpv5fDc+h9h
         t0wb5aS+5Yfsd6uGZ5jJNPB1iYDBq1ZE6CRQDQlFSyDWC/FJlmp7NaiiLj/ws0nzX8+H
         foqngf+GfhcT5MNWiCeZeR1y8CQPqT4jdFTVQTSCHd8eao23yVGwHidUWyjXFk/2Fsqs
         Y8kH8TsE2c+4Pz3MFmFD1+DWT5xTAqe+lGK8KNtcd1P2w+OwsMZ/maOBMR+e5b/rr6SP
         ZK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457310; x=1796062110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        b=lFpROj96TmXN9tbrxRE4eVPmm9uo4Eg1miIILquDBvHfiQJpV3/qG2j4SIRGMSvbph
         i3dVTD0Rr02mIwIO5KB18p2+OQQJSSdJu6xrT0COR+sy3pa9gUYsdEgh/F//6kvNR7sE
         5QiOwvhMzRPa4fG7Q5kZst0kyDVzDzI7Z8nHcE0RqtgTk1E3uPXBUXn4o+gdOHZCo/9Q
         C5JOBwjHj5hchKTQYBPhKfSkxdysJRRaJZxiGuo39jfzcGRr0v2XuDFFqREKzPIMeYvg
         DT2SS5DZ40DL4LZbaTq9md32rJ2mu7OHXKizWrdxSwt+320OI/SGmF/JyVOq3OGPi+nl
         oe8g==
X-Forwarded-Encrypted: i=1; AL+hErEsu7dbJNNAQELXt7M0CHij3p/fptY5iac3lYfSz/5bFmBzL3iIwhPVv1/bpXK4rsd3UdXv82FgwvUk@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZlA9Mx5jVwDZaN5I15wherxKGQW7AVsgzxKxk49VvKTFlzBbf
	NH0T3Mm0HXhpKvHpGrGifvGlFdSqsP9Hir40od0pasfXmezyuGp/fy7vZRQ6oKk0qaHtRc+1ct3
	2AqqEESkRR+qKoNxiBxkGWFH76kurYQc=
X-Gm-Gg: AZFdTZfBWKakv48zcadjnJy04NPqYsQZ/fdd/xWUdjeSgKKC3jpZg4pefMBUSncJvDZ
	XnQgx2S54hfa9MAfPkUHKi11fUUfKulFi43rsw/0EjBO4hO7tcdrFgsBLlNDHGas6tGZ6x55dv1
	6QMXrZSLcbyeiSlSWGAuh0ztcaNGIavLIxZSoflbsKWL8GkhsMbdlST8PZQp4jw6kIWPGVzE0AF
	JoF4qYXG+HRPUHKgjZ2EClwwqkqWSdbid9/HxACbd4x1Ji1sz8xqAH4+MUFOeYxfIjXkmCnxzoD
	HgeQqZYT25WlEbt56LbpSRGDQxvMnjfz0NGy+7jhDND+A68n+CrvJAV6M2JDebFB6aMrmQF9Ry/
	CkWQyUwAG6IFw5SE5s092QuKUNFPsYGIMc+jWSqN/vMxg4cWVTFIIgI7SaeabyEOZL8T39RmgdW
	k0SlmLvj0H1QPpIDFNxTTWBUz8RBufvWgjfxWb
X-Received: by 2002:a05:690c:b82:b0:8b3:2e4f:6c06 with SMTP id
 00721157ae682-8b5204e6874mr37616707b3.47.1795457309817; Mon, 23 Nov 2026
 10:08:29 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com> <20261122120212.0dda7532@pumpkin>
In-Reply-To: <20261122120212.0dda7532@pumpkin>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:08:03 -0700
X-Gm-Features: Aa3M54pFgWYfRjmoVibaUGYDePfbu6x3lqh-lBTVnXaC_Y8BSI8GNkbK8nNeqyU
Message-ID: <CAJfuBxzcGz0Z36NNAWKoJi5KObKm3Y=Vb2gCQ6TFsoaQPjJsjA@mail.gmail.com>
Subject: Re: [PATCH 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
To: David Laight <david.laight.linux@gmail.com>
Cc: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 5:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 21 Nov 2026 15:49:18 -0700
> Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:
>
> > This series fixes a latent i386 section-alignment bug, by adding
> > explicit alignments into the BOUNDED_SECTION_* linker script macros.
> > The misalignment appears once __dyndbg_classes is split in 2, and the
> > 1st section has just 1 entry; the 2nd section implicitly gets ALIGN(4).
>
> Would everything work if all these sections got an ALIGN(8)?
> It would simplify everything and only cost a few bytes of memory
> that no one is really going to notice.
>

I tried that 1st, iirc the ORC_UNWIND table in particular
did not like it - the size and placement checks are quite strict,
and I didnt want to fiddle with changing the rules.



> (Apart from BTF which seems to be page aligned.)
>
> David
>
> >
> > 1. Refactor BOUNDED_SECTION_* (and HEADERED_SECTION_*) macros from
> >    vmlinux.lds.h into include/asm-generic/bounded_sections.lds.h for
> >    reuse.
> >
> > 2. Drop the unused HEADERED_SECTION* macros from bounded_sections.lds.h=
.
> >
> > 3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
> >    variants for non-8-byte tables like ORC_UNWIND_TABLE,
> >    EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing an i386
> >    NULL deref in dynamic_debug_init() caused by 28-byte
> >    __dyndbg_classes misaligning the following __dyndbg section.
> >
> > 4. Remove now-redundant outer `. =3D ALIGN(8);` directives preceding
> >    BOUNDED_SECTION* uses in vmlinux.lds.h.
> >
> > 5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for
> >    vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) fo=
r
> >    scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules
> >    under CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy.
> >
> > 6. fix checkpatch to skip macro-rules checks on any *.lds.h, in 3
> >    places where only vmlinux.lds.h is currently skipped.
> >
> > NB: most of this patchset was split out of larger series fixing
> > dyndbg-classmaps.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > Jim Cromie (6):
> >       vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sec=
tions.lds.h
> >       vmlinux.lds.h: drop unused HEADERED_SECTION* macros
> >       vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
> >       vmlinux.lds.h: remove redundant ALIGN(8) directives
> >       dyndbg.lds.S: fix lost dyndbg sections in modules
> >       checkpatch.pl: generalize linker script macro exceptions
> >
> >  MAINTAINERS                                |  1 +
> >  include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
> >  include/asm-generic/dyndbg.lds.h           | 18 ++++++++
> >  include/asm-generic/vmlinux.lds.h          | 68 ++++++----------------=
--------
> >  scripts/checkpatch.pl                      |  6 +--
> >  scripts/module.lds.S                       |  2 +
> >  6 files changed, 69 insertions(+), 58 deletions(-)
> > ---
> > base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> > change-id: 20261121-vmlinux-lds-b59410146885
> >
> > Best regards,
>
