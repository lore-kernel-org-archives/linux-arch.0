Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752951815B
	for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701989; cv=none; b=mSGLXHR9HJqVi57+tgPRpsAgxmuUol4t7B2C+M6PfUtaDP9G7jqhDG6YUIUgX9Yxr2izzKe4awOoYL6qXvrclZy6aZFH5icnMLzyKyEm4JIj+U6re7ZJUoJpUE1fstT8/SnV9rGFVJWQ09x/NjiW+MF7nieysiucS6BnX6rBu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701989; c=relaxed/simple;
	bh=0f067K+RzEsqLBw6ti0AkTDYaRnTOhuq/0OSTNIAKfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB3UiTruJMQhqYKXQ75Wl6t3t8VYAkFkF8AcFcSzEsl82srdfO1P0P1qo2VvDBvLbKK09hH1wIMPPGucJ9E7753xykoPwTk6d/ZAq5N5LYA/Vkfc09szYynOVWuzGrT5wz53xtAHSp6dnHWtimYDsUDuqci4FLgDoFyiSXBGdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fiVs1//F; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fiVs1//F"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e12db20e65so7197225ad.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701987; x=1791306787;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/7tiqcVhZyeYDtLzp7aYDX9vQnP6PShEIiiRyaua0Q=;
        b=UHAEyiQNsfKPat9vyxckxMVKfBoFRSvcrQqAvZIOvBVLWkB14btq+W24hBUGuk+eQe
         7n2EqrbFIZidRX8n6meJH+iLftnU2vz2UrK8Kjkkor9KxLZIGIjfgPc/mUxiHl9ejlSB
         qQVOqU/FEUCLqDsRvFiDThmiBQ/IIGrI3MIshr3VC3igNGA8szxLi6RfblKvhm5ehjMS
         U94QlQat6RuVBupLcA/6femM5kcrm0vwuKG9RY3kA5v/zcQLXDyrGhD3vUlx6ywcYEXN
         fpN6zj5Tgck5/sZ5BLMtdFAVEKV0Gy2ZZ7ti13x1JFmpb6n/e99Xn1vhpFC5ufVGPdyr
         Kymw==
X-Forwarded-Encrypted: i=1; AKwUvBxLDjM4uzCAD8ynarzOAKUISpff1fUMLFkkXkUolwcRSq8fEToiLB8nBZ5G597iqSw0aC4AROJ7/h4b@vger.kernel.org
X-Gm-Message-State: AFq9FYJCxAEfQK0FykcDeeIuAMUJ1+sv4KNuCZIYNms/m/0dGeDmKCC9
	xrTDeihqBIz1Cs/tIeiZGhwd82Mt7P0XyUJo3wwKa8tGPI2AXzhnS7ApaMBeyLwxk75ZeyMf2Pk
	U9d5QZm1P7nXdUnDLPH+QGSN4Xs7rtTZTEWRN5gHtEm27Afp2fx+GLmjJX7Wh8Hh1H9Jf0VH52h
	PKncWh68p87wSDzRi7WGCkw7PhX994glncp38rmRcNaxH/9pFrzRAJ3vHttrhAO2L9Spj36+Iam
	bUWfF3ehR0O6Q==
X-Gm-Gg: AYBFou0d/czbLspHf6f4M0i2Rax2iVj6RyyZhbPhF7tcun9HemKOUcNJicn54XL4HZA
	NR5olYvGVoxrYpMoVdcFgAnQoeS51jAHq1VVrZy6ds7UMWsO7kmTyKrlZ1n2yWQnrH0SGycWl/l
	B77ncCe18tyEFAvcAyCiNq99ZKVJE7hA+xG5oXp/9Nps2Di6Az4BMrnEBLHZHwvdZEi9nC+4Dfy
	+tLH1vJDEGfDA26QAuX1LrIyrmQiDsjoljoxEXewPvnO4koO8VttvHjvlSdIjsBK+xXp5zp7fJx
	t3fSPVilvQEIEVGi3PXkEZf5F1d/U2tty6UIS+llyKEau9xn7uGKce1RYXenrbmY8HNeed3wYYx
	xObpK6JqfsY4+EDf1lbLiY44cV8kRflvrPhpg+zAc9sOpCOb3LbwZe84kg3aXpiDMzj/snJHKHk
	AeJX2HymMbPFjDCtV383EajV8H619Cj4whODk=
X-Received: by 2002:a17:902:e741:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2dfa4d85affmr93043695ad.72.1790701987222;
        Tue, 29 Sep 2026 10:13:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7d2d966bfsm77480a12.7.2026.09.29.10.13.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:13:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso6615813eec.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790701985; x=1791306785; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/7tiqcVhZyeYDtLzp7aYDX9vQnP6PShEIiiRyaua0Q=;
        b=fiVs1//FnnSxSGh5OszmOqEbxJ9gaccg84G6yRo6c/IeXFnJFlcQ0sHPy+xYJfBklm
         RBp0pQFOrK0SuCleM4G/4ZMh8Ki89jWajpE6qDZH5L/Mb3jR3Ei8xYYDtGDSdo60mFC3
         n4bziyL7tT0NCZDQiIX5zRY3wRzpw70uOlT98=
X-Forwarded-Encrypted: i=1; AKwUvBwpHLnbO1bz/1N6d8YEmbgnbJRvNouIijiD4BJqiica3ZKZ8lS2Rpsko84jCwGzr3Dn8dJLi/mtcoed@vger.kernel.org
X-Received: by 2002:a05:7301:4908:b0:348:201a:6c8b with SMTP id 5a478bee46e88-348201a6ef2mr6324513eec.38.1790701982798;
        Tue, 29 Sep 2026 10:13:02 -0700 (PDT)
X-Received: by 2002:a05:7301:4908:b0:348:201a:6c8b with SMTP id
 5a478bee46e88-348201a6ef2mr6324466eec.38.1790701981900; Tue, 29 Sep 2026
 10:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-3-zack.rusin@broadcom.com> <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
In-Reply-To: <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 29 Sep 2026 13:12:45 -0400
X-Gm-Features: AclHuK9CQF2HwjTfB3IkA5Iz-7VKmkeLlHNlajXqAX5pb_ttJ9z-UY2UurMeehQ
Message-ID: <CABQX2QP0+Jr6gG0nZkDggvyGWCSHMNVKPPavZTYBqH+wg7rdMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86
 encrypted guests
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>, 
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c07988065ca24b98"

--000000000000c07988065ca24b98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Tue, Sep 29, 2026 at 12:02:51AM -0400, Zack Rusin wrote:
> > @@ -1022,11 +1024,13 @@
> >   * Note: We use a separate section so that only this section gets
> >   * decrypted to avoid exposing more than we wish.
> >   */
> > -#ifdef CONFIG_AMD_MEM_ENCRYPT
> > +#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
> >  #define PERCPU_DECRYPTED_SECTION                                     \
> >       . =3D ALIGN(PAGE_SIZE);                                          =
 \
> > +     __start_percpu_decrypted =3D .;                                  =
 \
> >       *(.data..percpu..decrypted)                                     \
> > -     . =3D ALIGN(PAGE_SIZE);
> > +     . =3D ALIGN(PAGE_SIZE);                                          =
 \
> > +     __end_percpu_decrypted =3D .;
> >  #else
> >  #define PERCPU_DECRYPTED_SECTION
> >  #endif
>
> So you're page aligning something that will get different protection and
> will thus shatter large pages?
>
> That is somewhat uncool. We like large pages, large pages are good.

I'm a huge large pages fan too. I have a poster in my office and
everything... And I never do things that are uncool. I have a wwcdd
(what would cool dude do) bracelet and I look at it every time I make
a decision, which given that I'm old gets on my wife's nerves a lot.
That is to say I'm handsome and innocent.

The alignment isn't new. It has been there since ac26963a1175
("percpu: Introduce DEFINE_PER_CPU_DECRYPTED") under AMD_MEM_ENCRYPT,
which common distro kernels enable. This patch extends it to TDX-only
builds and adds the boundary symbols. On bare metal and in ordinary
guests nothing changes protection, so no large pages are split.

In confidential guests, yes, converting each CPU's page splits the
direct map around it. The alignment doesn't cause that: a large
mapping can't be part private and part shared, so a converted page
can't stay inside one. The alignment only keeps unrelated per-CPU data
out of the shared page. Because that page sits in every CPU's per-CPU
unit, each 2M mapping that holds one of them becomes 4K mappings,
including the ordinary per-CPU data around it. In the layouts we've
tested that's most of the first per-CPU chunk.

SMP KVM SEV guests already pay this today. sev_map_percpu_data()
converts the same pages for every possible CPU, at the same
granularity. What v2 adds is TDX guests and guests on other
hypervisors.

Where you're right is that v2 converts in every encrypted guest apart
from Hyper-V vTOM, even when nothing uses the pages. VMware only needs
them when the steal clock is enabled.

If this is a deal breaker for you for v3 I could convert only when the
hypervisor's platform setup says it will use them: VMware when the
steal clock is available, KVM when async page faults, steal time or PV
EOI are enabled. That decision would be made before the conversion
(for KVM that means making it in kvm_init_platform() instead of
kvm_guest_init()), so there's still no readiness state, and other
confidential guests don't lose large pages to this.

If you'd also like to keep large pages while the steal clock is in
use, the alternative is to move these buffers out of the per-CPU area
into one tightly packed allocation. That concentrates the splits in
that one allocation, so the rest of the per-CPU area keeps its large
pages. Kiryl preferred the per-CPU section when we discussed v1, so
I'd like to hear from both of you before going that way. fwiw, I'd
vastly prefer to first fix the steal-time bug for VMware before trying
to do this though (whether it's with this series or a smaller
VMware-only fix). x86 kernel team is notoriously opinionated, which
isn't a bad thing, but it means that a rewrite of core x86 bits like
that will take a long time and it's starting to feel a little like I
stepped into something and you're all behind blast doors yelling "cut
all the wires you coward!!!" and I'm just confused going "I just came
here to get some blueberries".

z

--000000000000c07988065ca24b98
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIM95
Y+wYvsgw8fhQBqM5K0hnr0Cphy3qyWfbqheI4Lz8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkyOTE3MTMwNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIHFxQP4Tvc50lerEY6120QjWrJq01GxcvZT8Gol
DIx7OPSXRhVBA8eQipUYVXEQsE48YtMM4qbaVdiC7g24BDqNx6HsHIIg1fERa9PnLddn+dUeUtFE
JZhzE5TT0VtW5Diu2W1V3WHT3+S0bhzM+DlG7b20RB7aX4WbgFM62l6GRA1Ur1KU8PGpudcmHfvz
FuO6rK+ShU1eSjTaJqc9GM5mQrEYShBKwLq2Qyozf3dlTwG9XI1dUwco/0gcmS6uGXXsaa84Uk8N
ktR4iqf02EI5sE5N4xbkOO17GIHiXO6oglfuK7G7stf8LZYa46UGn/50U06ot3I1Up7s6HEU7og=
--000000000000c07988065ca24b98--
