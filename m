From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 11:44:57 -0700
Message-ID: <CA+55aFzOD+CTjU8nChsXsK0gv3A=CRPUb2RDedibuSEsMmpcVg@mail.gmail.com>
References: <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
 <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
 <20120523.143543.366370918467441501.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37060 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab2EWSpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 14:45:18 -0400
Received: by wibhm6 with SMTP id hm6so4979849wib.1
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 11:45:17 -0700 (PDT)
In-Reply-To: <20120523.143543.366370918467441501.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 11:35 AM, David Miller <davem@davemloft.net> wr=
ote:
>
> Comparing get_fs() with USER_DS should be portable enough, as should
> STACK_TOP, right? =A0Or does STACK_TOP have some weird semantics on s=
ome
> architectures that I'm not aware of?

STACK_TOP is definitely not portable. TASK_SIZE would be closer, and
was what the old deleted code in fs/namei.c used to use.

It may *happen* that all big-endian machines make STACK_TOP be the
same as TASK_SIZE, but that would be more of an accident than anything
else.

                  Linus
