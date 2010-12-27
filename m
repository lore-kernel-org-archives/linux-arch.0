From: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCHv1 09/12] unicore32 core architecture: timer and time
Date: Mon, 27 Dec 2010 13:27:20 -0800
Message-ID: <AANLkTinjzzMz4WFRYmjZiM=P6c1wtSxpY2bzOuUe0Vrd@mail.gmail.com>
References: <00d601cba465$27154a70$753fdf50$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64478 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0L0V1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2010 16:27:21 -0500
In-Reply-To: <00d601cba465$27154a70$753fdf50$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

2010/12/25 Guan Xuetao <guanxuetao@mprc.pku.edu.cn>:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
>
> Patch 9 implements timer and time. RTC and PWM device drivers are als=
o here.
>
> Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>

Just a small request:

> +static struct clocksource cksrc_puv3_oscr =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "oscr",
> + =A0 =A0 =A0 .rating =A0 =A0 =A0 =A0 =3D 200,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D puv3_read_oscr,
> + =A0 =A0 =A0 .mask =A0 =A0 =A0 =A0 =A0 =3D CLOCKSOURCE_MASK(32),
> + =A0 =A0 =A0 .shift =A0 =A0 =A0 =A0 =A0=3D 18,

Drop the shift assignment here.

> + =A0 =A0 =A0 cksrc_puv3_oscr.mult =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clocksource_hz2mult(CLOCK_TICK_RATE, ck=
src_puv3_oscr.shift);
> +
Drop the mult assignment here.


> + =A0 =A0 =A0 clocksource_register(&cksrc_puv3_oscr);

Use "clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE );" and
the kernel will fill in mult/shift appropriately.

If you have any troubles after doing so, let me know.

thanks
-john
