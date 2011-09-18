From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/3] sys_poll: Fix negative timeout values for x86
 userland on x86_64 kernels v2
Date: Sun, 18 Sep 2011 10:58:26 +0200
Message-ID: <1316336306.31335.8.camel@edumazet-laptop>
References: <1316333042.5814.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316333042.5814.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Le dimanche 18 septembre 2011 =C3=A0 10:04 +0200, Thomas Meyer a =C3=A9=
crit :
> size of int and long differs on x86 and x86_64. the ia32 emulation ca=
lls
> directly into the sys_poll function. when the timeout is set to -1
> the test for sign will fail in sys_poll as the 64bit register is test=
ed.
> the timeout timer will be set to 0xffffffff milliseconds, but the tim=
er
> shouldn't get set at all in this situation.
>=20

As I said, you should CC stable@kernel.org team on this patch.
All previous linux versions had this bug : A program might misbehave
because of a spurious poll(..., timeout < 0) wakeup.

Could you please refine this Changelog again ?

On 32bit user program, all negative timeout values should not set a
timout at all, not only 0xffffffff (-1)

man poll states :

The timeout argument specifies an upper limit on the time for which
poll() will block, in milliseconds.  Specifying a negative value in
timeout means an infinite timeout.
