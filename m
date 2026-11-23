Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457748;
	b=VbRKaK2t+ApxSoDBlgT3BMscpZmKvv3er/ysQSn9ORtjqMPhLfjT9CGdm21GoT/pzimJ
	 3lhV5213BMufUjBQh9B0Mhb6UmmRrQqurCCqncrZukjd/0vW5LxZTLz5jxDEesr95b1np
	 z95wCiY2cTpGQU8otQ1FjHHFwi5imy3jJ4aOUEijwTmuwOmqJSD6wVdTCDWCery0OmXQK
	 keaKiwZN5wD7gxUsEDEoon91y3OuDIO8Pm+mWxUUuoVPHF1In+DLlqJ9mTmsG1FL9PcRJ
	 F9ywqCyPY1AFJtbtULIuRQ8qzDGgXG0C3DKoZhMQtjAc/RZuhydfhqxpJFx8qW7H4hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
	b=bpiKo6MfPc+vOqSgFnZWanrek9MxVnEzwgRztbuyNJBcm+6JrM/wb38CJPggw6xAUdRW
	 uBkd8qjpgwir02v5hw6aRp//Lkyng0kwFi3BJSlLj8oqo5L/1AxSBfw0OZZLbcIMLtp9p
	 KLMzsCEqbhTupc5xJnVxYSJWFhyXxqivHpAOELXrqB9WRAQAsuQRt+yo3E+etPH2fPjKj
	 VVRFGx297Jyl/n83INYl4o7UzyztMXCHEIxdQnL8Ymz4MG3Lb+9BeeGgB18ZDo4y/TqM0
	 efFZyUTjoiMzPk71h/QDQOG1WyTYTxr0IGrWpe3d/nh4DS7TozJpO9M3zsF2hsdQOrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAvQ0XWo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA56606A31F
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 18:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA56606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAvQ0XWo
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b10d24345dso32479387b3.3
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 10:15:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457747; cv=none;
        d=google.com; s=arc-20260327;
        b=O+rwEcq6AGWfjLFYOLfrsd53hQgTVHhTAY9grMhKDroHWXwbYs5RdcW6Sx4r2p5cB6
         iv45xQhQahzvQB6wLadHWqZvlf7JO4aJWfnJiCPrCaYFyohNe+sJKnaoql+x0DQzh8Q1
         zhwm3n/L/AI5CIDe/8GgFW6ZgZ7jnFE8TWdKdYiUouRkF/C7R9kz7rZXFMgIWyIgO46i
         E9TtdRY6zgSstZl4WO6KSNX4glPRwdYuH5rBlZEyvkT4tWO2At0TjncnM2I1MnKqmoEv
         dh8sbJmlOmP/zNrRYafgMMj8/uB/NkecxAOLupf0BkQSh43/FMvhnml/t3SBYXdmuHEO
         6snA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        fh=1HL1nPuzAvpXR0BR3k1C3FbZzWFlZ+fYbRrT3lTT2Og=;
        b=dw40sDoZAz/mn3ZTIpJXZPOEpCZ2IWNBOxB8wami6IdvMeQgrFwws4jvbNMsUcAenZ
         CTGUxOlK51OpCQn+FUh0j7mz7kiQITYLFwC8U/Uvdna9xnm7zJBbAL72rjifY51/EDmG
         G4Ypulqsvio6TwCWpLgiAWCaekX3GtU5zLlrBmg4gMwW0eZAv3A6p0yhRaEmqQtQacAI
         j5IXC88JVqwo+PQuyAFS9iu3stbN9C8hyj5lWuCUr+m5zQzedGHDU1wHC011XPzXsZnG
         C01G20Z5Y+ouJyw0fF3RnZsEdthv/vO3N78mSCZyyvwGj3CQM8O06RyMmm77X6uOT2lR
         dHNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457747; x=1796062547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        b=QAvQ0XWo0tcExbNOFzJESQZNbHYBLhpD32HKNvni4HEhtOqZEL5GCt+suncaWlBUiO
         FZtlYyNOqn9GHma1eRgPcYdd0NoljW9zR1Rc3Q6xInR6kvJqQNoPNRRrvYNNLbRwErFT
         C5Xb2wcOQSFScBdI2yQWvbeXEHGwhJMNY699xitU3dlCIUs7wu1tGJEo+Yar4GHnXN0U
         wLc//ydgb6yiwdJhE/yc8kHeO5YrOdlZnMqS9IH1XC7S+sN200e2Re8+RSKxq2UlZI6C
         C4TtJme+P2FM5uP3jC74YS73mzHG34FPYNDILJ0QBlMq6nWOwr9hYQ0pZ6Zj3bui1vtz
         H+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457747; x=1796062547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        b=uAqTcxeOz1dhnfYjFpTj4IEn+P4kgpagxj1zAWy5fLKsC+Ix667/YzbjqGujW+U8yT
         NpKvVmGp8RUFgxRoUQgttamzd/hzqateFX0Ga4TVhnMTQgiqk2+UDsDvQVsswBWC/bc0
         yAkI3Jhpa91BYKA5EQJsV9tou62xgeLTs2AFy/ieYlm3cvFjweFQOkbnPC2SPFA8n1xG
         41FGMGTPipMVmh/7CbGcAk/C0QkXDXGqgAXNlOaBFi7DbPwcEWBJvVjUL0iec1s0hQwF
         g/32TpGKG9VaMnphUo9LPQ/TCvy251F+MowTrfK5W9vMo63S1YWMlB3dccPInIIBJ5Aa
         lddw==
X-Forwarded-Encrypted: i=1; AL+hErGdVK0Y+krjcGa4zvcTVj3IZwiwws57LtFMqbfjMJEqmoQkXsp3fHHIEcx6ZA9sEFT20s2u+16qT+5P@vger.kernel.org
X-Gm-Message-State: APuU4Z8KzWfLKadAuJd6D/KFHjlzSaY/1gvGDtZoKXN8wiUZL8Btdv9/
	nwRMlEJV1bc6Re7lLDiXfh6sh/twNnJEvsmvvmlFBVyt4j9AOX4I+0ItKLpgajFypBuPqgv9k68
	lgFd/3C8i/Y7467cWB81OCdVu380FVM0=
X-Gm-Gg: AZFdTZfg0dqNDC2cW/Wuxi+CFDRq/SqqFqxfz3EDOCdvFgdbh2lakbjw3P4ton87tbq
	3bnjgb6Tzq6RnuL7oZql57pXnKD517RcTUdbukP79s1v1UwkRzf+845xlXGwQDpgVcpE8K4jH0n
	NImRf1XwxqiKnvqB2YaWhMwCMH2A82wWFrsCwwoT1/f1nXADJPaDn9HzCN6W2Bfb4Nw51cst+0J
	uZkcRbgmm6Z01ASfTvp1ZKYiWn9FEtv4WX8//lW7iYHHqN/muD6yGoPRbTPL2hzz2aUPKJMwThH
	kDOZGrcsQbsdRRzKP/d+l2VblH20XhfJGGzOk5nVm/qMcUW7jzAkaHJsBfCQqnJyUkqKqAf8avR
	rdU8zNUv4n1GfMRONAU85FFBxp6JoIw2ocfC0qhKDQkS1+8P2RxJSMoyGOJzRanRhyTMCW3gesT
	iZjo9zb1hYV5uSQjM=
X-Received: by 2002:a05:690c:797:b0:8ae:87e7:9ab8 with SMTP id
 00721157ae682-8b5205437abmr48277337b3.67.1795457746844; Mon, 23 Nov 2026
 10:15:46 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
 <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com> <a6fdcd6d4bce5ace3b4e34d1393f5cfe58e17c0d.camel@perches.com>
In-Reply-To: <a6fdcd6d4bce5ace3b4e34d1393f5cfe58e17c0d.camel@perches.com>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:15:20 -0700
X-Gm-Features: Aa3M54oFOAYf6UTkbI4OQkVdZIf4cCrnHVvp22FVwZTxOnodSxK6PbkkLux5L8g
Message-ID: <CAJfuBxxJMwrBKTrwC8RoLKRs7uBBPrgfWmPom_r49JmnOPvMvQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] checkpatch.pl: generalize linker script macro exceptions
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 7:27=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Sat, 2026-11-21 at 15:49 -0700, Jim Cromie via B4 Relay wrote:
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > checkpatch skips macro-rule checks in linker scripts; 3 of them
> > explicitly check for vmlinux.lds.h, and 1 (the 1st) skips on any
> > *.lds.h.  Generalize the 3 to match the 1st, including the escapes on
> > the dots, so they're literal checks for '.'
>
> Please remember to email the checkpatch maintainer too.

ack.
I missed that b4 prep -c didnt add you.

>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index b8b64f720191..318e1f2577fd 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6016,7 +6016,7 @@ sub process {
> >  # Usually multi-statement macros should be enclosed in a do {} while
> >  # (0) loop.  Grab the first statement and ensure its the whole macro
> >  # if its not enclosed in a known good container
> > -             if ($realfile !~ m@/vmlinux.lds.h$@ &&
> > +             if ($realfile !~ m@/\.lds\.h$@ &&
>
> Probably better to have something like
> my $is_linker_file =3D '\.lds\.h$';
> or maybe
> my $is_linker_file =3D '\Q.lds.h\E$';
>
> and use that everywhere

yup.

>
> > @@ -6175,7 +6175,7 @@ sub process {
> >
> >  # check for line continuations outside of #defines, preprocessor #, an=
d asm
> >
> > -             } elsif ($realfile =3D~ m@/vmlinux.lds.h$@) {
> > +             } elsif ($realfile =3D~ m@/\.lds\.h$@) {
>
> >                   $line =3D~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
> >                   #print "REAL: $realfile\nln: $line\nkeys:", sort keys=
 %maybe_linker_symbol;
> >               } else {
> > @@ -6192,7 +6192,7 @@ sub process {
> >  # single-statement macros do not need to be enclosed in do while (0) l=
oop,
> >  # macro should not end with a semicolon
> >               if ($perl_version_ok &&
> > -                 $realfile !~ m@/vmlinux.lds.h$@ &&
> > +                 $realfile !~ m@/\.lds\.h$@ &&
> >                   $line =3D~ /^.\s*\#\s*define\s+$Ident(\()?/) {
> >                       my $ln =3D $linenr;
> >                       my $cnt =3D $realcnt;
