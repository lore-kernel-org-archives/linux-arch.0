Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793060149;
	b=3FoWuSpJeDt59mjIxCSU0X1/ApZbXChekP6QE8bJ/uwzsd1SOIyDp2mdhfrDkeMsZ1cP
	 TGMG20CmYyHdp6cvnEw6wt47TEtsbtoyNCfsZVWM+AbFPXq1TlOUDqRAZOiGuNnBRdkbP
	 3I7XdB89qFWSXQV53ZAnCKX9XrGPk2F0RURnUcXNfIeG7qndd4rMiGGg2xDm3zsCUtuvl
	 2xTyjbOKIJcpvX9F/dxLaqLp7eyPF8vO+cE1dUjbYkD5NV6xQP0mtAVBShudvs1sRb8ZL
	 VnskAfNKEymmvdvkFnvCPP0fIF7Y1y6CeDm+UTMzeyg1vLX+0lfjaLCYSl2s31yRC7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
	b=3CnSZu08BeoZ5HcIZ1zVQoVAKRM8ymIwho3FxBkKKd8Mg+BGkwK73O9vKHa5GS51KBN3
	 w4Q9kfbyF99vIbeTtukQk3Sxuft5LGd5AD9q1eQsCZbj1b9vOS7qXUME6nTyQMPipBCE+
	 wI2q6oOjGP29K6BcSobCq5YgHgUM9z6RKUeL0G531yc3i8MwIkoS6ag53pFIBEku58dEO
	 atjfX2sbP/u0jm382g5Hw5iH0CwcHsKt8CeNROEtYGRshImhD3EkHw3I/VGUUu5HeVqIW
	 L0UpN8GLIW9jJoRlWWnVAzSh72rM2PRg5z5ia2IMzA0tJbweLECzVZPHJIl0/DG/xyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ;
	arc=fail smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8ED606A329
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8ED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8aea7b7ca0cso29153367b3.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 17:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060148; cv=none;
        d=google.com; s=arc-20260327;
        b=S8iabLyOPBhN+q7etgmMH+1+UYb/DZxq1G1O4Yk+Mr7mbySP4VrStCUOHvxfx2MjK9
         Fb1aBw96aL3j8Lmneai5WQk/5TLYdND08kWzMP2A2VV+IfMRpeEJ4hOVNZU6qIyUnEZ8
         Aih/NGIIW2ORxQGapivX8/xgu1SJeIHcbRVkWIWgBeeVlobdXjs0v3wYyHGGOKUrlF/R
         P46wmxQMPjRcsPJ6KEZNNtI9tga+I9S94AQBArhSBXbLaH+yysIDAyjsI6L2tyZugaWs
         57Fkp+bETmD/U6vTCxTONAwTg+UUZhjBWwNrGUun+b0z6JWgBNCtp7xXJeMPE0zU5y8f
         zFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        fh=rNJ2gfAG8xzOplekBNyLHhCO6c55oFoyA6vQZ8dMLzo=;
        b=ABwPF16Ov7oDd81VXGW97Pu1r8bwEwrhhgCLtoeJnzZEy+UPp/rIhSijAdDLKnckZj
         3dmMoGizRtSooiGUGUu3iOgl4pExa+dHSfbx3eIkecD9rF9HoOBVnawUDE/p/gETVYy+
         9KTHaLSzOB4Mx0gZ5wBKDcLudlssMlTsldA3fjS4gNH/m8l2xTDcooGaamsr//OHxDn3
         hyIStzHSmLOthiLACngWVutzQqCiCEWuo71TUuSq1F0987WvCDUpxKwDYDxDdsR9jU0d
         ZhZAUzhN5lGgUwcgKDshb78okkMzOSlcdxGAlmnLeowrNO135xA4hzv88ixZTAY7ZjGA
         q+hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060148; x=1793664948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=s0Wfg3DQSfdPBtgTrPJ7hEq4HUweU0fxNhhrERYXULKUVGjvojByBZj8KKVt7nRxU+
         qfuMSheIJo5HVMHmH35pJ0m4FosgwDQvoFqO6hWdyPRkiWPWjpgGD4+44lYarYwcj4p9
         lwGrCp9TiIJ7Y9Q7o3VLX5IDHtJph2ZfYWK9hb7nwFZcN/EGzSOwKwJdiqW4e4tKM19a
         TwcHswoqbtz3QUq2JqUArNS2ontBIM0U5Az1Xxt/qvNOY6jlotL5RVH54V4eQYaO9/UJ
         cfXBJNeZLYP/7FfHZRk1FnPXiW2XAqkAAz+W61A369XeoogwEs/6FcBTuT08s5U96hTP
         UsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060148; x=1793664948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=cZaThUaIBeuiXpPjp8Yl4VW7pMQyQxgre9lxmYnMnq2SsCGrsBNZSZFN/jaKHWOrTx
         yu+KP9jFto68RVVrTT4WmhWYMFmqtnGujadggj+1KWhFDhyiuEOdI0Y9h0TY8TCxt0Nz
         lWI13a4tOC6QS1yNkmEvcIUK7sEsQq1pp8fgUh2Ip1/71eMMoqIuQvd51XMdyE9b0OSx
         qn9yvBlxWo6vjL0znWPjozqi+dA/cpWHlTkyGL/YCGum0TjBa1wQYQCw4vNGDwgsZoYs
         3Fd6HT1Kjh0Dn2b5DceZXArGBhgzUvRrk1L3zpA1MrpKPaPO5klQcx1GdFS4KSvE6c8T
         jzCw==
X-Forwarded-Encrypted: i=1; AKwUvBzl7o5ioVz5fYFY/REkTIMs3iC4LYkY2IatNsB4liEStAdz6QPjKTaa9g12C5c8Z/TxjY9IoLk8qSwm@vger.kernel.org
X-Gm-Message-State: AFq9FYIkiJmNDLGzGbDWDQ6RQld414RKknygbOxmYMZ52oSFa71PIGlQ
	8mpRt0UMAGnLFyNQEV4dauQwpJFNXeAZWA+oUQQrdvZ/kWqzl2cV1Nzmqaq6+7ymCQzZpNVApMT
	VckWoUBJt7x4tWF+ibkF6scbol31mVCI=
X-Gm-Gg: AYBFou0GXuerSLUJY9qF6KysDTHC9QOc0W6a22HSd6+UMZ4ctreiUoz9fpFfGxQxwO7
	4PKZA7h8GTnQxAr6p7Xftplgceav+9+dHtxQBbB+/uXAs1v0mX+VuoxGBpr1kvtXUOslIDTtRQa
	ZrRoDjqts21nIMhnwJLwYeqtbWn/97VOZMTWLWvA/okrSvgTGUG/2jH++KcXiTMW5kKzpxPpp2X
	Ol0nkmRsUWls2M9FpsXv/scRRWp0llU93G2Fx6hvx+QBw8LFKa7oz/nMG1We2Fgehn9CADx485M
	QptJoNQhknGri3yWPgFHIYQkqdXQiOM233D399AcU9eDYgrg2h0j1hoPNPRmECDZmCtPlNlcevH
	WfV2nZyCYZnJ71+TYFSjZDIEhOaRFW4el3SHSvWwPoaxxmLfD1okJXkm3Ms4vfINBDVoaMu/KEf
	kzARjbWn/mU0ugTfk=
X-Received: by 2002:a05:690e:150f:b0:679:c803:98d1 with SMTP id
 956f58d0204a3-67a45496c6cmr4080476d50.152.1793060148265; Mon, 26 Oct 2026
 17:15:48 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com> <as4W9hToBqAvbzJ-@pathway.suse.cz>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:15:21 -0600
X-Gm-Features: AclHuK9LH_u23sCYiYKMz0I-9md-phfbwb6JA9KZbhXjHlVRGYmTapsg8H2JBYc
Message-ID: <CAJfuBxw-cq3AYXKZ07Y3732tDM-NYxt+rs8Fz6S=P7+1TF5WNA@mail.gmail.com>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
	Philipp Hahn <phahn-oss@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:33=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >
> > pr_fmt can be used to add a common prefix to any output from a module:
> >       #define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >
> > But adding additional arguments breaks dynamic debug:
> > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, =
but takes just 3
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |                                                  ^
> > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > |
> > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undeclared=
 (first use in this function)
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT=
, fmt)
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I wonder what this error about undeclared macro means.
>
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >               dump_stack();                                   \
> >  }
> >
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)    \
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)       \
> >       static struct _ddebug  __aligned(8)                     \
> >       __section("__dyndbg_descs") name =3D {                    \
> >               .modname =3D KBUILD_MODNAME,                      \
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {                                               =
                       \
> >       static DEFINE_RATELIMIT_STATE(_rs,                              \
> >                                     DEFAULT_RATELIMIT_INTERVAL,       \
> >                                     DEFAULT_RATELIMIT_BURST);         \
> > -     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);         \
>
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>

yes, its intentional.

515a9adce0f0 ("include/linux/printk.h: include pr_fmt in pr_debug_ratelimit=
ed")
added pr-fmt to both the METADATA macro call, and to the printk() just belo=
w it.
The commit-msg was clearly about adding it to the __dynamic_pr_debug() itse=
lf,
the METADATA addition was overzealous.

Removing it brings pr_debug_ratelimited() into conformance with the other
*_pr_debug_* calls:
    dynamic_pr_debug, dev_dbg_ratelimited, net_dbg_ratelimited.

and as you noted, this makes the ... variadic unnecessary.

Ive added the Fixes: tag accordingly.

thanks for the review & pushback.
and apologies for the delay, I picked up a FLU shortly after sending v12.




> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>
> By other words, we newly pass just the format "fmt" without the parametes=
.
> The 4th parameter was added by pr_fmt().
>
>
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)  \
> ...
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt,=
 ##__VA_ARGS__)
>
>
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>
>
> Or do I miss something, please?
>
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>
> Best Regards,
> Petr
>
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.

I checked shortly after sending, it was "embargoed" for 24 hrs,
perhaps cuz it was so soon after rc7

>
> >       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&                         \
> >           __ratelimit(&_rs))                                          \
> >               __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS_=
_);    \
