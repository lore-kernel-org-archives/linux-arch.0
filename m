From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND v3 03/24] ptrace: change signature of arch_ptrace()
Date: Mon, 4 Oct 2010 21:21:24 +0200
Message-ID: <AANLkTik1TKERMvPT=p7wQhqmgG6ucX08o3dDZUQMM5vF@mail.gmail.com>
References: <1285838880-4977-1-git-send-email-namhyung@gmail.com>
	<1285838880-4977-4-git-send-email-namhyung@gmail.com>
	<20100930.115828.57462004.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411Ab0JDTVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Oct 2010 15:21:31 -0400
In-Reply-To: <20100930.115828.57462004.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: namhyung@gmail.com
Cc: akpm@linux-foundation.org, roland@redhat.com, oleg@redhat.com, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Sep 30, 2010 at 20:58, David Miller <davem@davemloft.net> wrote=
:
> From: Namhyung Kim <namhyung@gmail.com>
> Date: Thu, 30 Sep 2010 18:27:38 +0900
>
>> Fix up the arguments to arch_ptrace() to take account of the fact th=
at
>> @addr and @data are now unsigned long rather than long as of a prece=
ding
>> patch in this series.
>>
>> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
>> Cc: linux-arch@vger.kernel.org
>> Acked-by: Roland McGrath <roland@redhat.com>
>> Acked-by: David Howells <dhowells@redhat.com>
>
> Acked-by: David S. Miller <davem@davemloft.net>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
