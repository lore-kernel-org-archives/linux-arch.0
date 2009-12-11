From: Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 4/5] alpha: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 19:42:59 -0500
Message-ID: <b4198de60912101642u147f4592r9337dd9b7d7c604b@mail.gmail.com>
References: <4B212EEC.3060808@caviumnetworks.com>
	 <1260466101-17545-4-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52704 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761823AbZLKAmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 19:42:53 -0500
In-Reply-To: <1260466101-17545-4-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org

On Thu, Dec 10, 2009 at 12:28 PM, David Daney <ddaney@caviumnetworks.co=
m> wrote:
> Use the new unreachable() macro instead of for(;;);
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> CC: Matt Turner <mattst88@gmail.com>
> CC: linux-alpha@vger.kernel.org
> ---
> =A0arch/alpha/include/asm/bug.h | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/alpha/include/asm/bug.h b/arch/alpha/include/asm/bu=
g.h
> index 1720c8a..f091682 100644
> --- a/arch/alpha/include/asm/bug.h
> +++ b/arch/alpha/include/asm/bug.h
> @@ -13,7 +13,8 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"call_pal %0 =A0# bugchk\n\t" =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0".long %1\n\t.8byte %2" =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: : "i"(PAL_bugchk), "i"(__LINE__), "i=
"(__FILE__)); =A0 =A0 \
> - =A0 =A0 =A0 for ( ; ; ); } while (0)
> + =A0 =A0 =A0 unreachable(); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0} while (0)
>
> =A0#define HAVE_ARCH_BUG
> =A0#endif
> --
> 1.6.2.5

Thanks David. I've pushed this into my tree.

Matt
