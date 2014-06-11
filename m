From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 09/16] qspinlock, x86: Allow unfair spinlock in a
	virtual guest
Date: Wed, 11 Jun 2014 12:54:02 +0200
Message-ID: <20140611105402.GL3213@twins.programming.kicks-ass.net>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-10-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5253537806831913543=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1401464642-33890-10-git-send-email-Waiman.Long@hp.com>
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


--===============5253537806831913543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QmoJrblcRudFCJH"
Content-Disposition: inline


--+QmoJrblcRudFCJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 11:43:55AM -0400, Waiman Long wrote:
> Enabling this configuration feature causes a slight decrease the
> performance of an uncontended lock-unlock operation by about 1-2%
> mainly due to the use of a static key. However, uncontended lock-unlock
> operation are really just a tiny percentage of a real workload. So
> there should no noticeable change in application performance.

No, entirely unacceptable.

> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
> +/**
> + * queue_spin_trylock_unfair - try to acquire the queue spinlock unfairly
> + * @lock : Pointer to queue spinlock structure
> + * Return: 1 if lock acquired, 0 if failed
> + */
> +static __always_inline int queue_spin_trylock_unfair(struct qspinlock *l=
ock)
> +{
> +	union arch_qspinlock *qlock =3D (union arch_qspinlock *)lock;
> +
> +	if (!qlock->locked && (cmpxchg(&qlock->locked, 0, _Q_LOCKED_VAL) =3D=3D=
 0))
> +		return 1;
> +	return 0;
> +}
> +
> +/**
> + * queue_spin_lock_unfair - acquire a queue spinlock unfairly
> + * @lock: Pointer to queue spinlock structure
> + */
> +static __always_inline void queue_spin_lock_unfair(struct qspinlock *loc=
k)
> +{
> +	union arch_qspinlock *qlock =3D (union arch_qspinlock *)lock;
> +
> +	if (likely(cmpxchg(&qlock->locked, 0, _Q_LOCKED_VAL) =3D=3D 0))
> +		return;
> +	/*
> +	 * Since the lock is now unfair, we should not activate the 2-task
> +	 * pending bit spinning code path which disallows lock stealing.
> +	 */
> +	queue_spin_lock_slowpath(lock, -1);
> +}

Why is this needed?

> +/*
> + * Redefine arch_spin_lock and arch_spin_trylock as inline functions tha=
t will
> + * jump to the unfair versions if the static key virt_unfairlocks_enabled
> + * is true.
> + */
> +#undef arch_spin_lock
> +#undef arch_spin_trylock
> +#undef arch_spin_lock_flags
> +
> +/**
> + * arch_spin_lock - acquire a queue spinlock
> + * @lock: Pointer to queue spinlock structure
> + */
> +static inline void arch_spin_lock(struct qspinlock *lock)
> +{
> +	if (static_key_false(&virt_unfairlocks_enabled))
> +		queue_spin_lock_unfair(lock);
> +	else
> +		queue_spin_lock(lock);
> +}
> +
> +/**
> + * arch_spin_trylock - try to acquire the queue spinlock
> + * @lock : Pointer to queue spinlock structure
> + * Return: 1 if lock acquired, 0 if failed
> + */
> +static inline int arch_spin_trylock(struct qspinlock *lock)
> +{
> +	if (static_key_false(&virt_unfairlocks_enabled))
> +		return queue_spin_trylock_unfair(lock);
> +	else
> +		return queue_spin_trylock(lock);
> +}

So I really don't see the point of all this? Why do you need special
{try,}lock paths for this case? Are you worried about the upper 24bits?

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ae1b19d..3723c83 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -217,6 +217,14 @@ static __always_inline int try_set_locked(struct qsp=
inlock *lock)
>  {
>  	struct __qspinlock *l =3D (void *)lock;
> =20
> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
> +	/*
> +	 * Need to use atomic operation to grab the lock when lock stealing
> +	 * can happen.
> +	 */
> +	if (static_key_false(&virt_unfairlocks_enabled))
> +		return cmpxchg(&l->locked, 0, _Q_LOCKED_VAL) =3D=3D 0;
> +#endif
>  	barrier();
>  	ACCESS_ONCE(l->locked) =3D _Q_LOCKED_VAL;
>  	barrier();

Why? If we have a simple test-and-set lock like below, we'll never get
here at all.

> @@ -252,6 +260,18 @@ void queue_spin_lock_slowpath(struct qspinlock *lock=
, u32 val)
> =20
>  	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
> =20
> +#ifdef CONFIG_VIRT_UNFAIR_LOCKS
> +	/*
> +	 * A simple test and set unfair lock
> +	 */
> +	if (static_key_false(&virt_unfairlocks_enabled)) {
> +		cpu_relax();	/* Relax after a failed lock attempt */

Meh, I don't think anybody can tell the difference if you put that in or
not, therefore don't.

> +		while (!queue_spin_trylock(lock))
> +			cpu_relax();
> +		return;
> +	}
> +#endif /* CONFIG_VIRT_UNFAIR_LOCKS */

If you're really worried about those upper 24bits, you can always clear
them when you get here.

--+QmoJrblcRudFCJH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTmDVKAAoJEHZH4aRLwOS6fl0QALFOkhHIAfb000Hkhc0YQtqp
BsL05Q7HOVu/FXlmS0MneOUNnhM7/i0t+yrBi3S3Kx+bCel7IlsNCjWCtv7bcHlL
6D+ak+m3BAq+rWWZbeTSW+VOPk/OQmv0H88PUeJYaB9LcbY+ndHu5zyeBNgAdb+x
sPl3h8OP1hHLxr4l4C6c4ymiadovalrpoiCY1xrMmftWxP4mdy2MtK+g8OPaxISu
rXtPtG4CX2xmx2w2yX4fXHND/IMfDDAUZa74Xe3xfqGQAx9qKB/XUKjIg1kW9rTq
zEQoRepoaunUFdDH8/Dpk0LVMNFhc8TX8Id6v8wnpE/2bAgrJOQKnXcVLcPwTEc/
9EDLGy3Y/KC5Fx2fQXfjfvQ/9ck+KLgLMbx82srvhcdzSpBvWqet0mHINMMnXtp1
kdYp8WpzPNB78ev69RFEr1rJjP/F8ProxS1yPTM37ymi/IpSQQQrmgtT5rTfNLei
XC9YoyfgX/CIOUK+YbwMZn+8m8pDBfMGZ3U33qofZDiwGJplyeYuOtJomdeiBWnb
QYDNWUtQ1Yel59WFrbeWCvCWN53wjNCt9IpD49j0nRKqZKIT+6RJMO51OFN750Mh
UtPdc7+zio/JSKvJPU9Wsi/JWQN9F8+N/yxvsilZWjp7gpQKmxH9yKBdKab+8rCD
PMBJHzUUOeo7wbwyAUGS
=avfn
-----END PGP SIGNATURE-----

--+QmoJrblcRudFCJH--

--===============5253537806831913543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5253537806831913543==--
