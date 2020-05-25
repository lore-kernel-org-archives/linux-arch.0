From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Mon, 25 May 2020 22:53:25 +0800
Message-ID: <20200525145325.GB2066@tardis>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Nakryiko <andriin@fb.com>
Cc: paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com, will@kernel.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
List-Id: linux-arch.vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > Hello!
> > > > >=20
> > > > > Just wanted to call your attention to some pretty cool and pretty=
 serious
> > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > >=20
> > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.co=
m/
> > > > >=20
> > > > > Thoughts?
> > > >=20
> > > > I find:
> > > >=20
> > > > 	smp_wmb()
> > > > 	smp_store_release()
> > > >=20
> > > > a _very_ weird construct. What is that supposed to even do?
> > >=20
> > > Indeed, it looks like one or the other of those is redundant (dependi=
ng
> > > on the context).
> >=20
> > Probably.  Peter instead asked what it was supposed to even do.  ;-)
>=20
> I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> that it's necessary, this algorithm went through a bunch of iterations,
> starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> point, and settling on smp_read_acquire/smp_store_release, eventually. Ma=
ybe
> there was some reason, but might be that I was just over-cautious. See re=
ply
> on patch thread as well ([0]).
>=20
>   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+So=
AJCDtp1jVhcQ@mail.gmail.com/
>=20

While we are at it, could you explain a bit on why you use
smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
only updated at consumer side, and there is no other write at consumer
side that we want to order with the write to consumer_pos. So I fail
to find why smp_store_release() is necessary.

I did the following modification on litmus tests, and I didn't see
different results (on States) between two versions of litmus tests.

Regards,
Boqun

---------------------->8

diff --git a/tools/memory-model/litmus-tests/mpsc-rb+1p1c+bounded.litmus b/=
tools/memory-model/litmus-tests/mpsc-rb+1p1c+bounded.litmus
index cafd17afe11e..255b23be7fa9 100644
--- a/tools/memory-model/litmus-tests/mpsc-rb+1p1c+bounded.litmus
+++ b/tools/memory-model/litmus-tests/mpsc-rb+1p1c+bounded.litmus
@@ -46,7 +46,7 @@ P0(int *len1, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
 }
diff --git a/tools/memory-model/litmus-tests/mpsc-rb+1p1c+unbound.litmus b/=
tools/memory-model/litmus-tests/mpsc-rb+1p1c+unbound.litmus
index 84f660598015..5eecf14f87d1 100644
--- a/tools/memory-model/litmus-tests/mpsc-rb+1p1c+unbound.litmus
+++ b/tools/memory-model/litmus-tests/mpsc-rb+1p1c+unbound.litmus
@@ -44,7 +44,7 @@ P0(int *len1, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
 }
diff --git a/tools/memory-model/litmus-tests/mpsc-rb+2p1c+bounded.litmus b/=
tools/memory-model/litmus-tests/mpsc-rb+2p1c+bounded.litmus
index 900104c4933b..54da1e5d7ec0 100644
--- a/tools/memory-model/litmus-tests/mpsc-rb+2p1c+bounded.litmus
+++ b/tools/memory-model/litmus-tests/mpsc-rb+2p1c+bounded.litmus
@@ -50,7 +50,7 @@ P0(int *len1, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
=20
@@ -68,7 +68,7 @@ P0(int *len1, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
 }
diff --git a/tools/memory-model/litmus-tests/mpsc-rb+2p1c+unbound.litmus b/=
tools/memory-model/litmus-tests/mpsc-rb+2p1c+unbound.litmus
index 83372e9eb079..fd19433f4d9b 100644
--- a/tools/memory-model/litmus-tests/mpsc-rb+2p1c+unbound.litmus
+++ b/tools/memory-model/litmus-tests/mpsc-rb+2p1c+unbound.litmus
@@ -47,7 +47,7 @@ P0(int *len1, int *len2, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
=20
@@ -65,7 +65,7 @@ P0(int *len1, int *len2, int *cx, int *px)
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
 			rCx =3D rCx + 1;
-			smp_store_release(cx, rCx);
+			WRITE_ONCE(*cx, rCx);
 		}
 	}
 }

>=20
> >=20
> > > Also, what use is a spinlock that is accessed in only one thread?
> >=20
> > Multiple writers synchronize via the spinlock in this case.  I am
> > guessing that his larger 16-hour test contended this spinlock.
>=20
> Yes, spinlock is for coordinating multiple producers. 2p1c cases (bounded
> and unbounded) rely on this already. 1p1c cases are sort of subsets (but
> very fast to verify) checking only consumer/producer interaction.
>=20
> >=20
> > > Finally, I doubt that these tests belong under tools/memory-model.
> > > Shouldn't they go under the new Documentation/ directory for litmus
> > > tests?  And shouldn't the patch update a README file?
> >=20
> > Agreed, and I responded to that effect to his original patch:
> >=20
> > https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72/
>=20
> Yep, makes sense, I'll will move.
>=20
> >=20
> > 							Thanx, Paul
> >=20
>=20

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl7L2+EACgkQSXnow7UH
+riErgf/Wzb00Sg8hmGkgBVyjxygRexYtRXtEokGPsNEdDv76PThrk72IDghZJfW
lBbGr8OwiUApz1WipXNWj68D+zakm1jELPtlCw/6zVn7wkpyRCFPeGUrtXjs3YIa
VWMrwcQv4NZMFsCZ5gql3ORE6sYsRHRy2NuEwdNqhn87xpfbsUEJU4B+EjwsYL2t
Jx+4VTnlDLs2CEWvMX3RVvcD248guxEyqz8dP9KDAZuIqu7+WU8z54iZ3i5xPusl
ytaDcK2kji9+AlsPNHmVmrcWOS6jgK9dDGoZ/HMxbFT64x7DGOCWcfXdzk3rmL1W
GWueVqzLuTDAeQdGMl64XqLmcJPDwQ==
=Q0lL
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
