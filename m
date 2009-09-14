From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH 11/11] Use unreachable() in asm-generic/bug.h for
	!CONFIG_BUG case.
Date: Mon, 14 Sep 2009 19:12:45 -0400
Message-ID: <73c1f2160909141612i32f46361q7430cecf0b68d07b@mail.gmail.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
	 <1252965340-31735-11-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:56910 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbZINXRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2009 19:17:52 -0400
In-Reply-To: <1252965340-31735-11-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Mon, Sep 14, 2009 at 5:55 PM, David Daney <ddaney@caviumnetworks.com=
> wrote:
> The subject says it all (most). =C2=A0The only drawback here is that =
for a
> pre-GCC-5.4 compiler, instead of expanding to nothing we now expand
> BUG() to an endless loop. =C2=A0Before the patch when configured with
> !CONFIG_BUG() you might get some warnings, but the code would be
> small. =C2=A0After the patch there are no warnings, but there is an e=
ndless
> loop at each BUG() site.
>
> Of course for the GCC-4.5 case we get the best of both worlds.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Ingo Molnar <mingo@elte.hu>
> CC: Ingo Molnar <mingo@elte.hu>
> ---
> =C2=A0include/asm-generic/bug.h | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 4b67559..e952242 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -89,11 +89,11 @@ extern void warn_slowpath_null(const char *file, =
const int line);
>
> =C2=A0#else /* !CONFIG_BUG */
> =C2=A0#ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while(0)
> +#define BUG() unreachable()
> =C2=A0#endif
>
> =C2=A0#ifndef HAVE_ARCH_BUG_ON
> -#define BUG_ON(condition) do { if (condition) ; } while(0)
> +#define BUG_ON(condition) do { if (condition) unreachable(); } while=
 (0)
> =C2=A0#endif
>
> =C2=A0#ifndef HAVE_ARCH_WARN_ON
> --

This seems wrong to me.  Wouldn't you always want to do the endless
loop?  In the absence of an arch-specific method to jump to an
exception handler, it isn't really unreachable.  On gcc 4.5 this would
essentially become a no-op.

--
Brian Gerst
