From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] persistent store
Date: Mon, 22 Nov 2010 19:24:12 +0100
Message-ID: <AANLkTimqn+qS5RxETz1DznsMDS4gZBGxkLkdCgTQ7qG-@mail.gmail.com>
References: <4ce85e437577ae827@agluck-desktop.sc.intel.com>
	<1290391175.2903.132.camel@yhuang-dev>
	<AANLkTi=fNH4-VjLh1zzk-UdEQevR16_K8igdLeodw6yL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39553 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0KVSYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2010 13:24:14 -0500
In-Reply-To: <AANLkTi=fNH4-VjLh1zzk-UdEQevR16_K8igdLeodw6yL@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Huang Ying <ying.huang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Linux Embedded <linux-embedded@vger.kernel.org>

On Mon, Nov 22, 2010 at 17:55, Tony Luck <tony.luck@intel.com> wrote:
> On Sun, Nov 21, 2010 at 5:59 PM, Huang Ying <ying.huang@intel.com> wr=
ote:
>> This patch provides a general "read" interface for kmsg_dumper and s=
ome
>> other persistent storage users. Another possible choice is to just
>> extend the original interface to add persistent store support. For
>> example, we can add a "read" function in kmsg_dumper, and output the
>> content of persistent store via extend /dev/kmsg via prefix every li=
ne
>> comes from persistent store or adding some "ioctl" to do that. (But =
it
>> seems that nobody likes "ioctl").
>
> In Linux (and Unix before it) "everything is a file" ... but this
> doesn't work very well if the file has internal structure (e.g.
> is made of records that can be individually changed or
> deleted). =C2=A0A filesystem seems a much better model.

Any tangents with "pramfs: persistent and protected RAM filesystem"
on linux-embedded?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
