Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC24155C87
	for <linux-arch@vger.kernel.org>; Sat, 11 Apr 2026 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866390; cv=pass; b=U+WRAJgocM962Iluzplg+23KM3MlwIe6t5b6EToh/0VbOCqZMd2a4gXAlFT6qjFE0uf0YGVAKLdgiwnEHRAs5MBFBo3Y8p+gPyrakXL2J7dHi82vRBbRGl8bob2OO3vmlhidFTRPNDYbVIYmEIx2LdHKhTruDPIX+KN/Tjv2J10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866390; c=relaxed/simple;
	bh=5g2ngVaT7KNNrtzCpaG3e7jivMMatnwCpscSMG0DHss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhTi6hJKiji5hPONT0iO9vNVxHu/NG2N/WqRKAX7mv9BR2O88fvRlX3vna0L0pxXRGpJh1sc8mWrTeKSsjv44/2T2YgwMcHPwd+jhQB3G00EU+R6Q5qLP54dLmnnjFmzYnZQZRl8bX2ZBrOnttfpOG2N/6JRCD9S7d6l+fUV7Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+JhW4Hw; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+JhW4Hw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaed195901so12713425ad.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Apr 2026 17:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775866389; cv=none;
        d=google.com; s=arc-20240605;
        b=WAqUXAITrjMSybaP9I2NgeFtGP2B3oq343/EWuQHVqu9/xCZbu8kAGmHhnV/m/M/2d
         FKW3RPvbCE/PmhgLajM6Rx7nuU++DWllKwMGlfeUuslIggdosFqTEzXWvOVDOzqZlJJh
         2A4beO/NnvguGdjok7P5ieUbr3glmS/aiSUCdT601UIPAHYQjdmul8sn1F7Isg7o/3uI
         w2mT1XATVik8Xb+LBVpSsMq/kflvai9VCiINtWwcyvcU6n+4wJk7kIqnwemTgWI7lCJ9
         xTv2xEtNilIZ9rRddXH6uFcDnYlI/+S8QiKKf5gAGwfGU5kGL+FAEo97qybUkGDuAlgw
         FORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        fh=UxpD8vTzTCtYGYOZTngKAG8maYEcUoOAB2S856bKo9s=;
        b=AKFY6vvvt+55hjhvPtRrwDkBCm3tx79uwHe9208C/eaOX85VvWK6fddBBJvrSmambu
         p8W8KOJfbinkfC9vO9nMtTtz+OaD35quwIO53Kk8UT/9VrU5HPitPdE+8ZTaxVSXLKV3
         B1TKQqb+py6VznTWET+DD88eAfvDZWzB0CBOlfemTHdI+mBrQpzgO4WXhn4EHb7EBr4A
         kKEe5WV99RCt9XuM1izzdBU2tU4tLgldz8zFVXBkFiP9RrsPaM0PANbzaVkNQnNvcQtf
         1WFg0+0i75hnkVLEQrqZXChsvAfz1aCnlV7Qua3tionBK4w2XurMcHXb4jscAue0b1hQ
         DT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866389; x=1776471189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        b=J+JhW4HwX0mufgwsTMijVlFYIIiyZ07BSyoxdiDVE7QrEfVljtV7GPmy2srYGd6xLy
         nWWAND/XNRO3QpQGS5jQcmXldhmACvjXkn4VdUN3k8hNVJod3zy0gKXo0X5ovRz3nbx7
         YqMy3pewclLgdLJJzbUS0Vz4Bu80JAwi5LRRncaBKNmosTZXNxOqFbz0d49283QPHNkO
         ojE3V/x5BMqGvIs7y9/dFUAFJpgBGt4iljm7VNKMDjCXH4HHxGSGH+7yZAabLpy3SJ08
         YQxTSjEYucB5lD7OYoo+2oCSyZZ3p6f6KJeO4+lyxdsctHI8XEfvDJxg/lx/GqV3ySC3
         7dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866389; x=1776471189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        b=Fl9r7pQzt5lAJI/zR2mRkpKhXZKhwUIXTy7OJUUk5kQyhWBdKDSxj/BRldPN87EeJy
         JNk+ifZE3GIBkmIn9rx+FF2uEgpTyUhi3NO+RrGgd5QU80LOvw3ODwGN1NyqsRqeoN/G
         NOJuK7aC7qoQyL2A3xdEd1F4ELRRfWZ5daTqcabJb+n/J+brvlNNIWEFvTgYurlbN4GB
         QSnE5J1nZyyA+gJwHUIw48Q1nvBlpsTUltn/Qdd7Ox0D21c4rCjZZKi6RzjLB3IOdouK
         qBCNh6s1XJ8RY0JA+Hh5zEb7PPutX8ne6MW1zoIz5iUDL4uNUaJS5rsehqCjy3EiqDcH
         1khA==
X-Forwarded-Encrypted: i=1; AJvYcCWjV5KrOT4UgtxJBwdEFzAlI5c+2l3DD6gWpf+7znZ98lV1PpDcpxgVyIaPN8/7fQjllI7LIlUyW4cz@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHwneI9nudWnSa2dxb8F32TXg7VGLiDthKjTzR0oAcGH7Q5E1
	kisU79LYuIaB3nx2U42S3LkUVOflLluVlRvJvj4YyAk+OX8GcwbH+RVO8w1tjeUDKA53X3zVBGo
	ctOvkbFo9J9OR35SLqg43bqJ7k2PVXQgy29673u35QQ==
X-Gm-Gg: AeBDies6skVXaWu7sbRT3Yv0po8o3MDCVpf1C5TzibKdjmv8mdzkuBhgqWOverkhSzD
	tvMu+P8rQ8PbHNXk9xojjUAmRIjyJV7Ww0gVTwobuN7rrKNO03+legXOqj8VsgcXz+OY79uhN+v
	pmJMPMfpDy9C+ZBPSWZFFuFH7tq+9xpN1GHsgCXBX0F44cSrCigAqfgRkdnUqaxaNa0yLDRkRXn
	5IRMyjj5fM1ihvSzIrIJyiDVj7XdSvg4yLohvELGMbtvt2/fHjCCnriqDq+jLTys1KvVnQxmmTe
	eqRU94fj0jJ1xhDxpw==
X-Received: by 2002:a17:902:f9cb:b0:2ae:6457:3099 with SMTP id
 d9443c01a7336-2b2d5a307f5mr39168585ad.26.1775866388658; Fri, 10 Apr 2026
 17:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com> <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
 <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
In-Reply-To: <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Sat, 11 Apr 2026 08:12:32 +0800
X-Gm-Features: AQROBzBXpVj5q_p8EOJEIpEPhw6-uu_-Cq0WNPK494rLa4BGus9wqYsxF3KY2Jo
Message-ID: <CAMe9rOoOAmDbgsq=8fNKqR1WzahD6oAB5qHfscrivCQdSWdg4g@mail.gmail.com>
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, GNU C Library <libc-alpha@sourceware.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 4:35=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> On Fri, Apr 10, 2026 at 03:40:30PM +0800, H.J. Lu wrote:
> > On Fri, Apr 10, 2026 at 3:28=E2=80=AFPM Florian Weimer <fweimer@redhat.=
com> wrote:
> > >
> > > * H. J. Lu:
> > >
> > > > To enable THP segment load, ld.so opens and reads 2 files under
> > > > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > > > /sys and is expensive.   Is it possible to put such info in vDSO?
> > >
> > > Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary
> >
> > Does it cover
> >
> > [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pm=
d_size
> > 2097152
> > [hjl@gnu-tgl-3 linux]$
> >
> > > vector a while back, but I don't know the status of that.
>
> Status: nothing happened.
>
> > How can we get
> >
> > [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
> > always [madvise] never
> > [hjl@gnu-tgl-3 linux]$
>
> This is not covered, see the link:
> https://lore.kernel.org/lkml/ecb049aa-bcac-45c7-bbb1-4612d094935a@p183/
>
> PAGE_SHIFT_MASK should be folded into system call probably.

We need a fast way to check THP status for THP segment load.
A system call to return /sys/kernel/mm/transparent_hugepage/enabled
and /sys/kernel/mm/transparent_hugepage/hpage_pmd_size should
work.

--=20
H.J.
