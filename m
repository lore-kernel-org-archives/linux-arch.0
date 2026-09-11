Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E892E542C;
	Fri, 11 Sep 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129254; cv=none; b=bQLfE51HhXLBuYfeyDdoHoIoNfoGCaoL4wth9Q0BkqEjdb9Psdel6664xWxOvPgLd7hzQerP4TKVLMYUx9DhZFBwfV1cMQ2aTbqWPS3ZSdSbTzbLZPJapAC1Vns2pN1fktIFcTbUn2eXsVrW7c4VaAdlzJddOrsGYioxdk/xYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129254; c=relaxed/simple;
	bh=b+xEuspYkjMBmlRvZiWciiKYoR20PgwVVqxO8v7qS58=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Im+3Fbw6MPCXYDDxgXnFlX/VRoQnBheTMS5QckJzmCfbVgVw6UoxRNv1bXrJ87o0WF8a7i/DksQ5PmUF100Zb2v0lQkIQqiegkQkeGGdQjhjY65Mko2dWmxehcgXKkBHwmak4McpVVSJJH987fNjD0FdsfLcGBQm4Kvk7BTG+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=B2KDladt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wxCbCG1v; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="B2KDladt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wxCbCG1v"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B05C1400138;
	Fri, 11 Sep 2026 08:20:50 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 11 Sep 2026 08:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789129249;
	 x=1789215649; bh=Qxwnp7cGJ3b921bADKRcDRkcwsc3OksxRmgtXyUmX4o=; b=
	B2KDladtytUV6B9K9q+d/+XuTXRbe9I/58nyIhRrbSWWSto6FdHsHY71UrfKIRxZ
	pgFdYhk014mEd1akvf12a7Ve1Ui+0ATSaAiz30IcIKLLIh2FoTm9jyL5B4OZRv9D
	xMyUq9v8RtDCfmADdCrVrXm10FXM/5BAyahdAzQVYqf7/01qmXyr02rvcR9ps4Ez
	bT03ukStOXZ/PGxt6lbvqKdbeBapuT0w0ICvGAxEoUntwhJb4ruVc3uJKxq5raBx
	D+8vZwf90Gs6jc71zFC4A5q6UiY6+ri1Ud4Z85SBXoiPpB6sSStBmjN7pXCrqKHL
	Dv9vXbr9th4K8h73EaiCLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789129249; x=
	1789215649; bh=Qxwnp7cGJ3b921bADKRcDRkcwsc3OksxRmgtXyUmX4o=; b=w
	xCbCG1vhKurLxQvvyE+vT7VXv+obopeqCCWeJzpAmbmKh6h8C/1phgVj922BmlWk
	pfEkgB3Yd6tgznhup6TaYDSEuXfj0rZ3LH/YDkBemsLSAGL6WRtJfmYEni2agbx7
	WKErSEuTdhaUJHPa5NdZ/94jOS9y1OTn5u57oRrbNRvAioONMRyfcrK7cL/5+uu4
	ZRFwEpbXk0ayUImxcB3aaFm6BCkG56L6DKaEGmBcSH++/ED1dJLVQudydDCubLVM
	+xG5BJQoxn4X5jRk6aZHossqJ5DC9PwJPqxlnnMSlj5kZI63p8i4lC6SRFyARq0d
	tAcN7O11YP4nVtlf3nEVw==
X-ME-Sender: <xms:HvKjanPto3C4_jsxzTav2yHkDo4lrhqDmiBLBfKE-qfMDq1zdHtVZw>
    <xme:HvKjasw_tLiSdx7iWRgK1jCggeq-azQTSHT7kwfyhklIx45jfbC-E0SQZkWOqceDm
    zpQJmlMpyiaAZvgSmKIHvL90rf6UjTldDIAXUjjb6ZAyKou_SZU6Mus>
X-ME-Proxy-Cause: dmFkZTE+aWhMJrI4VcIq6qA0bOlxL9vSGDXREwkDOiNOAVBF3rW97fRO4nJd1BaPKmWyRM
    Bn1GcYBnAMye6B8fYVCwe/0UsjTHBNtoYtfG/YmehIpzKwa7wNI2hIwuSl8PUeMu6wi06X
    2x2IkK+8kzLYj3yBu6jItjeF1B4JQeLTn4Ci4TCrVBKgMAGJQEXuszTynIk3woBRZizJQr
    4FUqL2xk7OfWp1+tTy5aHqOzPPNMfCingWOOVrwyL2wjNvRrsgNpDd2nOlVWL9cLuqpUsK
    5y73zZ1FVcvBVDcde2sv/yGyu85NYF+aZZhPjRab74EP3GlQ7XrGkCjNTHkL2ab5jakxRR
    CzYh5c+KGAOh1OYVs08CRMI3SurCOJEzsRMJKMVmHHPQlsu0wZna/hyjXd0IXQaLcpQ0mV
    HD5ZcmJIItcOzrOwA4AN24TJUC+PKbIRx5yJ1fXH1YNhTFjQrggwItUqUAttKSLrpmmTOk
    hUU/Y3ac1eKfP88kDzb/8oFcM/2y/JKNcrjylmeuPbDDxAicHuBkyl2r75fm3OVQNxOe9+
    DbTwR+9CfCLPhaGqySXrPBI0FdZ+kRO5oEUubU2iV8vI/IVRRYOLwTDBx88mJTE8sz0OSi
    4jkeibAxl/5IuDEuVDEVK5Id8X1D2er12ghDuYGfCqcBVb9PqJVh/oG8JlOg
X-ME-Proxy: <xmx:H_KjapZgPViIFE8R53TkjqzWsGr6TvO39QdJ0haZmRhxx9Ep9n_CeQ>
    <xmx:H_KjapU9Ldl7sCFR-anNxFxhN8bYh9C2hdwoHKI61V0MxCVWHnnXZw>
    <xmx:H_KjanheLG_qcVDV6XK1Lg3e9tjKJeLRl-qHwNB0q5aoNfV5u4ReHQ>
    <xmx:H_KjantK1VCjjXJUKw9nYfBmZZa4MG41e4G29trAx0gp-9xRdJlnZQ>
    <xmx:IfKjakylIO8S3Eq9VpX3gbXJ60wWt-6X16SxWIquHRueaKAbc5yqx208>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3EA9D32A0081; Fri, 11 Sep 2026 08:20:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATCgFu_bFIfN
Date: Fri, 11 Sep 2026 14:20:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alejandro Colomar" <alx@kernel.org>, astian <astian@memeware.net>,
 "Andreas Jaeger" <aj@suse.de>
Cc: linux-man <linux-man@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
In-Reply-To: <aqPmNKbqjBILjoqw@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
Subject: Re: outb(2): terminology correction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2026, at 13:36, Alejandro Colomar wrote:
>> Date: 2026-08-31 09:09:46+0000
>> From: astian <astian@memeware.net>

> Yes, 'inline functions' seems more appropriate than 'inline macros' (all
> macros are inlined, due to how the preprocessor works, so they'd be just
> macros, and as you showed, these are not even macros --except maybe in
> some architectures--).
>
> However, I doubt the entire paragraph.  I don't know why inline
> functions would produce unresolved references at link time _even if they
> were not substituted_.  The point of inline functions is that they are
> sometimes inlined, and sometimes not, and the compiler does the right
> thing in both cases.
>
> This seems like paranoia from decades ago, when inline functions were
> less known (and maybe compilers were more buggy than they are now).

My best guess is that this described a bug in glibc that was fixed in
https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=994cc0ea88ce7a33d532b735c0723705742b1a7e

commit 994cc0ea88ce7a33d532b735c0723705742b1a7e
Author: Andreas Jaeger <aj@suse.de>
Date:   Wed Aug 23 16:57:31 2000 +0000

    (_EXTERN_INLINE): Remove. Use static __inline instead of _EXTERN_INLINE.

--- a/sysdeps/unix/sysv/linux/i386/sys/io.h
+++ b/sysdeps/unix/sysv/linux/i386/sys/io.h
@@ -40,12 +40,7 @@ extern int iopl (int __level) __THROW;
 
 #if defined __GNUC__ && __GNUC__ >= 2
 
-# ifndef _EXTERN_INLINE
-#  define _EXTERN_INLINE extern __inline
-# endif
-
-
-_EXTERN_INLINE unsigned char
+static __inline unsigned char
 inb (unsigned short int port)
 {
   unsigned char _v;
...

Using 'extern __inline' without optimization in --std=gnu89 would lead to
the compiler using an 'extern' reference rather than emitting a static
version, the 'static __inline' variant works as intended in both gnu
and standard c99.

> Arnd, should we remove the paragraph entirely?  Or is there any obscure
> reason why optimizations are required?

Yes, removing it seems best to me. If you're changing the file, I would
suggest also adding a note that the interfaces are nonportable and only
work on x86 and alpha. 32-bit arm has an empty stub implementation for
sys/io.h, everything else doesn't seem to have anything in glibc here.

       Arnd
