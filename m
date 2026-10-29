Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312073;
	b=AFsXXLYZKjCvUlmmB2pLdbtekfYv09zdDlhGQkci8QfF5d6K/X0b8WXM8l8Sn1BAU2xH
	 YWVSUmDzXGH6oTnSu/FhHC3W/CZ95mbMfFvEHbKM8vT6bA2SrDVTtVNv/NnAi+JiW3Pnv
	 SA2MG6sZB0T5Yo1bRUx58N6nWILaviBXNxvfo+u+1byRok4yqcbzkTQ2CzbmjHzw/2avb
	 LwvO5IILiHItIu0j04sxiOlE7KLC4Nz4GddtUmk01xXMO65u7ulnWtnmflDtO1Q7qX/v5
	 3kQFjW14xNKNOV3eDXWpwpABYUBNn5spMF01d24A7WeIxmr0SiHq3G0jJYuhpCz4ixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312073;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Ita5NhzQht4uUFRKYY9vm3z4vF3/OmUWKXefUKPt82w=;
	b=h4/+925PAbzk/uECFh+sXuAEQiXfC63O1FFp72kI9N+5HBVNgRB3mKRxApL6PBWzugjr
	 C7kGc9dZ8C0al/sTFk+EVDQDIUwL4t6n6KydgUfGov24eEukRCiJ8tiSHkE2d8EAIpcjq
	 pINtu4SQaGqU/S1i2csr/Ajlr4TLopUao8bpyRrHzpQyGne+OGtaXUJznRuftvDvMhc+I
	 b/Sh0OsliuKp7XSi5jwCc6+HmE1iucV0FWRIxj3LEGuncA8vnLCV+5jYugPY99FadjJAD
	 mVW0Vlxp+85mNWkHxdmjGSA6q4lVk/6OQhYdhkombHdJSTwHLvLOQXcPl2R69S8RkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BmxHMlzs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Zb1YMA2N;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE5606A31A
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 22:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BmxHMlzs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Zb1YMA2N
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3A1E1400126
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 18:14:31 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 29 Oct 2026 18:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793312068;
	 x=1793398468; bh=Ita5NhzQht4uUFRKYY9vm3z4vF3/OmUWKXefUKPt82w=; b=
	BmxHMlzsjJKExrQE2msB2lk8KuKPxU5wcfXxpG3aHcxh8+7Lq8K6IiCoSwoNWRbz
	MMDq31eXkNgjyFqn+SWgTXcPjr9Dpu6pnbvanB6Df889r8r/DYYiPxHFFPB9AuXL
	3lTq46pNJjx9lKV6WBY77u68aO3Vmzfsp697SrBBa6YpdvfTpC6ovesXVe+Gi+z1
	iHp3Ey4fVLA143QtPiUtF2R4/gH9i8rNGu9fHu+Al9p6C4vzxjU8Ynvmb+RtkHsf
	xF8NIFCeoYM+8kGhe24HStKUSXKISLgJrnfykRm9FZj3Rw+dOkYhJZlSAOXjTz+P
	csMqYPCqwjhuDI6E6o9Mkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793312068; x=
	1793398468; bh=Ita5NhzQht4uUFRKYY9vm3z4vF3/OmUWKXefUKPt82w=; b=Z
	b1YMA2NhZn0ceLnHGBPNL7LLHTL94iEGZ65LAvVL520kVGosFpNxM0eCVG3ze1DH
	ohvKR7qLO8XR8ghwqqP1O8Gw9gupvweDBTNGEFw5gl32AGZaaMQa0sDA8DCgJU6T
	mLGibpGgpbsD0z7gH7rZ6mnWFxxUFo/6EH5sD8pql4J33h9z2QOmduBraBQFA1NJ
	+PcoNvf1K9e8NMZN0iPahB3PU4aDvab01O4l0P7Y1GkHI+V9EpKGS9Sr4W1iB4cz
	yUDAsB15vsh8XITYi8yWjvOW+WLB1hcQXfbxXbx/Z7aF4w7x0rIJ10F67sSxORg8
	PanrnQSDkuGX98gfOv3mA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312068; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:XoZk+pHWLZQRzBLay61ScYmtWRBlqwQYK+rYobfYH2wJHha
	9DMPoO3rMOMVjFwIhMnqfVZSgsOPoCJoHThEc24jjOWyrIDHtol5zUYkUU3snwiu
	A4oxfS1GBZ0aJbm5iDEG91RguNNdmE9ffg4ubSVGkD/5x7Ko4jdVpWOwQl5Mh74B
	GnVU9xexg+GnIkMOX1U8wgrmX9SUYRhLY06SQ8WATcP+a6F/IANT7efvyCt+uddy
	zoPpZ5KyFjZ1Gb3hFI5jMzWilFeF0H7EfMB4Tf7DFaMM/LxgCaK6KuFp9WcVNMhI
	t4aAifIpK+c+miCUkozch8RgEpCgoTFQuU31QkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FfC6FnHlErJEoOnI54YOUsrEWLIeiip7urpBH78IByI=:H0yKGMxSICCqfM0SjC5OAm+Ut5n/BaOWPyXcKjNHvI8=;
X-ME-Sender: <xms:QMXjaoLRizCcrAp_k7BYJkUSRObSFChKjyeoVYrggB08Ya7GgeNG4A>
    <xme:QMXjai_UKQX4wprtYhXlvfOl9w_upViS6opQV_LlCLxEmJFlXvMzFWojGwCW9ppq3
    8A6YfbkmJqBIeK7yEdXcrr2nbGXoa661HpuFsvNke3hQCczkbH5UxI>
X-ME-Proxy-Cause: dmFkZTEmWXXkhTp8fzLpvBND9dT+L3fmnVg8J3z+Q2TaW7N4+YRl8WTTNqCwqcyYX6XGST
    Ked+9/ohbiEDljEX8Xz/5j5bwIAJmLsZ+KyTjy4U0/KY8ADohXkX0PG+TnOcAXN+jkZUba
    GlUN7+Xldn7vd/GXObqwTSxStVU7eaSpORWonF2gc99kxt9Nyzk77NnXjAOQmfAly/cnda
    IHRPnPJ/TEqzn+9PgD1vYfGNLzl1EOWNaATVeHsPxbL5Gw1mV5yCOSThBurDmFNnvmFmz+
    RgSVs3JuLSqoGASz964HvIScoZqm9py+ACNVy9zz0y5DDen4mgd7SCm+ktwo/LxgbN31ti
    fseiIfMV/hQIBW6yCnR6VF8yMfZzwc8fWf66BlyOfuymmpVYI7KkIXdreIgwtls7rDKTda
    /QWcIfuXFlOWOVeYtGv9RaTGv6AfTRo3OvOhD6m3H1NNYlvTS1PNdYzf8L3blI6me3tYKB
    XHJ8hfryUcNPmwiGmOAI6RBcTSx++zrzZi1qTF/DCUKNU2Nqvrm9XyCz+rG33HYT2Jlnrh
    WkcOrCJoSEjrwcvc3HgwNoOD8+TW8WXbCbDOxCoEifBoqvauC4GTBCMUgVZVGJAk02bv/j
    DMQ9UpZe63FDi3Uui5/ZwEtDiNO63lW4dRQmgon3y5dNFeotJujD/iTxAwFA
X-ME-Proxy: <xmx:QsXjau6VbE6MxJq98iHyCPuv6lZ-XspU1yppC8WUJ5enr2QKsVKmfA>
    <xmx:QsXjaqeKC8GGm_aK85CmbcdGdYrXOKSb9yubME9fxY1Wh8zFrKmMiQ>
    <xmx:QsXjahHojbvx3bbHk6wS-EZOMhN4kHljuj7__YykCnU6sAQLU_SY_A>
    <xmx:QsXjarTKIxX5w2ntEMtDekBbhCJeX_DaQyt8yFmZyrbyOjrKNXJBJQ>
    <xmx:RMXjaniUDK1hU1ui4RPRA7jkJcZIWBJyAEt1bsz7RA2BK7kzm_cV8p-K>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AB11932A0093; Thu, 29 Oct 2026 18:14:24 -0400 (EDT)
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
X-ThreadId: AA4M8BakChSJ
Date: Thu, 29 Oct 2026 23:13:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>, "Thomas Huth" <thuth@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Message-Id: <9e294bfd-4704-42a5-a704-f301f4afe042@app.fastmail.com>
In-Reply-To: <202610291918.kHO0GTDB-lkp@intel.com>
References: <202610291918.kHO0GTDB-lkp@intel.com>
Subject: Re: [arnd-asm-generic:asm-generic 15/15]
 /usr/aarch64-linux-gnu/include/linux/types.h:12: Error: unknown mnemonic
 `typedef' -- `typedef __signed__ __int128 __s128
 __attribute__((aligned(16)))'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2026, at 19:09, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git 
> asm-generic
> head:   dd7cc8c26b6a37a54adc5ce38d286521b7201044
> commit: dd7cc8c26b6a37a54adc5ce38d286521b7201044 [15/15] treewide: Stop 
> defining __ASSEMBLY__ for assembler files

Hi Thomas,

> config: arm64-allnoconfig-bpf 
> (https://download.01.org/0day-ci/archive/20261029/202610291918.kHO0GTDB-lkp@intel.com/config)
> compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): 
> (https://download.01.org/0day-ci/archive/20261029/202610291918.kHO0GTDB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202610291918.kHO0GTDB-lkp@intel.com/
>
> Note: the arnd-asm-generic/asm-generic HEAD 
> dd7cc8c26b6a37a54adc5ce38d286521b7201044 builds fine.
>       It only hurts bisectability.
>
> All errors (new ones prefixed by >>):
>
>    /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h: Assembler messages:
>>> /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h:20: Error: unknown mnemonic `typedef' -- `typedef __signed__ char __s8'
>>> /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h:21: Error: unknown mnemonic `typedef' -- `typedef unsigned char __u8'


From what I can tell, this happens after your last patch when cross-compiling
kselftest against system headers that still check for __ASSEMBLY__ instead of
__ASSEMBLER__.

The command from the build log is:
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-14.2.0 ~/lkp-tests/kbuild/make.cross W=1 -C tools/testing/selftests

The command that causes this is

gcc -std=gnu99 -O2 -Wall -Wstrict-prototypes -D_GNU_SOURCE= -I/home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/testing/selftests -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/include -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/include/generated -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../arch/arm64/include -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../include -Wa,--noexecstack    vdso_test_chacha.c vgetrandom-chacha.S  -o /home/arnd/arm-soc/build/tmp/kselftest/vDSO/vdso_test_chacha

and looking at the preprocessed file, I see a wild mix of tools/include,
${srctree}/arch/arm64/include/ and /usr/include. I also see that at least
part of the problem is that arch/arm64/kernel/vdso/vgetrandom-chacha.S
includes arch/arm64/include/asm/assembler.h, which then goes on to include
the world.

    Arnd

# 0 "vgetrandom-chacha.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3
# 0 "<command-line>" 2
# 1 "vgetrandom-chacha.S"
# 1 "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S" 1
# 1 "${srctree}/tools/include/linux/linkage.h" 1 3
# 1 "${srctree}/tools/include/linux/export.h" 1 3
# 5 "${srctree}/tools/include/linux/linkage.h" 2 3
# 4 "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S" 2
# 1 "${srctree}/arch/arm64/include/asm/cache.h" 1 3
# 5 "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S" 2
# 1 "${srctree}/arch/arm64/include/asm/assembler.h" 1 3
# 17 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 1 "${srctree}/tools/include/asm/alternative.h" 1 3
# 18 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/asm-bug.h" 1 3
# 1 "${srctree}/arch/arm64/include/asm/brk-imm.h" 1 3
# 9 "${srctree}/arch/arm64/include/asm/asm-bug.h" 2 3
# 19 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/asm-extable.h" 1 3
# 1 "/usr/include/linux/bits.h" 1 3
# 6 "${srctree}/arch/arm64/include/asm/asm-extable.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/gpr-num.h" 1 3
# 7 "${srctree}/arch/arm64/include/asm/asm-extable.h" 2 3
# 62 "${srctree}/arch/arm64/include/asm/asm-extable.h" 3
# 20 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/asm-offsets.h" 1 3
# 1 "${srctree}/tools/include/generated/asm-offsets.h" 1 3
# 2 "${srctree}/arch/arm64/include/asm/asm-offsets.h" 2 3
# 21 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/cpufeature.h" 1 3
# 9 "${srctree}/arch/arm64/include/asm/cpufeature.h" 3
# 1 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 1 3
# 1 "/usr/include/linux/const.h" 1 3
# 6 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 2 3
# 1 "${srctree}/tools/include/vdso/bits.h" 1 3
# 1 "${srctree}/tools/include/vdso/const.h" 1 3
# 1 "${srctree}/tools/include/uapi/linux/const.h" 1 3
# 6 "${srctree}/tools/include/vdso/const.h" 2 3
# 6 "${srctree}/tools/include/vdso/bits.h" 2 3
# 7 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/cpucaps.h" 1 3
# 1 "${srctree}/tools/include/generated/asm/cpucap-defs.h" 1 3
# 7 "${srctree}/arch/arm64/include/asm/cpucaps.h" 2 3
# 9 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/insn-def.h" 1 3
# 10 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 2 3
# 88 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 3
# 1 "${srctree}/arch/arm64/include/asm/assembler.h" 1 3
# 89 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 2 3
# 132 "${srctree}/arch/arm64/include/asm/alternative-macros.h" 3
# 10 "${srctree}/arch/arm64/include/asm/cpufeature.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/cputype.h" 1 3
# 12 "${srctree}/arch/arm64/include/asm/cpufeature.h" 2 3
# 1 "/usr/lib/linux/uapi/arm64/asm/hwcap.h" 1 3
# 13 "${srctree}/arch/arm64/include/asm/cpufeature.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/sysreg.h" 1 3
# 13 "${srctree}/arch/arm64/include/asm/sysreg.h" 3
# 1 "${srctree}/tools/include/linux/stringify.h" 1 3
# 14 "${srctree}/arch/arm64/include/asm/sysreg.h" 2 3
# 1 "${srctree}/tools/include/linux/kasan-tags.h" 1 3
# 15 "${srctree}/arch/arm64/include/asm/sysreg.h" 2 3
# 1 "${srctree}/tools/include/linux/kconfig.h" 1 3
# 16 "${srctree}/arch/arm64/include/asm/sysreg.h" 2 3
# 1110 "${srctree}/arch/arm64/include/asm/sysreg.h" 3
# 14 "${srctree}/arch/arm64/include/asm/cpufeature.h" 2 3
# 22 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 1 3
# 1 "/usr/include/linux/errno.h" 1 3
# 1 "/usr/lib/linux/uapi/arm64/asm/errno.h" 1 3
# 1 "/usr/include/asm-generic/errno.h" 1 3
# 1 "/usr/include/asm-generic/errno-base.h" 1 3
# 6 "/usr/include/asm-generic/errno.h" 2 3
# 2 "/usr/lib/linux/uapi/arm64/asm/errno.h" 2 3
# 2 "/usr/include/linux/errno.h" 2 3
# 9 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 2 3
# 1 "/usr/include/linux/types.h" 1 3
# 1 "/usr/lib/linux/uapi/arm64/asm/types.h" 1 3
# 1 "/usr/include/asm-generic/types.h" 1 3
# 1 "/usr/include/asm-generic/int-ll64.h" 1 3
# 12 "/usr/include/asm-generic/int-ll64.h" 3
# 1 "/usr/lib/linux/uapi/arm64/asm/bitsperlong.h" 1 3
# 22 "/usr/lib/linux/uapi/arm64/asm/bitsperlong.h" 3
# 1 "/usr/include/asm-generic/bitsperlong.h" 1 3
# 23 "/usr/lib/linux/uapi/arm64/asm/bitsperlong.h" 2 3
# 13 "/usr/include/asm-generic/int-ll64.h" 2 3
# 8 "/usr/include/asm-generic/types.h" 2 3
# 2 "/usr/lib/linux/uapi/arm64/asm/types.h" 2 3
# 6 "/usr/include/linux/types.h" 2 3
# 1 "/usr/include/linux/posix_types.h" 1 3
# 1 "/usr/include/linux/stddef.h" 1 3
# 6 "/usr/include/linux/posix_types.h" 2 3
# 25 "/usr/include/linux/posix_types.h" 3
# 1 "/usr/lib/linux/uapi/arm64/asm/posix_types.h" 1 3
# 1 "/usr/include/asm-generic/posix_types.h" 1 3
# 15 "/usr/include/asm-generic/posix_types.h" 3
# 59 "/usr/include/asm-generic/posix_types.h" 3
# 72 "/usr/include/asm-generic/posix_types.h" 3
# 10 "/usr/lib/linux/uapi/arm64/asm/posix_types.h" 2 3
# 37 "/usr/include/linux/posix_types.h" 2 3
# 10 "/usr/include/linux/types.h" 2 3
# 31 "/usr/include/linux/types.h" 3
# 55 "/usr/include/linux/types.h" 3
# 10 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/esr.h" 1 3
# 12 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/insn.h" 1 3
# 10 "${srctree}/arch/arm64/include/asm/insn.h" 3
# 1 "${srctree}/tools/include/linux/build_bug.h" 1 3
# 1 "${srctree}/tools/include/linux/compiler.h" 1 3
# 6 "${srctree}/tools/include/linux/build_bug.h" 2 3
# 11 "${srctree}/arch/arm64/include/asm/insn.h" 2 3
# 13 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 2 3
# 1 "/usr/lib/linux/uapi/arm64/asm/ptrace.h" 1 3
# 26 "/usr/lib/linux/uapi/arm64/asm/ptrace.h" 3
# 1 "/usr/lib/linux/uapi/arm64/asm/sve_context.h" 1 3
# 27 "/usr/lib/linux/uapi/arm64/asm/ptrace.h" 2 3
# 14 "${srctree}/arch/arm64/include/asm/debug-monitors.h" 2 3
# 24 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/page.h" 1 3
# 11 "${srctree}/arch/arm64/include/asm/page.h" 3
# 1 "${srctree}/arch/arm64/include/asm/page-def.h" 1 3
# 13 "${srctree}/arch/arm64/include/asm/page-def.h" 3
# 1 "${srctree}/include/vdso/page.h" 1 3
# 14 "${srctree}/arch/arm64/include/asm/page-def.h" 2 3
# 12 "${srctree}/arch/arm64/include/asm/page.h" 2 3
# 67 "${srctree}/arch/arm64/include/asm/page.h" 3
# 1 "${srctree}/include/asm-generic/getorder.h" 1 3
# 68 "${srctree}/arch/arm64/include/asm/page.h" 2 3
# 25 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/pgtable-hwdef.h" 1 3
# 1 "${srctree}/arch/arm64/include/asm/memory.h" 1 3
# 14 "${srctree}/arch/arm64/include/asm/memory.h" 3
# 1 "${srctree}/tools/include/linux/sizes.h" 1 3
# 15 "${srctree}/arch/arm64/include/asm/memory.h" 2 3
# 9 "${srctree}/arch/arm64/include/asm/pgtable-hwdef.h" 2 3
# 26 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 1 "${srctree}/arch/arm64/include/asm/thread_info.h" 1 3
# 28 "${srctree}/arch/arm64/include/asm/assembler.h" 2 3
# 140 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 152 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 181 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 244 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 311 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 345 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 393 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 409 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 422 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 461 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 535 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 582 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 599 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 634 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 789 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 805 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 829 "${srctree}/arch/arm64/include/asm/assembler.h" 3
# 6 "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S" 2
# 43 "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S"
# 8 "vgetrandom-chacha.S" 2
