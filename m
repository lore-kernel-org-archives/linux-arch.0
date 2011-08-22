From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 3/4] string: introduce memchr_inv
Date: Mon, 22 Aug 2011 23:56:51 +0200
Message-ID: <1314050211.4791.4.camel@edumazet-laptop>
References: <1314030548-21082-1-git-send-email-akinobu.mita@gmail.com>
	 <1314030548-21082-4-git-send-email-akinobu.mita@gmail.com>
	 <20110822135218.f2d9f462.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110822135218.f2d9f462.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Christoph Lameter <cl@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>, Joern Engel <joern@logfs.org>, logfs@logfs.org, Marcin Slusarz <marcin.slusarz@gmail.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Le lundi 22 ao=C3=BBt 2011 =C3=A0 13:52 -0700, Andrew Morton a =C3=A9crit=
 :
> On Tue, 23 Aug 2011 01:29:07 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>=20
> > memchr_inv() is mainly used to check whether the whole buffer is fill=
ed
> > with just a specified byte.
> >=20
> > The function name and prototype are stolen from logfs and the
> > implementation is from SLUB.
> >=20
> > ...
> >
> > +/**
> > + * memchr_inv - Find a character in an area of memory.
> > + * @s: The memory area
> > + * @c: The byte to search for
> > + * @n: The size of the area.
>=20
> This text seems to be stolen from memchr().  I guess it's close enough.
>=20
> > + * returns the address of the first character other than @c, or %NUL=
L
> > + * if the whole buffer contains just @c.
> > + */
> > +void *memchr_inv(const void *start, int c, size_t bytes)
> > +{
> > +	u8 value =3D c;
> > +	u64 value64;
> > +	unsigned int words, prefix;
> > +
> > +	if (bytes <=3D 16)
> > +		return check_bytes8(start, value, bytes);
> > +
> > +	value64 =3D value | value << 8 | value << 16 | value << 24;
> > +	value64 =3D (value64 & 0xffffffff) | value64 << 32;
> > +	prefix =3D 8 - ((unsigned long)start) % 8;
> > +

<snip>

> > +	if (prefix) {
> > +		u8 *r =3D check_bytes8(start, value, prefix);
> > +		if (r)
> > +			return r;
> > +		start +=3D prefix;
> > +		bytes -=3D prefix;
> > +	}

</snip>

Please note Andrew the previous code just make sure 'start' is aligned
on 8 bytes boundary. (It is suboptimal because if 'start' was already
aligned, we call the slow check_bytes(start, value, 8))

Code should probably do

prefix =3D (unsigned long)start % 8;
if (prefix) {
	prefix =3D 8 - prefix;
	r =3D check_bytes8(start, value, prefix);
	...



> > +
> > +	words =3D bytes / 8;
> > +
> > +	while (words) {
> > +		if (*(u64 *)start !=3D value64)



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
