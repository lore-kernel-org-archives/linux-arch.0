From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Mon, 27 Jun 2011 11:25:23 +0200
Message-ID: <BANLkTinmhQT=__WP+10cr2HZPy1TvdxZ=w@mail.gmail.com>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se>
	<20110625100449.GA19097@elte.hu>
	<1308998367.6699.30.camel@localhost>
	<201106251508.50129.arnd@arndb.de>
	<87hb7b7ic6.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58126 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab1F0JZY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 05:25:24 -0400
In-Reply-To: <87hb7b7ic6.fsf@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Jun 27, 2011 at 11:07, Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
> On Sat, 25 Jun 2011 15:08:49 +0200, Arnd Bergmann <arnd@arndb.de> wro=
te:
>> On Saturday 25 June 2011, Jonas Bonn wrote:
>> > On Sat, 2011-06-25 at 12:04 +0200, Ingo Molnar wrote:
>> > > Also, and more importantly, don't we generally do such things vi=
a
>> > > __weak aliases, because the result looks cleaner and needs no ch=
anges
>> > > for architectures beyond the removal of the generic functions? W=
e
>> > > have excluded broken toolchains that miscompile/mislink __weak I=
IRC
>> > > so __weak ought to work.
>> >
>> > When we discussed this briefly yesterday, both Rusty and Arnd show=
ed a
>> > preference for not using __weak aliases... I'll leave it to them t=
o
>> > comment further.
>> >
>> > The alternative patch that just provides __weak implementations fo=
r
>> > these hooks is much less invasive than the patch I sent, effective=
ly
>> > touching only kernel/module.c
>> >
>> > Let me know which is preferable.
>>
>> I don't care much either way, you would get my Ack for both solution=
s.
>> The __weak approach would definitely make a simpler patch, and the
>> patch you sent adds extra complexity because of the
>> asm_generic_moduleloader_hooks macro you used to avoid having to
>> change all other architectures.
>
> I think you misread me. =C2=A0If all else is equal, I dislike weak fu=
nctions.
> But AFAICT the two standard mechanisms are #ifdef HAVE_ARCH and __wea=
k.
> Inventing a third one is not going to be a win.

It's not inventing a new one, the third one is already in use.

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
