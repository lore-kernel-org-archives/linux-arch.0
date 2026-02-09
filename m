Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8C25DB1C
	for <linux-arch@vger.kernel.org>; Mon,  9 Feb 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648334; cv=none; b=NtVB3jHE9MaNh1GafA2FKj3YmXuNgbktFxGa4fW5tpU6gz7EdqrQnW6355N3orjpljser5NwtFwjaSHs6kGpXeC3oXQcBECLKYHnDQxKuvFukWOMc7FUc18ld4StazxUBpWPxqrpQEo0DXBsK6TVR3eKeQMnpVux2FCgV8auR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648334; c=relaxed/simple;
	bh=lnea5oMgDhXPq3RO/2D5ZmMT5yjHA59qkqcs4AJrbZ4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aMzZYJ8USUP0OjWzNwEZGxOLGyRht201f1thAltXmRUG25JILzhS9XW9tDwlXV7B/hlf/TaMfmqsyt3/VbrQrEv8nRde2V/iahQ7Y60Ckh4A8ZcRkNIM5IOMw1ieV6z4vxPM43+/0j00iS2Rw6jJTz/CHAMNulz8tbVR/xpG0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=philipmolloy.com; spf=pass smtp.mailfrom=philipmolloy.com; dkim=pass (2048-bit key) header.d=philipmolloy.com header.i=@philipmolloy.com header.b=cmVe1uus; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philipmolloy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="cmVe1uus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
	s=protonmail; t=1770648322; x=1770907522;
	bh=lnea5oMgDhXPq3RO/2D5ZmMT5yjHA59qkqcs4AJrbZ4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cmVe1uus9lnKmDnYIhc8GRR/WbsIX/pW1aWjK+zPDN/JsY9yFe6QDJSjiXfrsJ5yz
	 a4EgcRBDc+5wTPuyjuWneWEViQCwf56PICBIweWXDWbXGVyObjz9O8zDSM/S+O0Po3
	 rlIFOPnTZzqFXS9zq0Jf4EAwEsivbF1aO3L8r/CtDWDD+68rBI/fHhGB+5j69RSpfx
	 iwKeDdxGwHIsgys3stC3hZclw7Vef8mVqpor8YQcvVkcdeALdYEFcHah7YkWwvjvS5
	 donoN9168BiSrQhsffHLsDhW0lx1msGmKiimZtC+6TWoTHNr/LqMq63FWvPpO7dFY9
	 tNWEj+0M/MdGg==
Date: Mon, 09 Feb 2026 14:45:19 +0000
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
From: Philip Molloy <philip@philipmolloy.com>
Cc: "linux@analog.com" <linux@analog.com>, Philip Molloy <philip.molloy@analog.com>, Greg Malysa <malysagreg@gmail.com>, Arnd Bergmann <arnd@linaro.org>
Subject: [RFC] Naming convention for Analog Devices ADSP SoC support
Message-ID: <Vz-23fFGsZWIiHL9un3f6bosyPElJf6hnyRM6QOsbT3p4xWpTcncCn9hIa_JmHSR47ZbJD8fTQGdhIermxH2GV4p1dxTdmt2CzKCCsuMbrE=@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: cc0dd2c92a0ceff695a5afcad0addb45fd08ef72
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

At ADI, we are trying to mainline support for our DSP SoCs. Starting with t=
he single Cortex-A55 ADSP-SC598. Note the SC* stands for SHARC Connect, whe=
re SHARC is the DSP core architecture.

Unfortunately, the SoC part naming is somewhat complicated:

https://analogdevicesinc.github.io/documentation/products/adsp/index.html#i=
d1

For example, SC57x, SC58x, SC592 and SC594 are 32-bit, while SC596 and SC59=
8 are 64-bit. An unreleased SoC will be very similar to the SC598, but does=
 not follow the SC5xxx pattern as it uses a different digit instead of the =
5.

We're considering the following options:

1. adsp-sc: A generic prefix representing the "SHARC Connect" family (e.g. =
drivers/clk/adi/clk-adsp-sc.c, compatible =3D "adi,adsp-sc-uart")
2. sc5xx: Sticking with the current prefix, even for the 8-series chips, as=
 one would for a driver
3. scxxx: Using 'xxx' as a wildcard for the 3-digit model series
4. adsp-scxxx: Perhaps the most accurate option, but rather long for a pref=
ix

Feel free to take a look at our tree, but note there is a lot of work to do=
 before submission:

https://github.com/analogdevicesinc/linux/commits/adsp-6.12.0-y/

We already have support mainline in U-Boot.[1] And expect to have to update=
 it accordingly. In U-Boot it is a bit easier because there isn't the same =
distinction between arm and arm64.

Thanks in advance!

Best regards,
Philip Molloy

[1]: https://github.com/u-boot/u-boot/tree/master/arch/arm/mach-sc5xx

