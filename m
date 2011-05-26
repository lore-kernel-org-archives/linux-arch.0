From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: (Short?) merge window reminder
Date: Thu, 26 May 2011 17:13:57 +0100
Message-ID: <1306426437.6981.14.camel@segulix>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
	 <20110523192056.GC23629@elte.hu>
	 <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
	 <20110523231721.GM10009@thunk.org> <4DDAEC68.30803@zytor.com>
	 <BANLkTikGfVSAMY2a2yiXaNpvBVvF8YdMEA@mail.gmail.com>
	 <alpine.LNX.2.01.1105241409280.15351@frira.zrqbmnf.qr>
	 <BANLkTimCXVdVa6KLRG8GJR1gJY=7_5SkOA@mail.gmail.com>
	 <alpine.LNX.2.01.1105241500410.23085@frira.zrqbmnf.qr>
	 <BANLkTinNK+9XijCN0YGXyvLQ8_npPTG2cQ@mail.gmail.com>
	 <20110524154348.27ba649d@lxorguk.ukuu.org.uk>
	 <BANLkTi=Xuk4=Q43QV1pv33K=J2FFZBLLtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=Xuk4=Q43QV1pv33K=J2FFZBLLtQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.medozas.de>, Ted Ts'o <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Jan Engelhardt <jengelh@medozas.de>, Jacek Luczak <difrost.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2011-05-24 at 11:07 -0400, jonsmirl@gmail.com wrote:
> On Tue, May 24, 2011 at 10:43 AM, Alan Cox <alan@lxorguk.ukuu.org.uk>
> wrote:
> > Can we drop most of MCA, EISA and ISA bus if we are going to have a
> big
> > version change ? A driver spring clean is much overdue and it's all
> in
> > git in case someone wishes to sneak out at midnight and bring some
> crawly
> > horror back from the dead.
>=20
> 2.8 could mark the beginning of the great cleanup
>   --- work out the details of what needs to be cleaned and set a goal
>   --- remove old buses/driver, switch to device tree, graphics, 32/64
> merges, etc
> 3.0 would mark its completion=20

Here it go my opinion,
Many people ask for beginning of 2.7 kernel series which will end on
2.8, by old numeration.=20
Kernel 2.8 will mainly a major clean up, of support of the very old
hardware, like "math co-processor" at only exist in 386 and before
Pentium. If some one want put Linux on this very old hardware should us=
e
kernel 2.2.
However a new numeration of kernel is independent of this, and I agree
with new numeration of kernel on drop a number.=20
Last but not least, I would like to see marked a hiper stable kernel ,
which will be used by Debian guys. Debian guys tend to stop in a kernel
which is not the best one, so let we choose for them what is the stable
of stables .   =20

Best regards,=20
--=20
S=C3=A9rgio M. B.

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
