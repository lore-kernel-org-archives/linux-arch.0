From: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Sat, 04 May 2013 17:54:37 +0200
Message-ID: <51852F3D.5000802@dawncrow.de>
References: <517168BB.3070903@dawncrow.de> <20130422143616.GP14496@n2100.arm.linux.org.uk> <20130422151836.GA15665@mudshark.cambridge.arm.com> <5175A697.3080308@dawncrow.de> <20130423091536.GB17593@mudshark.cambridge.arm.com> <51770E4E.2040003@dawncrow.de> <20130424094251.GA21850@mudshark.cambridge.arm.com> <5182C480.3080001@dawncrow.de> <5183819E.50308@arm.com> <20130503095547.GD18614@n2100.arm.linux.org.uk> <5183D6C3.8090402@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58737 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569Ab3EDPzJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 4 May 2013 11:55:09 -0400
In-Reply-To: <5183D6C3.8090402@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Am 03.05.2013 17:24, schrieb Jonathan Austin:
> Hi Russell,
>=20
> Thanks for the comments - you're right about the 'switch_tls'
> being more appropriate - needed to take a step back to see that.
>=20
> I've got a few questions, added inline.
>=20
> Andr=C3=A9, Assuming I've understood things okay, there's a patch tha=
t
> uses Russell's asm stuff (with minor modifications, see the questions=
)
> and includes the C-world changes too. Perhaps you could see that it
> solves your problem?

I'll test it tomorrow with my test tool and Wine.
=46WIW i hacked together a test tool and it's available at https://gith=
ub.com/AndreRH/tpidrurw-test
