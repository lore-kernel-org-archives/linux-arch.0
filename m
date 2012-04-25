From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] bug: completely remove code of disabled VM_BUG_ON()
Date: Wed, 25 Apr 2012 16:40:32 +0200
Message-ID: <CAMuHMdW7eQh8eaNZrwRHqduPYCjNXv+LriZoH6-ERdkHH2qL8g@mail.gmail.com>
References: <20120425112623.26927.43229.stgit@zurg>
	<20120425112629.26927.21609.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40318 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2DYOke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 10:40:34 -0400
In-Reply-To: <20120425112629.26927.21609.stgit@zurg>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, Apr 25, 2012 at 13:26, Konstantin Khlebnikov
<khlebnikov@openvz.org> wrote:
> Even if CONFIG_DEBUG_VM=3Dn gcc genereates code for some VM_BUG_ON()

That's because of the side effects of the expression

https://lkml.org/lkml/2012/4/25/146

But IRIC, we do want them here?

> bloat-o-meter: add/remove: 0/1 grow/shrink: 10/120 up/down: 185/-1889=
 (-1704)
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> ---
> =C2=A0include/linux/mmdebug.h | =C2=A0 =C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index c04ecfe..9c9a2a0 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -4,7 +4,7 @@
> =C2=A0#ifdef CONFIG_DEBUG_VM
> =C2=A0#define VM_BUG_ON(cond) BUG_ON(cond)
> =C2=A0#else
> -#define VM_BUG_ON(cond) do { (void)(cond); } while (0)
> +#define VM_BUG_ON(cond) unused_expression(cond)
> =C2=A0#endif
>
> =C2=A0#ifdef CONFIG_DEBUG_VIRTUAL

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
