Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7A386426
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162169; cv=none; b=EjkW9WKNH1H4UUurA37Inz7S5TqFm+vbEera+Lbz+UXbQ7G+LX7lLKwDMDWtp0bAB1uuKedzty4xIUKjz/ggjasi5/E+mtxvRkUtHJ2DhvAgQzfU5FH/IOxW4MgsBHRXKr52mG4pve34C6cW8si/YWvM40L97r4djyMWZyvBuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162169; c=relaxed/simple;
	bh=xnd576x0/BHjM0UR6VTvITc/teuAO+ZV6DBnplo5bTY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZDslpBmmHBe3ms8VGIVaZWM0xE6YkCeey+dAL2f6GBXVkBxYg/iVUU3aKPFvsR/RV9IDfXqG0ZX8OPt+hV4K8whFeksi57BBajLWeBMBStBG0PXBN3rn2vwry5lHZglebD1UeU/BdX0KMGH8ovgxQK9HzyRnQAwL0bmf97QTocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HA2ElU+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOzh2WFj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HA2ElU+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOzh2WFj"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id B59E7EC01DA
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 10:49:26 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 10:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792162164;
	 x=1792248564; bh=VbOmtD0ftdDqCiNEvPeZiHI6VvhMe34PI7oI5j719Sw=; b=
	HA2ElU+M9g8gJFcWF4WJxvHNd93CEWK6D7JYbEX67H6DUGgrOIKFKylHGSlxgfL9
	fc87+cQ/QR7bY/16+VcofgZNNiVrMpxkSgZwYo23HP1sOJi3ALOF0NlE/qxB9Gq4
	1VVpy7I+NRKgbGRYh1q9sdSPTZeqHecKRFTJPFoSIBOGCYhFmxyzVDwcJf5URK4d
	dWedxdrgGbJrqQOqMcKOqOP9RwztMNet2A/LLDm5n8wq9M6zW0ngxYbiT/uqq1dn
	V5jX/scWOsrJpNpxAgkpPLdgkmyP6pDOwpZG0/qw0IvpLGy6rxmFaz3owYH5/LxA
	JAXoC4bj5GfM17Et+EZjew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792162164; x=
	1792248564; bh=VbOmtD0ftdDqCiNEvPeZiHI6VvhMe34PI7oI5j719Sw=; b=M
	Ozh2WFj3olrn3LgWq8qXhrWFIKcFNTPs+I6AIWNAH2DmBK1Id/Te0OantiMrAPic
	cREpaKh2Q8c9w2duMYFKPWydBUUN1D5zY1koWQDqnK+fkNE6841BaEwD3EHhocPb
	4aawBbU4lz2nUUQDqZBfazg750KdRhlITA5HHWga3kDkRFkfO+OD95BA15ihjVKN
	kUXpefh+uox7f8iEP/DW1oPATr4TH7eVC8xM7NzXKmsolJtp++2Eqmyl8IMQrUXW
	dIj8o6H6YcsOAYP2sE2P9CyYq152FcJdiOmW1U56nXMXPrD8VKhL8ldVfWaYgh5P
	FE4VPVa4O6bEYkr8SIDPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792162164; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:U/tJuGYyWyVAHIUut1mJCJTjxkXoeN2weWgzntSheGQnyNJ
	91U2G/0zHpjLNieMDZVXJPqvV3WnpKcph6UnkhuM5lAemzP+rang6VYe/L8mBf8u
	fhJQDs0wAwLO879AvDZphFJGoArq2KGidXZpMeFB1/sHam6jqdP6xlmHbTiKa1/a
	vPB6kNCiXVKYlAx8xAO0D4A+zbpfj+aEf66Yv3Fa572P1sit3XsfCgrSlFgcPOTQ
	d08yqSiUUu8gU6knNf06t21lckdjAfPmr2kAhw8vD7tgmCU3oLi+lHlswO7JQyHX
	yv/o+qMHyx6X1yZMaKGjaCX//oplfLesnG1BcDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Gtxp/RklLel/o6Sg8Kunod1iHE5Zgj43yPDsf2w/wzU=:xnd576x0/BHjM0UR6VTvITc/teuAO+ZV6DBnplo5bTY=;
X-ME-Sender: <xms:cjnSajvI1kgd_nMUWoGXaZKA_rfqtjrsPnSkie9cKGlAKIfkkZrheQ>
    <xme:cjnSavQWS5eaYOVlePAOhuCy6QpqEMuc4AGuv5H7jhC4oRWgBishnFcZl5PbLHs5y
    PVu7vgfTMywquOu0YvKh09F92zSd4foeLm8Y60UXecJCqhABM5sRaxG>
X-ME-Proxy-Cause: dmFkZTEs8XK3Dm5x5Os5mnHR2L0vK5Mmv8mQErbydUtW8nm6SZxNbgcutm+a0ap7Sg0qaI
    Ajm7r6rBEOEZL7ALb9auTpp1CDifogfFddYfVyaAJOgEOqEUIJFDxwPDVIep7h+4u4d5HV
    AvUQwEXeri1gRicfWvqADNm/+7GV/aoqT775YoGdbI/mjMjmwetrz73Nv8LsmFkZvCPkHW
    DYUj4OlKYFkeaxPKHEV/xEFZbIszDSf+K28lVIziKHA6GNmAYJbHeKNfgorDA2CnDQ23qH
    ZxffD0o8PycVCLBRGPFMqTU9YOGWyrWCWXogr2U97i4lA16oqDQn+n3MbdF9kdCmRBOYC5
    iMl/Rkk4Ka0HyLN6RuGUJyuh0ymgPKonN08skMgmdUj3Bwg+4bjztygBvsMOO0XC+wXdd5
    z7x1G23oKBi/maNWXB/bCwlmEpeZtBvTr2ccH7wwYXLs1i1uMOCEp42l/tVoi0w3yHMFDG
    53xiP1kjX5bFqPYPlqiUJ89B+ADDc6+8emGx9+5Rxxcw/BHrM7a2x6p6ubb2U/W6JvsQHp
    qS0EctwB/FOCJqujMcXWcQ4/G6Dfr51GwOc/jQLwi0p0jAbO/KiFtwu6RhSS6RHy4Qcigs
    10P7LSV3TG4E9ATBdSfpQt4eBD81GncFDfjFSu6B7AyjEeyPPO/7sGpOHxiw
X-ME-Proxy: <xmx:dDnSat5jJ1KgZSM_OJ8auogm1jgWwsmbKQctPZEHGg2lmiYDKR_IeQ>
    <xmx:dDnSaj1TI_cTRxugcgv1eGcv7FZhCq_aAJr5l_LgRP8sptlr_jdUXQ>
    <xmx:dDnSagCHSO--yLPnuwp8UVbbmVlmH786AM54btcJHw3l2FPfTaFumA>
    <xmx:dDnSamO8nHYQpNdvmY4e43HBnJDglCpo4khQ_7C2UnswqTN7iHhEzA>
    <xmx:dDnSatTmh-x_DOggy4PaXCeX5vdMySzITW1HP1xTA8-bq2GpDr14_7sQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BDB8C32A0095; Fri, 16 Oct 2026 10:49:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ8BcjErQSfB
Date: Fri, 16 Oct 2026 16:49:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tzu-Ching Yang" <shingekinocore@gmail.com>
Cc: "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <affe7da1-41aa-4710-bee0-5e3c2b8a8dfc@app.fastmail.com>
In-Reply-To: <20261016135329.509250-1-shingekinocore@gmail.com>
References: <20261016025634.2690862-1-shingekinocore@gmail.com>
 <7eb58dd0-99f9-45aa-bdf4-9707a0c9e1b4@app.fastmail.com>
 <dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com>
 <20261016135329.509250-1-shingekinocore@gmail.com>
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 15:53, Tzu-Ching Yang wrote:
> On Fri, Oct 16, 2026, at 09:16, Arnd Bergmann wrote:
>> If you are interested in creating helpful patches in this area,
>> maybe you could work towards eliminating the generic versions
>> of these functions in favor of using the builtin ones on targets
>> where the compilers produce sensible code for them.
>
> Thanks, I looked into this. For each architecture variant, I put the
> kernel's current version of each function and the builtin one into a
> small userspace test file, each in a function of its own, compiled it
> at -O2 and -Os with every GCC major release from 8 to 16 and Clang 17
> to 23 that supports the target, and compared the instruction counts
> for a variable argument. Of the rows below, only hexagon (Clang only),
> powerpc and mips other than octeon could be built with Clang. A few
> GCC -Os builds did not inline the kernel's version, so those cells
> (arc ARCompact, ffs() and fls() on mips, and ffs() on microblaze) use
> -O2 only.
>
> Each cell below gives what the kernel uses today (G the generic
> version or a copy of it, A arch asm, B the builtin) and how the
> builtin compares with it:
>
>   +  inline and never more instructions, with every compiler
>   ~  as +, but only with some compilers (see below)
>   -  more instructions, with every compiler
>   x  the hardware has an instruction, but the compiler never emits it
>      (the builtin is a library call)
>
> In the "fls (clzg)" column, the code in parentheses is for fls()
> written as 32 - __builtin_clzg(x, 32), which needs GCC 14 or Clang 19
> or later, so it covers only those compilers.

Thanks for checking those!

                      | __ffs | ffs | __fls | fls (clzg)
> ---------------------+-------+-----+-------+-----------
> ColdFire ISA_A+/C    | A-    | A-  | G+    | G+  (G+)
> microblaze PCMP 8.10 | G+    | G+  | G+    | G+  (G+)
> microblaze PCMP 11.0 | G~    | G~  | G~    | G~  (G+)
> hexagon              | A+    | A+  | A+    | A+  (A+)
> mips32 r2/r6         | A~    | A+  | A+    | A~  (A+)
> mips64 r2            | A~    | A+  | A+    | A~  (A~)
> mips64 r6            | G+    | A+  | G+    | A~  (A~)
> mips octeon          | A+    | A+  | A+    | A-  (A+)
> xtensa NSA           | A+    | A+  | A+    | A-  (A-)
> arc ARCompact        | A+    | A-  | A+    | A-  (A-)
> m68k 68020+          | A+    | A-  | A+    | A-  (A-)
> arc HS               | A~    | A+  | A~    | A-  (A-)
> csky                 | Ax    | Ax  | A+    | A-  (A-)
> openrisc FF1/FL1     | Ax    | Ax  | Ax    | Ax  (Ax)
> powerpc              | B     | B   | B     | A~  (A+)
>
> The ~ cells depend on the compiler: microblaze 11.0 needs GCC 14
> (older GCC compares "v11.0" and "v8.10.a" as plain strings and emits a
> library call), arc HS needs GCC 12, mips __ffs() is + only with GCC,
> mips and powerpc fls() only with Clang, and on mips64 neither fls()
> nor clzg is + with Clang 19.
>
> Not listed are the targets without a suitable instruction, where GCC
> turns the builtins into library calls, so their current code has to
> stay: alpha ev56, arm v4/v4t, ColdFire ISA_A/ISA_B, m68000, microblaze
> without PCMP or before 8.10.a, mips R3000, nios2, openrisc without
> FF1/FL1, parisc, riscv without Zbb, loongarch la32r, sh and sparc32.

Right, that list is pretty much anyone using the generic helpers
today, so it does not sound like we can convert any of them to
the built-in version, only the architectures that currently use
a custom helper.

> The G cells are the clear candidates: microblaze with PCMP (8.10.a or
> later) uses the generic versions although GCC emits clz for the
> builtins, and ColdFire ISA_A+/C still uses them for __fls() and fls(),
> while __ffs() and ffs() there already use ff1 in asm. On mips64 r6,
> __ffs() and __fls() end up in the C fallback of __fls(), a copy of the
> generic version. I confirmed this in 64r6el_defconfig builds with GCC
> 16 and Clang 23: the dclz branch is used only if cpu_has_mips64 is a
> compile-time constant, and on r6 it is not, because cpu_has_mips64r6
> still tests a runtime flag. The builtins would cut both functions
> there from 34-64 instructions to 4-8; making cpu_has_mips64r6 constant
> on 64-bit r6 kernels would fix this as well.

> In the A cells, __ffs() and __fls() could mostly switch at no cost,
> which also lets the compiler fold constant arguments where the asm
> does not. fls() pays for the zero test that __builtin_clz() needs,
> unless the compiler knows what the instruction returns for 0: Clang
> does on hexagon, mips and powerpc, and GCC only with __builtin_clzg(),
> on mips and powerpc. That test is why powerpc keeps asm for fls() with
> non-constant arguments.
>
> If this is what you had in mind, I would send one patch per
> architecture to its maintainers, with you, Yury and Rasmus on Cc:
> first the G+ cells (microblaze, ColdFire and mips64 r6), then the A+
> cells (hexagon, mips, xtensa, arc, m68k 68020+ and csky), with fls()
> using __builtin_clzg() behind a __has_builtin() check where the table
> shows that it helps (mips and powerpc). The same change to
> builtin-fls.h would make fls() smaller with some compilers, and never
> larger, on arm, arm64, loongarch and s390 (on arm64 from 6 to 4
> instructions at -O2 with GCC 14 and later). The ~ cells would need a
> check for the compiler or its version, so I would only do those if the
> maintainers want it. Each patch would be tested with kernel builds and
> the ffs KUnit test.

I would focus on the ones where you can manage to reduce complexity
in the architecture specific code, i.e. replace a custom helper with
the builtin one, but skip the ones where you would need additional
conditionals on toolchain or target options.

On most of these architectures, adding performance or size
optimization is no longer a concern, but source code
simplification does help.

If you have cases where gcc-12 and above produce better code wiht
the built-in, it may still be worth doing that for all toolchains
even if the older compilers may be off slightly worse.

> I agree that each step is easier to check in the open-coded version.
> The trade-off is one place to check instead of four, but since you
> find the current code easier to read, I'm happy to drop this unless
> Yury sees it differently.

Ok.

     Arnd
