Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFB26D4E5;
	Fri, 17 Jul 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279195; cv=none; b=Jyir0SloL1XoyYjzZyumCBY6yC46Gdy8E5qpJejGeNJuamWIkWBtvtuGvB1DoZvn8EzkpwjE1upTOoZ/z6SZOT4gVIrkt/3h+w4siCacDP9dramBo1/geE5FunGV9NT1QGdH9TZ4/GvZftjNn9TvSZX41FC9gQdLpjV7/1YgRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279195; c=relaxed/simple;
	bh=KE3QX976Kpj+F2n+JYpUeIxuvmpafrvqu8fs5K89TOU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NTWmp/v7nGzg+TRin+EawHgdxljg4fzJBwlo7fkE+dhnfJKMwpR4TTXFmi7szd9hc8Fsovr9EiX806Yodu/zMPdwQ9x2YPgnWus+N5Bom1y87sbSivxurfc2mPFMT//QpmsBZk9c8vpssIrNvaVp19vmzbliharWxkPUD+ejUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HoZl6itz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gw/7Z6oD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HoZl6itz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gw/7Z6oD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 054217A0016;
	Fri, 17 Jul 2026 05:06:25 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 05:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784279185;
	 x=1784365585; bh=LlDa0Fu04Q/NnrWy6OLv0XZLlKSyxvhPTWEKtAmZh3U=; b=
	HoZl6itz54HqZkMl2bfbvIqeRyNTwH5QYvpWfZNeX/ZHbx3OgKaYFMDWvfDmVCMu
	DYb1/uw4r9iUAThofmqVFiD1lE3Wj/D/rGXRVX5BZlbNSlKc1YChCfJzByKTfMW1
	PZ02pKZB1EvkcVvJZPjkPKbPfs4WRFoqQ2yUg/iAAbyJTWXxPRDpeIjcBdUipWZQ
	TCU8iACnBt1UuYGTMPRkUh1MoJHaqyUVZNbOBdPXWpfyf17yoz4AcqHXg97bhx9b
	NSQW0I5kfVmlPVMa1RPwuzKThFbHH0+ya8RvaHCHbzQYi8WZVtbrIAvKKhZqD/rR
	E2nOqQ8gIKN3eWMRegNT7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784279185; x=
	1784365585; bh=LlDa0Fu04Q/NnrWy6OLv0XZLlKSyxvhPTWEKtAmZh3U=; b=G
	w/7Z6oD35xSMMmbTUQ32+LWnS9aS4imA/FPDePE09knt8VBpa/exWOp1qGGLuF6z
	/r6YN1DegwKVBD0HAPvLRLRdp/M771Vi9HlVV+SzqZdNerXf6WI5S5kxFTFHynqM
	kjpD8ACkmSaG/xEG5+hnL3Ge2DRB0wEWDAqvmWrNjMM8N3pF1aVLkLXjLuEbXG7A
	pjr3aAl3b2Pnl9axJ+ahar3tM9mRTvbOdPCNJg2+QpuKIohJ43E6U1bDHmhs1QLo
	PSyrs3/CvpnI3RmlEI6cmc6eZrSnK/y/HHpGBOz1jxWeSgct/QG14TCIDBUC+Ukq
	5sLZ6kUiXeNwEsgLnoaNg==
X-ME-Sender: <xms:kPBZaup_2PtCRZz7SCm17JHITRWvb7AKbRTVK8FfLkIyzZBywY0Obw>
    <xme:kPBZaneGYXGDY_mvZODIqQXt69kSnsHrLC4B2dMn_-8icOlFM3KObtbYTnW424Nae
    BMmUOp0HvY3G0PhUN_YyZZfrs8rDbP6tPG45mmpD0hO6dDkMzt3d4ZR>
X-ME-Proxy-Cause: dmFkZTE7fHuzxFsHkJbiX6aWFgH4Up5EldSuRsnAR24TqKMw3VdC31TYFTUEQX0p7cgjjL
    r1bZcb0gQX6jfv+sJHaq2UXeeynpRFdpSQ2w6ggZ1yXKeiSeIfRe6CpjTnl1FR8RdSFSwU
    ncgA3/xBZ2xBtOax0jMByfuP98rd/70UBwLX245yQaDGXIFr3nWkPWQhzmKYUOUueaY0O3
    LkUE5LmFoKNbf2nCkkD7+Ncsuhy+rwRizmt0Mfbalp1enc3uV8qzgvDszb89s4l5du0O7+
    t0a+PLLl24pxl8WxPmeEezJ/MhzxkyKqAsyiKwqd88kpzppQ1k2R5QzznrOisb9G3JThNz
    3Gyo5ZtxnxNPyoX1QSc5Dr29pm8+TkXoDLkdxlGpWBsDtEOymVtc/12xHxSFaqWHFhgOUg
    tyTezKeGqz10bc5qnT4XaKxlXznMyi2j3zdSKdIc1tIBvURlP97F2dqsiLPQ9tr/o0AZ3o
    gvgdA7xWTB0IAUDG5KqOpV8k+kPtdY0P2bpGGryPRAmZjxViz7kbU5FNF8ET5fxmG4KBIq
    u4NgoxT05sQis5gFWnpJajuJCMktE9EPPG4/Z7AXX4YGu/0QXxJXuAZpD5joTi9ClF8jNT
    nk+Dt2B74q14uog9fbGrR0hR3fMgoXqroHJ0SVssLFcKtcNOYUS+m/iQ4/Nw
X-ME-Proxy: <xmx:kPBZatIAEWhMRh3MyKj48Gi_1JR8QPdaiodVQZwQyAOWwMk3H8i03g>
    <xmx:kPBZalvsXevFXpHbel36sB0MS9CWTv8Vze53oa0eQMxjmc9prZ-tyA>
    <xmx:kPBZaqKd4dqvu5AHLlZwSXuBw11-HsBXvHwehKwCSvOz8OMllGehLQ>
    <xmx:kPBZalOrfOO59EFgTQhrcsmrkvr6aj7HjEwDpi61o_Qa7HBw8ezILA>
    <xmx:kfBZagl7M_3R0-dTsTNhaI-bglpXtWUNVSFFkZComeKgyFqZ6ydAyVZC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32504182007E; Fri, 17 Jul 2026 05:06:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2dpAyAHcdFo
Date: Fri, 17 Jul 2026 11:06:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <962ac8f0-a7fc-4a80-ac3d-aeaff82d34d3@app.fastmail.com>
In-Reply-To: <20260717073149.3622-3-thorsten.blum@linux.dev>
References: <20260717073149.3622-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] x86/serial: Use generic BASE_BAUD in asm/serial.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2026, at 09:31, Thorsten Blum wrote:
>  /*
> - * This should not be an architecture specific #define, oh well.
> - *
> - * Traditionally, it just describes i8250 and related serial ports
> - * that have this clock rate.
> + * Default base baud for i8250 and related serial ports using a
> + * 1.8432 MHz UART clock.
>   */

You remove the important bit here, which is that we shouldn't need
the definition in the first place.

Among the current references

arch/arc/include/asm/serial.h:#define BASE_BAUD arc_early_base_baud()
arch/arm/mach-omap1/board-ams-delta.c:          .uartclk        = BASE_BAUD * 16,
arch/loongarch/include/asm/serial.h:#define BASE_BAUD 0
arch/openrisc/include/asm/serial.h:#define BASE_BAUD (cpuinfo_or1k[smp_processor_id()].clock_frequency/16)
arch/powerpc/include/asm/serial.h:#define BASE_BAUD ( 1843200 / 16 )
arch/powerpc/kernel/legacy_serial.c:    u32 clock = BASE_BAUD * 16;
arch/x86/boot/early_serial_console.c:#define BASE_BAUD (1843200/16)
arch/x86/boot/early_serial_console.c:   return BASE_BAUD / quot;
arch/xtensa/platforms/iss/include/platform/serial.h:#define BASE_BAUD 0
arch/xtensa/platforms/xt2000/include/platform/serial.h:#define BASE_BAUD ( DUART16552_XTAL_FREQ / 16 )
arch/xtensa/platforms/xtfpga/include/platform/serial.h:#define BASE_BAUD (*(long *)XTFPGA_CLKFRQ_VADDR / 16)
drivers/tty/serial/earlycon.c:          port->uartclk = BASE_BAUD * 16;
include/asm-generic/serial.h:#define BASE_BAUD (1843200 / 16)

the only thing actually using it is the earlycon="..." command line
parsing. As far as I can tell, everyone sets it to the generic
value, except for loongarch/xtensa-iss using 0 to make 8250-early not
override the default from the boot loader and arc/openrisc trying
to do runtime detection. The arc/openrisc case can probably be fixed
by just defining the clocks correctly in the dts files and using
chosen/stdout-path instead of the open-coded earlycon settings.
There is probably also a better solution to deal with the
BASE_BAUD=0 case in an architecture-independent way.

I should also dig out my old series that turns the architecture
specific SERIAL_PORT_DFNS macro into a regular driver.

     Arnd
