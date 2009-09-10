From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/2] __builtin_unreachable
Date: Thu, 10 Sep 2009 12:42:26 +0800
Message-ID: <2375c9f90909092142i58595fedod6780a7c41190f5f@mail.gmail.com>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:5156 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZIJEmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2009 00:42:23 -0400
In-Reply-To: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On Thu, Sep 10, 2009 at 9:59 AM, Roland McGrath <roland@redhat.com> wro=
te:
> The latest GCC has a better way than "for (;;)" to indicate that a co=
de
> path cannot be reached due to reasons the compiler doesn't understand=
 (such
> as code in an asm). =C2=A0These patches provide UNREACHABLE() as a ma=
cro to hide
> the details of this, and then use it for the BUG() macro on x86, savi=
ng
> some dead code otherwise generated.
>
> Other arch's BUG() may want to this too instead of "for (;;)" or __bu=
iltin_trap.
>
> There are numerous matches from "git grep -n 'for *(;;) *;'" but it t=
akes
> someone who knows each bit of code to know where that means UNREACHAB=
LE()
> and where it really wants an infinite loop.

Looks good!

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Just curious, what different asm code will gcc generate for this? Compa=
ring it
to for(;;) ? I am sorry that I don't have gcc 4.5 on hand.

Thanks!
