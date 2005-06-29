Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 13:11:45 +0300
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Remaining arch problems in cpu_idle
Message-ID: <20050629101145.GB2694@linux-sh.org>
References: <42C24874.8030702@yahoo.com.au> <20050629080058.GA2694@linux-sh.org> <42C26552.5020304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <42C26552.5020304@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2005 at 07:09:38PM +1000, Nick Piggin wrote:
> Well you only need to disable IRQs if you are about to go to
> sleep waiting for the next pending IRQ. So your hlt_counter
> case looks OK.
>=20
> In the case that you do sleep until the next IRQ, sh64 does indeed
> disable irqs over the need_resched check, however it re-enables them
> before sleeping. So disabling at all is basically useless because
> any pending IRQs will probably all get serviced right as soon as IRQs
> are re-eanbled.
>=20
Ok, I've switched sh64 to use a similar model as sh.

> Well as you probably know, but just to be clear: architectures
> that handle this without a race have an instruction that basically
> turns on interrupts and go to sleep at the same time. I'm not aware
> of a simple way to do it without that facility.
>=20
> Unless you can easily raise an NMI from another processor as an IPI.
>=20
Unfortunately we don't have any such easy facility. The closest I suppose
would to have the watchdog generate an NMI, but that severely limits the
kind of sleep state that we are able to enter.

> As far as spin waiting goes, something like:
>=20
> 	while (!need_resched())
> 		cpu_relax();
>=20
> Is generally used.
>=20
> Now this might introduce some power and heat penalty. What's more,
> your race isn't a fatal one: in the worst case, it should just
> stall until the next timer interrupt (aside, that might be fatal
> with a tickless kernel).
>=20
After incorporating your changes, how about this?

--

diff --git a/arch/sh64/kernel/process.c b/arch/sh64/kernel/process.c
--- a/arch/sh64/kernel/process.c
+++ b/arch/sh64/kernel/process.c
@@ -305,44 +305,29 @@ static int __init hlt_setup(char *__unus
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
=20
-static inline void hlt(void)
-{
-	if (hlt_counter)
-		return;
-
-	__asm__ __volatile__ ("sleep" : : : "memory");
-}
-
 /*
  * The idle loop on a uniprocessor SH..
  */
-void default_idle(void)
+void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (hlt_counter) {
-			while (1)
-				if (need_resched())
-					break;
+			while (!need_resched())
+				cpu_relax();
 		} else {
-			local_irq_disable();
 			while (!need_resched()) {
-				local_irq_enable();
 				idle_trace();
-				hlt();
-				local_irq_disable();
+				cpu_sleep();
 			}
-			local_irq_enable();
 		}
+
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
=20
-void cpu_idle(void)
-{
-	default_idle();
-}
-
 void machine_restart(char * __unused)
 {
 	extern void phys_stext(void);

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCwnPh1K+teJFxZ9wRApSTAJ48YetSX4dysudng0wvgOtvOZDr/wCcDHtV
KckmIEYm1MQaKoII0bBiBl0=
=UaKn
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
