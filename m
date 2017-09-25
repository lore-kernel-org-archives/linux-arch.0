From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Mon, 25 Sep 2017 20:10:54 +0800
Message-ID: <20170925121054.fqtqkzmwswgjyt75@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922085959.GG10893@tardis>
 <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com>
 <20170924133038.GA8673@tardis>
 <1879888051.17397.1506262984228.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="myrcwr4nhykdleu5"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35976 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934655AbdIYMKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2017 08:10:02 -0400
Content-Disposition: inline
In-Reply-To: <1879888051.17397.1506262984228.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>


--myrcwr4nhykdleu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2017 at 02:23:04PM +0000, Mathieu Desnoyers wrote:
[...]
> >>=20
> >> copy_mm() is performed without holding current->sighand->siglock, so
> >> it appears to be racing with concurrent membarrier register cmd.
> >=20
> > Speak of racing, I think we currently have a problem if we do a
> > register_private_expedited in one thread and do a
> > membarrer_private_expedited in another thread(sharing the same mm), as
> > follow:
> >=20
> >	{t1,t2,t3 sharing the same ->mm}
> >	CPU 0				CPU 1				CPU2
> >	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >	{in thread t1}
> >	membarrier_register_private_expedited():
> >	  ...
> >	  WRITE_ONCE(->mm->membarrier_private_expedited, 1);
> >	  membarrier_arch_register_private_expedited():
> >	    ...
> >	    <haven't set the TIF for t3 yet>
> >=20
> >	    				{in thread t2}
> >					membarrier_private_expedited():
> >					  READ_ONCE(->mm->membarrier_private_expedited); // =3D=3D 1
> >					  ...
> >					  for_each_online_cpu()
> >					    ...
> >					    <p is cpu_rq(CPU2)->curr>
> >					    if (p && p->mm =3D=3D current->mm) // false
> >					    <so no ipi sent to CPU2>
> >					    			=09
> >									{about to switch to t3}
> >									rq->curr =3D t3;
> >									....
> >									context_switch():
> >									  ...
> >									  finish_task_swtich():
> >									    membarrier_sched_in():
> >									    <TIF is not set>
> >									    // no smp_mb() here.
> >=20
> > , and we will miss the smp_mb() on CPU2, right? And this could even
> > happen if t2 has a membarrier_register_private_expedited() preceding the
> > membarrier_private_expedited().
> >				=09
> > Am I missing something subtle here?
>=20
> I think the problem sits in this function:
>=20
> static void membarrier_register_private_expedited(void)
> {
>         struct task_struct *p =3D current;
>=20
>         if (READ_ONCE(p->mm->membarrier_private_expedited))
>                 return;
>         WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
>         membarrier_arch_register_private_expedited(p);
> }
>=20
> I need to change the order between WRITE_ONCE() and invoking
> membarrier_arch_register_private_expedited. If I issue the
> WRITE_ONCE after the arch code (which sets the TIF flags),
> then concurrent membarrier priv exped commands will simply
> return an -EPERM error:
>=20
> static void membarrier_register_private_expedited(void)
> {
>         struct task_struct *p =3D current;
>=20
>         if (READ_ONCE(p->mm->membarrier_private_expedited))
>                 return;
>         membarrier_arch_register_private_expedited(p);
>         WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
> }
>=20
> Do you agree that this would fix the race you identified ?
>=20

Yep, that will do the trick ;-)

Regards,
Boqun

> Thanks,
>=20
> Mathieu
>=20

--myrcwr4nhykdleu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnI8ksACgkQSXnow7UH
+rjHbwf/R9cB6g/B+cB34TRV67oBBFM16ecARQb2OMK0LTtEqDqSWjnCv9DZCXA2
qEsLYHKg1RAnmZW1sO5QnOKAC5jdvejp3QNgvqSN8R3EwDtWv1/5ndIay5k2ItUg
U+7bbFJUnFAhWKnZnE5p1yfz6oKAPnAepBZSQHK21UUlaD/GmUX+iQDLMx8txqgZ
xcJc1aF7qYwBw2M7nGKlJz8pwNFw4k1J3Nbj8Tr3zRxb9J7vhnznLz/4BFAzpCNj
AZYmrsLFXNW3lWlsZ+xTch1RBg5mcky739FCOVuqahYdLzKlK2DYcO6NNZvjiyJV
bl45UvIzs9by8H9Ns9BBWRazcAhAQQ==
=K7ed
-----END PGP SIGNATURE-----

--myrcwr4nhykdleu5--
