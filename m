From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Wed, 14 May 2014 19:00:16 +0200
Message-ID: <20140514170016.GW30445@twins.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
	<20140512152208.GA12309@potion.brq.redhat.com>
	<537276B4.10209@hp.com> <20140514165121.GA21370@potion.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0088900872614279570=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140514165121.GA21370@potion.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org


--===============0088900872614279570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EnT6sQnqsTJq4oDy"
Content-Disposition: inline


--EnT6sQnqsTJq4oDy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2014 at 06:51:24PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> Ok.
> I've seen merit in pvqspinlock even with slightly slower first-waiter,
> so I would have happily sacrificed those horrible branches.
> (I prefer elegant to optimized code, but I can see why we want to be
>  strictly better than ticketlock.)
> Peter mentioned that we are focusing on bare-metal patches, so I'll
> withold my other paravirt rants until they are polished.

Well, paravirt must happen too, but comes later in this series, patch 3
which we're replying to is still very much in the bare metal part of the
series.

I've not had time yet to decode all that Waiman has done to make
paravirt work.

But as a general rule I like patches that start with something simple
and working and then optimize it, this series doesn't seem to quite
grasp that.

> And to forcefully bring this thread a little bit on-topic:
>=20
> Pending-bit is effectively a lock in a lock, so I was wondering why
> don't we use more pending bits; advantages are the same, just diminished
> by the probability of having an ideally contended lock:
>  - waiter won't be blocked on RAM access if critical section (or more)
>    ends sooner
>  - some unlucky cacheline is not forgotten
>  - faster unlock (no need for tail operations)
> (- ?)
> disadvantages are magnified:
>  - increased complexity
>  - intense cacheline sharing
>    (I thought that this is the main disadvantage of ticketlock.)
> (- ?)
>=20
> One bit still improved performance, is it the best we got?

So, the advantage of one bit is that if we use a whole byte for 1 bit we
can avoid some atomic ops.

The entire reason for this in-word spinner is to amortize the cost of
hitting the external node cacheline.

So traditional locks like test-and-test and the ticket lock only ever
access the spinlock word itsef, this MCS style queueing lock has a
second (and, see my other rants in this thread, when done wrong more
than 2) cacheline to touch.

That said, all our benchmarking is pretty much for the cache-hot case,
so I'm not entirely convinced yet that the one pending bit makes up for
it, it does in the cache-hot case.

But... writing cache-cold benchmarks is _hard_ :/

--EnT6sQnqsTJq4oDy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTc6EgAAoJEHZH4aRLwOS6YbQQAKinRXw0QntsvwaHuZgv+lW5
tWDt5Yal7nlRalCmtFPgpuvbryv0YW+JXtqe8dDraLlhVEfOMzdxLstlp4gTnMF6
W+taUUOOnK5EWFlYLCH2pTl2jPET+2eE3VS2i86VWx+yTIpci2avAqyh5rr1U5xp
xXnrlcYnAJwgfGL30DNpeT9RY7CvrBJPdgRxiMkyKztesgsKnszM7vp/TOJLAES/
N1P4PSDNT6Nq+xfNgww4mqUeh4VVDEAamxwrTgciNn293BrZkGpMfnWNZLFtcjpK
8b97heHhgGryhFjjZi5AqCb6tn2lidmB8FfSYHJa8KLrQ2ZhjYqvH94lL3rhsNFa
ow8zhqBqNqNJCoavWv33WYICuC5X4+StAPjKfBzv8czucMkemElirsjVtfPmB81L
WAvLrqgiMLrQpzT/CspIjH96UnkdDGbc+znOaBBHZVvBceiqeHVbuJEEe1Y4H70W
psNfoOpZJg5HxEdGsBA3QRPTkYRC37/5rF2DhMZLx4QJkEvN2pRSdqm7j0xQxNBY
Ufwf7h5s6wJRVGCtqI1VcDZNJFBVv633EF1Y/h8sTAA3+HITwqcT5B+gpOUR0Y/Z
CtLXP28NU2WWB7p403VoFkwzJozhjdmXBK0W2fdqoZcuAVESpPhdiikj4cu0zr83
Vn3uwO+kYODw5+MUt+dB
=JLaw
-----END PGP SIGNATURE-----

--EnT6sQnqsTJq4oDy--

--===============0088900872614279570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0088900872614279570==--
