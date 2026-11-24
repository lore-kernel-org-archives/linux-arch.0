Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516537;
	b=A/VV3BX+LsTH6upnF3flM4qs1dszv5HO3gnVjcRuhpbIq4yFyqS2qVG/6ewuHK2MBPFD
	 Xrl2Vyq5geSPoSQ5XGsXSsjsQzTJ0SAf99g0Azt7eKQZQEesl0bPtH+Kz0Uh/HNMH2396
	 l6l7OQyfL06wIphrpDVrita7nTH8E0H2u/lFKp1MxmKZgWDe3rc8DTSa8VFI5xPchsDSa
	 CHJAApUsTtvl4VjXLuQLV08BSEbx5bFgvrtY1Cv3S+kwSfvMsFijJZUJDTRym5nWxSuUY
	 guwoJK9yZBS9npqPNtzyGNxO8nbK9QaNZJjUc0QExb368HTVttzkLCA5LSXjHCjs4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516537;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=h29w5MPc3IARPXVDT8+ZatXwCwMx2JhL/am+F3d6xAw=;
	b=oOQyaCCsT/CNmUD3qHGqulEh9JedZjXy9ogF6g7sXayO3GToNYU60EALh3bBweimo3mL
	 foHRX/tNg4Tqxpx+Et2EG9QEEbSZvDSi3ileChLo48cKmv0xM/ap1jJ9OLvgBku7A9b2f
	 yqeFGAJAkUIuv3Wui2Wk+1iP+Bvjl9CAT2dXNXJ0rdaytgmMxfTucLDANDU6OoCbW8pZr
	 LnVM6/caiYJ22xHkey6t8UvFp4jh5oYVLYBMdcsOFUZe9Yt635xJRgqkIVjjE74WWTlsV
	 cK6dll7R2jvp7qyZLdLDvubqXxOJ3lzDzHmyO58pzTYpPSNIgG8M5HCyXceEtJRIZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=QR5QhD91;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iGKcs8f7;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB47606A32C
	for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 10:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB47606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=QR5QhD91;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iGKcs8f7
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 452127A051C
	for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 05:35:36 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 05:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795516529;
	 x=1795602929; bh=h29w5MPc3IARPXVDT8+ZatXwCwMx2JhL/am+F3d6xAw=; b=
	QR5QhD91aJ54ql8mUgm316Mz+oCXoluhG9l+ZYme8M2G+x0jdp5UA8bhvvuSmmPG
	r/s0JxohssGT4GxWzUcjIV9sJFbCMdMSOtp+Mmlrl8U3Pc7w2PN/jBSpxzxRaKot
	mxUhWBBg6qP8HCHmwGMr5wspTR2XvT7WFgEUCcDpFqwaWLuE/CGMFAk7wRRdLz/I
	BXSl1gcTFO+1HM6ewliKZr0dlcv39PiHNExo0Mpcgu8r4E3XgG49eLEpiXGaoLxP
	EYh3epCziZMZGodQb7eze5od3F35NMsF5LfhxPa71ZIPd6b2xfnD8maQuBi4dEM0
	S+POAA2XdJI8SPnJ0AfOsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795516529; x=
	1795602929; bh=h29w5MPc3IARPXVDT8+ZatXwCwMx2JhL/am+F3d6xAw=; b=i
	GKcs8f7LhKJkwUOmjFr9n2CzjOE5rFHtnkGsgjEU0wJqmI6UOsfjdZHiqGLcpO38
	y42+DoOYAEtpsQOn2U6cUPDCWXTbZuUztH6JDRl7gp+jbNMw71CkqQRi4yeZXo1R
	sqQs8HpAp884Bh2en5nEEdZIltd98KMUZYaQqONhTtfohoXtjuqkgz7dUV0xTFRx
	ZugOwP6x1XOTmTu53Kj0E5ykLVdGbWVBHJMDNJOm5uNwsNxx8iN5NRYWW/SvR4Xl
	x3nHLCVG13VHRwKaDnH351v9hoS2W++nypnya/hXA/r5NEIOofoeBIY7hPozMYhG
	EMzyB8dKpo3FW2/CHR1kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795516529; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:m8Rzb+SmeCZUmKAImvOxJae+KGlsV+ZXn1YllIiiKx9060H
	N9U9+5Nx3ER+4Ep9cnYJII4Pc9oJee/vpy0b4TXjNhDTro4Inrisv3GRAmuBvki7
	7G8bEYC6OAkK9PUg7g25sDI8GcfUzdx3+kwrq6tvlZkvzTdNpzdOf4g4XrYpYsLk
	LoBrVY+NiCiH5AcgjGqhVHQLnuidfrqih+S4QO0RO14+rW3MHiRa1m0ac+dDd3O8
	aAhrt0J3UwUdAUSCikt6V4Xshngg1ZkvVHxSTgUmKSpNb51/DhTd5zrOhBIA1XCC
	JqdzSJgWdec8TmOfKye+yVXBAew3gcUvQhIVA3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:26UoChXvqnJgDioMpdDKaEIVG9Ys+yx/QqFhqG7bubE=:FexWu6ZggMSM/AlYzTtwyjLoLJNpbM5OYZH4WwT6TfE=;
X-ME-Sender: <xms:bGgFa8kyevDy6AbQkYR0ov94WVfCb09GQjqNdyCiuwCb84sKto-xnw>
    <xme:bGgFa2oJgyiQtT3i80IOtcqVTORwgMbcnsTLcjZ-WfwLU1oenXxzk7N_poko01Df_
    XgHy-v2vZGTAmHBWDe457UA3XIivyXvYnEurRZFvezOzNOH83b7iDo>
X-ME-Proxy-Cause: dmFkZTG1i2UK43yng2es4nNnnm9clvXkEIigNaxebY34n7hBDrqbhqkKmGrPgHOp2fmd3Z
    bY2ws6ZN02yDcgZGxwa+KupuUVj/p4Gef08zp+G3mKZbhOFtnZaOvWjN3N3PeIW8gDIFD4
    z7X2vW9q8Hve1tIa2IQPTdiOzDmXTg4VXcKOIpVGiZfK2M8p+hO6SjSlYTYoTPiBF7JFH+
    kEtQipFn/6RXHrnBfyHMhYqFliWJoQ409eQXg9eSLu0Mp+MOeWDog/RqlCOebc3j6itDpN
    hJGXEd0WGo5oy7IJd+17o4sLXWfVS0C8HYVuiIEwoGbbLC1cVtDhLyRVODLKOrZE9O97Nl
    UXJEnEUhFRTu4UyLEtTv2l8uC9HuV7XAs1ens6OBsCMla7ae5gfuQAANhHtLG6BBSr9Azr
    bx+2Dz2vA5fqwj/gBXkemc9GH6geIigGo/Ie81TcQfNf3AA857lh62qs1MmSypZ9NAsUce
    M1TEcZGemmNwFAMvdWGF3RGKw62JhZ5t/jUmPVjEauccaxBiVumd9n2Vw9veMSG06pvWe3
    8fJc0jx3m6hbbbbQxv/PR8p8uR3XeNI6TP7sci1Wqt5x9DQA1bnRZQPLfpjuiov33CEkKJ
    dr4GTzt4WDjc64mKZu8BzgaJhg1F82ZZ17H2liJW27m4BrDpebv2ku9UNsKw
X-ME-Proxy: <xmx:bmgFa41s1mcE9-GeWfDbvxxhLiODzV0l28-APItf-SWCx1JYWJe4CA>
    <xmx:bmgFa2zZlNFeJtzu4pSf4ZH252N4ZDtFsN1uBRloN6gmkB2S30BoFA>
    <xmx:bmgFa5jovtZ0yyPxCt4EjOz3MpSwcUV3Dr60w-DPSsQx0ea54M-Ogw>
    <xmx:bmgFazPg4WCd_XI1oauRhj266hTC329Lho2y_qBDB8nUB2xxkRTBng>
    <xmx:cWgFa-CqKjefAu2WUh3ps10VxzlG7HAk67xfR_XJ9gmR0J1BWhxhXVMq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8944532A009E; Tue, 24 Nov 2026 05:35:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AMBXs8AlnIpN
Date: Tue, 24 Nov 2026 11:34:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Aaron Tomlin" <atomlin@atomlin.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-modules@vger.kernel.org, "Louis Chauvet" <louis.chauvet@bootlin.com>,
 "Joe Perches" <joe@perches.com>
Message-Id: <27fccf72-7642-4a16-83fc-fff7309b6fe9@app.fastmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
Subject: Re: [PATCH v2 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 24, 2026, at 02:30, Jim Cromie via B4 Relay wrote:
> This series fixes a latent i386 section-alignment bug by adding
> explicit alignments to the BOUNDED_SECTION_* linker script macros.
> On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
> ALIGN(8) in the macro, a following __dyndbg section inherits 4-byte
> alignment instead of 8-byte alignment, causing a NULL pointer
> dereference in dynamic_debug_init().
>
> 1. Drop the unused HEADERED_SECTION* macros from vmlinux.lds.h.
>
> 2. Refactor BOUNDED_SECTION_* macros from vmlinux.lds.h into
>    include/asm-generic/bounded_sections.lds.h for reuse.
>
> 3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
>    variants for non-8-byte tables like ORC_UNWIND_TABLE,
>    EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing the i386
>    NULL deref in dynamic_debug_init().
>
> 4. Remove now-redundant outer `. = ALIGN(8);` directives preceding
>    BOUNDED_SECTION* uses in vmlinux.lds.h.
>
> 5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for
>    vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) for
>    scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules
>    under CONFIG_DRM_USE_DYNAMIC_DEBUG=y.
>
> 6. Generalize checkpatch linker script macro exceptions to match any
>    *.lds.h via a single `$is_linker_file` regex across all 4 checks.
>
> NB: most of this patchset was split out of a larger series fixing
> dyndbg-classmaps.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

for merging the include/asm-generic changes through some other tree,
not sure who would best pick up the patches.

I can merge it through the asm-generic tree as well, but in that
case I'd like someone else to properly review the linker script
changes.

      Arnd
