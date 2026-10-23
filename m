Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764507;
	b=MsuiY8l7WNIx0yBLGf9SV0sPx5U3KsVTqh0JDxSCmng3F7OminNhHTfMA6Qa12JE+MQC
	 iYIj6a7YgQf7bHI+yeGmbxCBZP36/C3UwQIVnroC6nJoBq3F3C0k/EdEztjZBYL4Xriw4
	 lD18ljapcjsrzIVGChyC0KQJVOQTm6h1q865N8XU3dxAv/hcfpwTrPwIKdd6nhWA06SuS
	 F6SDivdTVsLgnrQH1bWzdiX/U0TqHq2K5giwZFg8ReMuJIyLc7yHgFa6NGtWrKiqUZJLg
	 ig2Nvo7vZobaNEULwENL6z9nr18swmoGYEoSiwIJdCQJK2X2tfXYdwPq236DyNIEH2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tv8jBDwPfWPUczVVh5JF7DB2eeI41qRyApK4ect9U6E=;
	b=YVPS2WB1dj5UGv9CWC2Y2m3S1km/tEv0GREGbcw45DzwybzgnewfjVmwn2kFlGHq2qtc
	 UWuI2WIj9KMOw3HyfJuskfGmlhnnqYoJIB2aG3Z74Bkop+Qtlg4LMQ29+dAUYHa7bItp9
	 ynxK2TtMzBY6zKV+G2ZaGRXK+zq7tgzxySj0J9gdnnvva64iZCd65+kP0Bu+3wURHWyUs
	 ppmEB2RZ+/QZRSp8QPCs+4MU8erQOrIkaPx+lmx/+L1pbDRugeX9R2k2EEEymSbObzLgt
	 LkfoRipPx7OSYfr5cDofvDeKHjVUxzHKlqPBed81vXtvEjWwRyfiumON0Og5UUq8QEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BavTgEbc;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68167606A31A
	for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 14:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68167606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BavTgEbc
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a089dfee18so1114684b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764507; x=1793369307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tv8jBDwPfWPUczVVh5JF7DB2eeI41qRyApK4ect9U6E=;
        b=BavTgEbcw5Ftd4vmcFPPbbrH36zuOVeC+iDr8FEDLdCuhuOeRGtlO0oXKg4liq59Cr
         WTfSaNh3D3Fo5dAdwLjUp1PkBkqphJCETgzA0NBYTZ/IVVVZz1pHtH3UkiqJqwnlzWi5
         gTjVLp/iGkpWJArOs3jp0phr5FM5FyoqbwflJgWgljFKVRxseeDNNGFgOpRw7NB9xn9w
         BHUSyri8TRWcEn2+Z+gH7hIRhfZBCDr82hpRWxl7v6kx/2FG84Pb6HhjGsPkBydZtg3z
         EiRPVoJDkFD01jj/UimXzWCJrVEKAPVdLODLOe4jRoe/JQqcdeMPfCbMgCbOfwfe/n42
         z6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764507; x=1793369307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tv8jBDwPfWPUczVVh5JF7DB2eeI41qRyApK4ect9U6E=;
        b=p8Zoqm3GsLURfIV0eWxGfEJNgD9k/acTjE+qg3r8gV9Fp5srBLtAnE0uaRzvOrTvw4
         69tCsszWb70HdTWnrCDFNZz0EfVO0isEu56raLoswlEPwD5C7Ecp0I8AJaP5am92aZvx
         6k3xaJJ6Al4/143TNszKn/BLRATXzjKRzqEaNgWFisd7AaWUAItB0ASDTxZD/h/3pavy
         chJENosjATUV7/leAVv16PMuTJ4V5YDDjkNcFnz28eoWk9ev3Fy+WczpD0fXPgGEEzHZ
         0oj0dDwwHoemKJAreMp5T6sYNWUXPKGkeAuJneeLUeq6aL4EHDQwodvOsBa/eSjBSgcF
         r3Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzw3ej3zTohUMOrkMdcJ9TK8GLQkC5ZbnADP7oFOK/F3us6dGUI37MmaelkR320DpgRut2kmajXeoTt@vger.kernel.org
X-Gm-Message-State: AFq9FYIGlOxp+guvGieMuEKBMlpFsaVJ3CJYwQNN86PPQ1mL5C8mCtnt
	V0KF6lua9mZ9Pmv7T42LJF99tndhmIw18vAjxw+up2xA/9SDs2V0kS4E
X-Gm-Gg: AYBFou3pDZZ2p6ZN5+mMRCslQIEm2ue99R+dgrbDD+GWRMxEDQ2xYyfBg78QgjuvJHE
	U9gBU45eWcJs/OuqJ0w41AtiblLfUgJApNDzgH3pw7X1Ecco3QSOkBm2c5W85SRCc7qeAcbwSOy
	teICMTsqAiT2fGCUxxHLq0ZXlBLFerYCKhJwPfxNHb0zaAmZPYQuT4qFl0F4sMe0XJmD0I+7k/R
	/OZFmOKsi2iOiS+KD96dFFFHR3hBmd3zihE8iVaySK//Sjkj4glEJOEVmMzwI3CwgoNPHIPkzfv
	kwuLSjGvIZesvWVnyjalHszke2Qpp88SMDDNdMmlB2NAOH/sLLrecqwvEzutvJ8nYLkZYV4sGuz
	18MaWBFj51h0jhXYlaDtK89K8Km38RJ3VcOxmJr5/CkNyzbYlf6gQTD62ApIrCy+buGEPDm7gts
	G7mG4Bl+t9sTlak3EmvRvCJtd4NWy7cDaM17JNprdVwYgEo6byd9mD4vu+ifRmWE4BKQEiO8ItO
	DLRs77qEXAcgujZjSSpbuOEczanrNsBhf0Nnl34sv9QbG576LKwGm2kq6hK
X-Received: by 2002:a05:6300:86:b0:3de:3f4d:f2bd with SMTP id adf61e73a8af0-3e359a4186fmr1313009637.6.1792764506480;
        Fri, 23 Oct 2026 07:08:26 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a338ef8352sm6443b3a.28.2026.10.23.07.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:08:25 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Date: Fri, 23 Oct 2026 22:08:06 +0800
Message-Id: <20261023140806.1367050-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atpm00m6KYhXo6Wi@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com> <atpm00m6KYhXo6Wi@yury>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 03:41:07PM -0400, Yury Norov wrote:
> So I didn't understand if you have an access to the hardware or not. I
> don't know the story behind using the non-generic version of ffl(),
> but it may be for performance reasons. Can you / someone else please
> run the lib/find_bit_benchmark.c on real hardware before we move this?

No, I have no csky hardware; all run-time tests were under XuanTie's
QEMU.

The ff1 asm is in fls(), which the patch keeps. __fls() has been a C
wrapper around it, fls(x) - 1, since the 2018 port (735ee005c371), with
no reason recorded. The builtin compiles to the same ff1: 4
instructions before and after with every GCC 9 to 16 and CPU tested,
so __fls() itself is neither faster nor slower. The gain is elsewhere:
the builtin folds constant arguments and merges repeated calls, which
saves 128 to 320 bytes of text. It is the csky part of the conversions
Arnd suggested in the ffs()/fls() thread (the Link: in the patch).

In lib/find_bit_benchmark.c only find_last_bit() reaches __fls(); the
other six tests use the unchanged __ffs() asm. _find_last_bit() is 27
instructions with one ff1 before and after with GCC 10 to 16 (28 -> 27
with GCC 9), and under QEMU with -icount it executes the same number of
instructions per call before and after with GCC 12 and 16, one fewer
with GCC 9. QEMU has no pipeline model, so a real core could still
differ.

Guo Ren, or anyone with a CK8xx board: could you run the benchmark
(CONFIG_FIND_BIT_BENCHMARK=y) before and after? I'm happy to wait.

Thanks,
Tzu-Ching
