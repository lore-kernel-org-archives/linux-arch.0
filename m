From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/17] Drop a couple of unnecessary asm/system.h inclusions
Date: Mon, 13 Sep 2010 19:59:44 +0200
Message-ID: <AANLkTikpv5OhESRUbQ5f3MqwD0UgO2BrRLGjK1ricv42@mail.gmail.com>
References: <20100910161002.20226.27995.stgit@warthog.procyon.org.uk>
	<20100910161038.20226.59718.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39986 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab0IMR7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2010 13:59:46 -0400
In-Reply-To: <20100910161038.20226.59718.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>

On Fri, Sep 10, 2010 at 18:10, David Howells <dhowells@redhat.com> wrot=
e:
> Drop inclusions of asm/system.h from linux/hardirq.h and linux/list.h=
 as
> they're no longer required and prevent the M68K arch's IRQ flag handl=
ing macros
> from being made into inlined functions due to circular dependencies.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>
> =C2=A0include/linux/hardirq.h | =C2=A0 =C2=A01 -
> =C2=A0include/linux/list.h =C2=A0 =C2=A0| =C2=A0 =C2=A01 -
> =C2=A02 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index d5b3876..7dfdc06 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -8,7 +8,6 @@
> =C2=A0#include <linux/lockdep.h>
> =C2=A0#include <linux/ftrace_irq.h>
> =C2=A0#include <asm/hardirq.h>
> -#include <asm/system.h>
>
> =C2=A0/*
> =C2=A0* We put the hardirq and softirq counter into the preemption
> diff --git a/include/linux/list.h b/include/linux/list.h
> index d167b5d..88a0006 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -5,7 +5,6 @@
> =C2=A0#include <linux/stddef.h>
> =C2=A0#include <linux/poison.h>
> =C2=A0#include <linux/prefetch.h>
> -#include <asm/system.h>
>
> =C2=A0/*
> =C2=A0* Simple doubly linked list implementation.

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
