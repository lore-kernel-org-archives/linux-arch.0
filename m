Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585009;
	b=L69SIiEuEBIbuQeFHU5o//9Yn0lF0H8UYl+lN/Xz5pE5g+fGulWTxslgDaRc0KXJwlqv
	 4Cy+oA4fCgRHwaZLZ0GsioPJx6tFPqrJwKMxaFkCnMk8aN+fdf322xgEmEvdMKq6b+j7C
	 AsXIEH6i/I6pip9Trc2WUZjmmdsRZ1vz22/maHKtm/QyXNFEl477vSMY31vBb1C5dy6t/
	 FG/8y6mE2iBOhBdQmfcUs6jfixJYmg+xMNXiNu0p1uf+hnUtZ772vZk53+h9kyR11z07I
	 GK88TmC8J2ZBX2V0KgoKFL0qXmixOnQgYxPvsBFRVrIhOeq6tclVKqSscng94A9unKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585009;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=pVJ1x0k3sdze9cPiJou8MJTh07f7bzis+TTbrxn9Qu4=;
	b=D8lz1XUrTqBahP0heDicidC6MM3bMMqJTaOMI+b2XNC8DIsf1qpjsDYHAcI0gOQkJTFl
	 wAhK+MrN3dcxA/ceRdJKl19zsesyS1tV/HukWUqMK3ZhvMbWxDJdXPYp1i6+PAe3gnlCk
	 Bi/xRLhVBEDS4BzNEeqwIchUWPT6DOtv+c3A8N6iLaQkWSfDyZ+Bxml3Q/t5wz0WwX4yk
	 Bu2YXLi5R+K8amKxI5RJWqLnNQQiB4pDjjc8dA+dAJfhQnpNgnvVYv/KeI5afqyllUalU
	 PbZJtPbRUPA9LEhwIPhZQalWXfd9cuLwVSRR7uHsgEfL0ORVXmPPB/cUiYqzj0mpLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=XjECWdGp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="euA/ihmz";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D34606A333
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 12:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D34606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=XjECWdGp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=euA/ihmz
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030601400078
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 08:16:47 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 21 Oct 2026 08:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792585002;
	 x=1792671402; bh=pVJ1x0k3sdze9cPiJou8MJTh07f7bzis+TTbrxn9Qu4=; b=
	XjECWdGpZYFpXdeaeMW/MsdcYGcMMFdcUkZcALqzR+6Sc+j5GaGg9fDC/380mug+
	mG67U5MkU3tg/Fr8SVKGPCsyg4JkvBM1kH7DNC9F9/rD2CcAMOJAjbq7ljQtmUKB
	aMvMsNcqAfF5SoYEdWYh76RBmA+063XOG9UqYin57K3ioYJPmU5TOaFxWDoZdCyv
	sxquUR4K65eFAqqzUzrcTFFsZHBIlxB/MuaOhGH02dN1CBwaD/0/ZFWbLFsrffFn
	DCovWWPE79O8FFBEm03CkSwOUO9KLlkChMs07gUlWfhCaCJnHO5QTeUHamMFxCMw
	HC9hscOG7cD5mw2rcCiDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792585002; x=
	1792671402; bh=pVJ1x0k3sdze9cPiJou8MJTh07f7bzis+TTbrxn9Qu4=; b=e
	uA/ihmzzmaNc5dTva5RUUwnhwxbvd5z8wFJ/0b58t0MG08rRSf/iw6ee1NH9Zjvs
	zsoqPbFKE1ohkiJ+erNFbXbAhgUq0nm+2lOcpn2gXHDCZ6gzwkJivFCLoPJMpExa
	HcMoiQjLROKxIPHqo5RHkbSFB6OGIufSYDJMHeQhpsSpwGnjlVNRbyc72InUOfdN
	oFVa5T7aWYeGhfwchVOq3WTpmG1NQIa22mMGAdaU8ngEVyMO1Se08+E2uhxAvZNS
	VTcfhI5sYivnlKxUp8FBET//jcC8kLAPZSXA4v8O2+H3H+HRZQM2/W4lJn7r6clk
	owebCSOOreOCvMQ8gjSAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792585002; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:o8XNIGvkA7jz5khLWREzlhMWnrKfV62jIfyh1qUkGqNr+3w
	kWcP66MCHSYMQ9TtCPJWPzJCse8Z6UgTHGCNLMpLA9nTFjSwQmR6lXXG0LEVepvk
	pmKtueHxmbNdX/Fow5HQD2d1OBCZyQrErj7Djw/yI3AQc6KhtTSrJVfoNrUPFHAO
	ZXmvDzpOFXPIoE/T4YxPJw04nyIrgmB+7Caah65utKagoarwL3l7XSKXRNPf7R7k
	tnyIfcVgm4JmVdzKbFt0ml7yJtSsso/XY/znr33MfH/zOPvMkGILP7DGfIvK6k/1
	oEY7tkPVc7gVKbvE3kBz41oBxMm7kUkoRl41rFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sXYK5kqg5RAIxlV5JP7bTAEctlUDSe2I6M0f0fooR4o=:k1g1N9t8QGAgjH9tZVDG6P2SW1DLJKdHamEVOCUcq/Y=;
X-ME-Sender: <xms:Ja3YarL0794Gx-VAcnXuU0QxZUHXWoz4IWKKIn5rJNRAgO78O5bKEQ>
    <xme:Ja3Yap_vqU2j4TYeDYZJUuTE54r2wxFSc1G7hRPrmf6T7YpeUCSclhvrvj9usxP2L
    fE6w21zg2udr-4u2mCO4fLaPV7GFWNtrNvgpVoWGtdJ8Tss4AqezqxI>
X-ME-Proxy-Cause: dmFkZTFQx89gykQunQ8ka8t3krFt0J9UEA73ov9mxUxaGE+V0E3JjhdBeIaJ1Af3Godnc6
    y0EGHmihZKF1SNEnzexwXUS8v1vEIPj9B5x9f9FnngGJcJLveu6gPAFk12ifuKbOgDSipN
    KqHe1hU1mMpFtFEbHOWXLySt2GJMyT2/9gBdrfNQsCBKG3+pn4H05WjNLWeOxcDDBJYYRo
    1LgJHgnr7RTZlMF0Mb2yD7HXBcTJfwjkO3qrFxCCC5aCi2v/2FZ+Kr6jEzTMcPelG1Po/F
    BQapZHiFmINAZy/LvPVniBk+ipUbiLLaXjnwPhg/Et0bjc4CWqHSISyTmzEKQP5TpM3Mdr
    UEqkAMOcf+I5EjSOWCWzdU4GDc9LUIfZjAipYVByDM2QCchAxyZod5wvbRyBuGFmy/XwTe
    uCKFK9sVE7Rk+3oBDz07xU0T3phceBjRddagYEuMagrfvhr5OmSu/xFRi1TAtP3HIHqYnr
    nl5Mxpn/9BZ1jEkNuS/u08O45tEriS+WcUm3AkfmxsdIPMge1UgWrPMk7/6MyOQGUezhu+
    dIzLOiB/5vwx1GUeuUVFELe6WlbmlvCaoCwxT2RfLJ2yFuJWucZjw139KnlNtyZyPpYUhH
    2sOwJ8Eaos4Pfys1onWfXjCKGGORW9OqsMD/6y3vxlOjGfrztXFuWUIKQVjw
X-ME-Proxy: <xmx:J63YauEjnUtZW8eE0a_vG5IZU4WzOpaHcm6RZWlejHa8-3GmunyXrw>
    <xmx:J63Yaki0EML2RgNaJY7_I3_tDaU22PREUruaDEoLaQuaILNTB6rgFw>
    <xmx:J63Yarj632RdF_VW-KOy019KS7jySxesRb9_-rD7dV6yPy-nDVplpg>
    <xmx:J63YanlPXX7Eds3MSz_lwiVVBqfGDTmSTDUaVi9g0WkZAyXz5RcHIg>
    <xmx:Kq3Yagb8vSpKhOsZn7qDLlFOfIqAb03K0EEYgd440-F1GCu1zkE43cBp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 93AE632A0093; Wed, 21 Oct 2026 08:16:37 -0400 (EDT)
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
X-ThreadId: Anl2GdpqQwQR
Date: Wed, 21 Oct 2026 14:15:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gary Guo" <gary@garyguo.net>, "Philipp Stanner" <phasta@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <9505cbc2-7261-4f84-9769-b97e9acb1c38@app.fastmail.com>
In-Reply-To: <DMAHVQLCMQAN.3G0TBMA1UTM6H@garyguo.net>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
 <9f4bbc9a-fc36-4e3a-9c42-d18419c9d025@app.fastmail.com>
 <DMAHVQLCMQAN.3G0TBMA1UTM6H@garyguo.net>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2026, at 13:54, Gary Guo wrote:
> On Wed Oct 21, 2026 at 12:33 PM BST, Arnd Bergmann wrote:

>> I'm always confused by this and the new function makes it harder
>> to understand in the current form:
...
>> - Contrary to that, the kerneldoc comment over set_bit() mentions
>>   "This is a relaxed atomic operation (no implied memory barriers)"
>>   and leaves out the kcsan_mb() that is in test_and_set_bit().
>>   This makes the new set_bit_release() sound like a /stronger/
>>   version of set_bit() the same way that test_bit_acquire()
>>   is a stronger version of the (relaxed) test_bit().
>
> set_bit has relaxed semantics while test_and_set_bit implies barrier. RISC-V for
> exmaple will generate the amoor instruction for set_bit, not amoor.aqrl.

Thanks for the clarification, I did misread the implementation
and see how I was confused once more.

     Arnd
