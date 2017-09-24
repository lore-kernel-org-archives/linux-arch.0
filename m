From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Sun, 24 Sep 2017 21:30:38 +0800
Message-ID: <20170924133038.GA8673@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922085959.GG10893@tardis>
 <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 03:10:10PM +0000, Mathieu Desnoyers wrote:
> ----- On Sep 22, 2017, at 4:59 AM, Boqun Feng boqun.feng@gmail.com wrote:
>=20
> > On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
> > [...]
> >> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
> >> +		struct task_struct *next)
> >> +{
> >> +	/*
> >> +	 * Only need the full barrier when switching between processes.
> >> +	 */
> >> +	if (likely(!test_ti_thread_flag(task_thread_info(next),
> >> +			TIF_MEMBARRIER_PRIVATE_EXPEDITED)
> >> +				|| prev->mm =3D=3D next->mm))
> >=20
> > And we also don't need the smp_mb() if !prev->mm, because switching from
> > kernel to user will have a smp_mb() implied by mmdrop()?
>=20
> Right. And we also don't need it when switching from userspace to kernel

Yep, but this case is covered already, as I think we don't allow kernel
thread to have TIF_MEMBARRIER_PRIVATE_EXPEDITED set, right?

> thread neither. Something like this:
>=20
> static inline void membarrier_arch_sched_in(struct task_struct *prev,
>                 struct task_struct *next)
> {
>         /*
>          * Only need the full barrier when switching between processes.
>          * Barrier when switching from kernel to userspace is not
>          * required here, given that it is implied by mmdrop(). Barrier
>          * when switching from userspace to kernel is not needed after
>          * store to rq->curr.
>          */
>         if (likely(!test_ti_thread_flag(task_thread_info(next),
>                         TIF_MEMBARRIER_PRIVATE_EXPEDITED)
>                         || !prev->mm || !next->mm || prev->mm =3D=3D next=
->mm))

, so no need to test next->mm here.

>                 return;
>=20
>         /*
>          * The membarrier system call requires a full memory barrier
>          * after storing to rq->curr, before going back to user-space.
>          */
>         smp_mb();
> }
>=20
> >=20
> >> +		return;
> >> +
> >> +	/*
> >> +	 * The membarrier system call requires a full memory barrier
> >> +	 * after storing to rq->curr, before going back to user-space.
> >> +	 */
> >> +	smp_mb();
> >> +}
> >=20
> > [...]
> >=20
> >> +static inline void membarrier_fork(struct task_struct *t,
> >> +		unsigned long clone_flags)
> >> +{
> >> +	if (!current->mm || !t->mm)
> >> +		return;
> >> +	t->mm->membarrier_private_expedited =3D
> >> +		current->mm->membarrier_private_expedited;
> >=20
> > Have we already done the copy of ->membarrier_private_expedited in
> > copy_mm()?
>=20
> copy_mm() is performed without holding current->sighand->siglock, so
> it appears to be racing with concurrent membarrier register cmd.

Speak of racing, I think we currently have a problem if we do a
register_private_expedited in one thread and do a
membarrer_private_expedited in another thread(sharing the same mm), as
follow:

	{t1,t2,t3 sharing the same ->mm}
	CPU 0				CPU 1				CPU2
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	{in thread t1}						=09
	membarrier_register_private_expedited():
	  ...
	  WRITE_ONCE(->mm->membarrier_private_expedited, 1);
	  membarrier_arch_register_private_expedited():
	    ...
	    <haven't set the TIF for t3 yet>

	    				{in thread t2}
					membarrier_private_expedited():
					  READ_ONCE(->mm->membarrier_private_expedited); // =3D=3D 1
					  ...
					  for_each_online_cpu()
					    ...
					    <p is cpu_rq(CPU2)->curr>
					    if (p && p->mm =3D=3D current->mm) // false
					    <so no ipi sent to CPU2>
					    			=09
									{about to switch to t3}
									rq->curr =3D t3;
									....
									context_switch():
									  ...
									  finish_task_swtich():
									    membarrier_sched_in():
									    <TIF is not set>
									    // no smp_mb() here.

, and we will miss the smp_mb() on CPU2, right? And this could even
happen if t2 has a membarrier_register_private_expedited() preceding the
membarrier_private_expedited().
				=09
Am I missing something subtle here?

Regards,
Boqun


> However, given that it is a single flag updated with WRITE_ONCE()
> and read with READ_ONCE(), it might be OK to rely on copy_mm there.
> If userspace runs registration concurrently with fork, they should
> not expect the child to be specifically registered or unregistered.
>=20
> So yes, I think you are right about removing this copy and relying on
> copy_mm() instead. I also think we can improve membarrier_arch_fork()
> on powerpc to test the current thread flag rather than using current->mm.
>=20
> Which leads to those two changes:
>=20
> static inline void membarrier_fork(struct task_struct *t,
>                 unsigned long clone_flags)
> {
>         /*
>          * Prior copy_mm() copies the membarrier_private_expedited field
>          * from current->mm to t->mm.
>          */
>         membarrier_arch_fork(t, clone_flags);
> }
>=20
> And on PowerPC:
>=20
> static inline void membarrier_arch_fork(struct task_struct *t,
>                 unsigned long clone_flags)
> {
>         /*
>          * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
>          * fork is protected by siglock. membarrier_arch_fork is called
>          * with siglock held.
>          */
>         if (test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED))
>                 set_ti_thread_flag(task_thread_info(t),
>                                 TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> }
>=20
> Thanks,
>=20
> Mathieu
>=20
>=20
> >=20
> > Regards,
> > Boqun
> >=20
> >> +	membarrier_arch_fork(t, clone_flags);
> >> +}
> >> +static inline void membarrier_execve(struct task_struct *t)
> >> +{
> >> +	t->mm->membarrier_private_expedited =3D 0;
> >> +	membarrier_arch_execve(t);
> >> +}
> >> +#else
> >> +static inline void membarrier_sched_in(struct task_struct *prev,
> >> +		struct task_struct *next)
> >> +{
> >> +}
> >> +static inline void membarrier_fork(struct task_struct *t,
> >> +		unsigned long clone_flags)
> >> +{
> >> +}
> >> +static inline void membarrier_execve(struct task_struct *t)
> >> +{
> >> +}
> >> +#endif
> >> +
> > [...]
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnHs3sACgkQSXnow7UH
+rg5tAgAgVr4i5pP971szeeRsgIe3fvWupRzUDHaKi2MtNZ06oeALN1fy/CNuen2
wWLPJ8W7ElQ4ePZ4Qm5ss6tmzs6wdfQ4jtTDyiHmL7e+JBEXLJwSgU+WF/mUqF97
pyBa1sI+SLSMOtWGIvJ6zxAtkrjknOumKw3UHhbC9iRrbfg2y3r1aM3JNG1olEeX
RpZO9W6CqkcKH82mYnLnflO+6bajO5aVnN+5P0wqd3nONbgbJhq4aHE7UEcGM3Jp
+GV+trdYBT8DqBmt35jzFIIY0IKfzjVFgnHHJsuOFJ+8vUjmJjAlQj6ygeU1QVCW
h7w59XWFiQntZGU7IMIicK50o4w77A==
=XPLM
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
