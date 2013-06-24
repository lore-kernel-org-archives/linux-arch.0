From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for aarch32_break_handler()
Date: Mon, 24 Jun 2013 17:19:46 +0800
Message-ID: <51C80F32.4060500@asianux.com>
References: <51C53C06.7050205@asianux.com> <20130624084744.GA23779@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:35394 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab3FXJUl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 05:20:41 -0400
In-Reply-To: <20130624084744.GA23779@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Tony Lindgren <tony@atomide.com>, "olof@lixom.net" <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/24/2013 04:47 PM, Will Deacon wrote:
> On Sat, Jun 22, 2013 at 06:54:14AM +0100, Chen Gang wrote:
>> >=20
>> > If 'COMPAT' not defined, aarch32_break_handler() cannot pass compi=
ling,
>> > so need add '#ifdef' for it just like the header file has done.
>> >=20
>> > The related make:
>> >=20
>> >   make ARCH=3Darm64 randconfig
>> >   make ARCH=3Darm64 menuconfig
>> >   make ARCH=3Darm64 V=3D1 EXTRA_CFLAGS=3D-W
>> >=20
>> > The related error:
>> >=20
>> >   arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of=
 =E2=80=98aarch32_break_handler=E2=80=99
>> >   In file included from arch/arm64/kernel/debug-monitors.c:29:0:
>> >   /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: =
note: previous definition of =E2=80=98aarch32_break_handler=E2=80=99 wa=
s here
> Actually, can we just kill the static definition in debug-monitors.h
> instead? I don't see anything in the full-blown aardch32_break_handle=
r that
> won't play nicely if !COMPAT.

It sounds good, I will send patch v2.

Thanks.
--=20
Chen Gang

Asianux Corporation
