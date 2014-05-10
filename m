From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 06/19] qspinlock: prolong the stay in the pending bit
	path
Date: Sat, 10 May 2014 15:38:29 +0200
Message-ID: <20140510133829.GD30445@twins.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-7-git-send-email-Waiman.Long@hp.com>
	<20140508185854.GN2844@laptop.programming.kicks-ass.net>
	<536D79C7.2000701@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6502341821932841574=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <536D79C7.2000701@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org


--===============6502341821932841574==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EIrXVFSPgsocVIgL"
Content-Disposition: inline


--EIrXVFSPgsocVIgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 08:58:47PM -0400, Waiman Long wrote:
> On 05/08/2014 02:58 PM, Peter Zijlstra wrote:
> >On Wed, May 07, 2014 at 11:01:34AM -0400, Waiman Long wrote:
> >>@@ -221,11 +222,37 @@ static inline int trylock_pending(struct qspinloc=
k *lock, u32 *pval)
> >>  	 */
> >>  	for (;;) {
> >>  		/*
> >>-		 * If we observe any contention; queue.
> >>+		 * If we observe that the queue is not empty,
> >>+		 * return and be queued.
> >>  		 */
> >>-		if (val&  ~_Q_LOCKED_MASK)
> >>+		if (val&  _Q_TAIL_MASK)
> >>  			return 0;
> >>
> >>+		if (val =3D=3D (_Q_LOCKED_VAL|_Q_PENDING_VAL)) {
> >>+			/*
> >>+			 * If both the lock and pending bits are set, we wait
> >>+			 * a while to see if that either bit will be cleared.
> >>+			 * If that is no change, we return and be queued.
> >>+			 */
> >>+			if (!retry)
> >>+				return 0;
> >>+			retry--;
> >>+			cpu_relax();
> >>+			cpu_relax();
> >>+			*pval =3D val =3D atomic_read(&lock->val);
> >>+			continue;
> >>+		} else if (val =3D=3D _Q_PENDING_VAL) {
> >>+			/*
> >>+			 * Pending bit is set, but not the lock bit.
> >>+			 * Assuming that the pending bit holder is going to
> >>+			 * set the lock bit and clear the pending bit soon,
> >>+			 * it is better to wait than to exit at this point.
> >>+			 */
> >>+			cpu_relax();
> >>+			*pval =3D val =3D atomic_read(&lock->val);
> >>+			continue;
> >>+		}
> >Didn't I give a much saner alternative to this mess last time?
>=20
> I don't recall you have any suggestion last time. Anyway, if you think the
> code is too messy, I think I can give up the first if statement which is
> more an optimistic spinning kind of code for short critical section. The =
2nd
> if statement is still need to improve chance of using this code path due =
to
> timing reason. I will rerun my performance test to make sure it won't have
> too much performance impact.

lkml.kernel.org/r/20140417163640.GT11096@twins.programming.kicks-ass.net

--EIrXVFSPgsocVIgL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTbivVAAoJEHZH4aRLwOS6GCUP/0mR3CvV3nBeKaGb2km8GwV2
wQRx1OVYmoC4+8ikFGSXUbm3++1JLokQfTKPB5fMrIqP8kKnEdMSMmjE9cq3E/ZZ
UTcp75PI0x3b/ABfQx9nXrmAOeGiXvX5DULDpg7t2JJMsQXiMKI9nk6FTLioh6eZ
Vngn1rst/uJ5O99IaiDo2AMLtG80cc5NFkfkKFIw624ANPupkC/pVNqP+JKv8AuS
ppiNp6yzKwTh/7y1+okBvRszTRzrWVVEjBWK1M5OwfYsAuvkBfA7oKNKpEmgBs3+
KC+fzmihlkC/feN5Fx9X+Gb9VohMlRaf6rd9IaLX7NQ0hkR2yTn/dJGFsJ3mKunR
FYw+YAYqfr05T+aJQ6zq7CbQDzaSE5Gqqb2d4ur/b1o9IFREH44WZ6z/HvYMlwnx
77JCkTcM2jADakiz0GLG62uNAE+ulfKz4JdQYbWyDjLWiEMUh/8+pO0Efji1OIEA
lhkc7eTTochtORbLOSYh1AzVuqPGxTWfxdIekmrYeg5qQq/ZiI2O44ys0ohqZUAt
oJLr91TMJgHPQXtigftADjCHI7piysa1PG7+FwzoZQ3HC2DbTj6oUV8ZmW/sH0nw
Gxb77wGgz1MvXrBuIO7fXbjkGuvBTdTojkoHsuTsiNzAgdIYjxJKOfowyVZiMq6A
VGFdDNWijZSRTUXwPzWK
=p8dI
-----END PGP SIGNATURE-----

--EIrXVFSPgsocVIgL--

--===============6502341821932841574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6502341821932841574==--
