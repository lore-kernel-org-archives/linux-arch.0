From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in module versions
Date: Mon, 21 Feb 2011 14:25:58 +0100
Message-ID: <AANLkTin_vp=+G+AMsfRtet9aWFc4MQnRC_bFZOovvFyg@mail.gmail.com>
References: <AANLkTi=nQ4c6fgk9_-974QOu=kQkJiGpdzpOa_U6ZZcs@mail.gmail.com>
	<20110217.140119.39175251.davem@davemloft.net>
	<20110217221957.GA11244@dtor-ws.eng.vmware.com>
	<20110217.142320.102554706.davem@davemloft.net>
	<AANLkTinMfTss+9K7fPQbxoMD7d-U_AyCc29_RRPRija3@mail.gmail.com>
	<AANLkTikd-OBhe6-wK7-Xvv-asNSeVKs+0-a0d3FF2KVu@mail.gmail.com>
	<1298074455.2460.85.camel@pasglop>
	<87pqqmrq9q.fsf@rustcorp.com.au>
	<AANLkTinFgma3F7ETwC8Mho7wdDK4V2b+Ao__npJNAW8j@mail.gmail.com>
	<20110221074947.GA31152@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20110221074947.GA31152@dtor-ws.eng.vmware.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 21, 2011 at 08:49, Dmitry Torokhov <dtor@vmware.com> wrote:
> On Mon, Feb 21, 2011 at 08:38:46AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Feb 21, 2011 at 05:00, Rusty Russell <rusty@rustcorp.com.au>=
 wrote:
>> >> Except that .long is 32-bit on ppc64 :-( You need .llong for 64-b=
it.
>> >
>> > OK, all options suck. =C2=A0Do we want the workaround or not?
>>
>> We can discuss about that until someone gets bitten by that.
>>
>> But please fix the "aligned(sizeof(void *))"-in-one-place-only issue=
=2E
>>
>
> How about this one then?

Works.

> From f0e0e10b58b22047e36e21a022abf5e86b5819c2 Mon Sep 17 00:00:00 200=
1
> From: Dmitry Torokhov <dtor@vmware.com>
> Date: Fri, 4 Feb 2011 13:30:10 -0800
> Subject: [PATCH] module: explicitly align module_version_attribute st=
ructure
>
> We force particular alignment when we generate attribute structures
> when generation MODULE_VERSION() data and we need to make sure that
> this alignment is followed when we iterate over these structures,
> otherwise we may crash on platforms whose natural alignment is not
> sizeof(void *), such as m68k.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Torokhov <dtor@vmware.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> =C2=A0include/linux/module.h | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index e7c6385..de5cd21 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -62,7 +62,7 @@ struct module_version_attribute {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct module_attribute mattr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *module_name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *version;
> -};
> +} __attribute__ ((__aligned__(sizeof(void *))));
>
> =C2=A0struct module_kobject
> =C2=A0{
> --
> 1.7.3.2

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
