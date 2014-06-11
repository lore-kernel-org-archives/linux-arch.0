From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 06/16] qspinlock: prolong the stay in the pending bit
	path
Date: Wed, 11 Jun 2014 12:26:06 +0200
Message-ID: <20140611102606.GK3213@twins.programming.kicks-ass.net>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-7-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6890728413425355712=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1401464642-33890-7-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org


--===============6890728413425355712==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IB2Qao3B4XdnqHmg"
Content-Disposition: inline


--IB2Qao3B4XdnqHmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 11:43:52AM -0400, Waiman Long wrote:
> ---
>  kernel/locking/qspinlock.c |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index fc7fd8c..7f10758 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -233,11 +233,25 @@ void queue_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>  	 */
>  	for (;;) {
>  		/*
> -		 * If we observe any contention; queue.
> +		 * If we observe that the queue is not empty or both
> +		 * the pending and lock bits are set, queue
>  		 */
> -		if (val & ~_Q_LOCKED_MASK)
> +		if ((val & _Q_TAIL_MASK) ||
> +		    (val =3D=3D (_Q_LOCKED_VAL|_Q_PENDING_VAL)))
>  			goto queue;
> =20
> +		if (val =3D=3D _Q_PENDING_VAL) {
> +			/*
> +			 * Pending bit is set, but not the lock bit.
> +			 * Assuming that the pending bit holder is going to
> +			 * set the lock bit and clear the pending bit soon,
> +			 * it is better to wait than to exit at this point.
> +			 */
> +			cpu_relax();
> +			val =3D atomic_read(&lock->val);
> +			continue;
> +		}
> +
>  		new =3D _Q_LOCKED_VAL;
>  		if (val =3D=3D new)
>  			new |=3D _Q_PENDING_VAL;


So, again, you just posted a new version without replying to the
previous discussion; so let me try again, what's wrong with the proposal
here:

  lkml.kernel.org/r/20140417163640.GT11096@twins.programming.kicks-ass.net



--IB2Qao3B4XdnqHmg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTmC69AAoJEHZH4aRLwOS6bBUP/1db3Nz0FLv1UoCAI1jBUNnx
Dw3uq3On9bx5aa6qOMaLmJynH9gU0jALn9PvOXtFTs+EgzdAxLtVaCFAZvH8vx2+
Ic8q+t+NPgBdNNHUmF7dfInDUSovrvy7CEeuIIGfBWRnecnMepcSsguwtaf/OwO+
ifDuDOXXN/gr0BwXbGd4rlnZkWz9XI0ztQa+eRrdxjL+H2J3nUjxBW5PuceQIxBQ
48yHUOHsreEN99jvZuWtT/36wK5PQ+vohlQUCT4ci7pjNmmGqKevqEn8kF0fVAjA
x3PEvbh6rk/pnkX7A/dAeIfoe+FEXKBkceyXlq6th2dPAHS7iYYEQ+ZG5INYF56U
8RenG1D7/pv+oXdq1O+jbHfefcwoIfkCbpqFNf9zAzCYlsj58kdyOSu5m8lZ8jYk
Mp2+hcveYKLQ+7BSeEY5XWMLzbR89TRCd2Ub94LPbRWzkXOtjgVSEdT5iNTr6qGh
kSgN0S8EmPQGCPYc56Akw/RFp3W2N3NA3YtoYauRbcv6Pf+Ejzgt0Vf7ptDxwaCS
eb3uXS/xC1fwF1Z5e+vDA1wZMlIDWOUCLKEyBjF57U0fdKH+eu6cO/SIgh2jiddw
7CP5NdBiEWA12Rl86aLNwY3B8HScCoPLorecMj1k5EipJrZi2ASsDMhnIXfMB8um
ykQUSeNaoC6wfNSOydk4
=5Cal
-----END PGP SIGNATURE-----

--IB2Qao3B4XdnqHmg--

--===============6890728413425355712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6890728413425355712==--
