From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] sparc: Increase portability of strncpy_from_user() implementation.
Date: Thu, 24 May 2012 09:04:27 -0700
Message-ID: <CA+55aFw8jsrqipdKq9-EiA5a+Y-HKMQmpBsirs9ojfk1yUSxww@mail.gmail.com>
References: <20120523.233430.1084831063018998232.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49022 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2EXQEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 12:04:48 -0400
Received: by wibhj8 with SMTP id hj8so5976708wib.1
        for <linux-arch@vger.kernel.org>; Thu, 24 May 2012 09:04:47 -0700 (PDT)
In-Reply-To: <20120523.233430.1084831063018998232.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 8:34 PM, David Miller <davem@davemloft.net> wro=
te:
> -
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> =A0 =A0 =A0 =A0if (((long) dst | (long) src) & (sizeof(long) - 1))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto byte_at_a_time;
> +#endif
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> =A0byte_at_a_time:
> +#endif

Btw, this would have been much cleaner with something like

   #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
      #define IS_UNALIGNED(src,dst) 0
   #else
      #define IS_UNALIGNED(src,dst) (((long)(src) | (long)(dst)) &
(sizeof(long) - 1))
   #endif

and then just

     if (IS_UNALIGNED(src,dst))
        goto byte_at_a_time;

in the source code. Those #ifdef's in the middle of the code really
are horribly ugly, and are unnecessary.

Besides, some architecture may actually have ok unaligned loads, and
just horrible unaligned stores, and it would be easier with that kind
of abstraction.

Not a big deal, but I thought I'd point it out when I shuddered when I
looked at it.

                      Linus
