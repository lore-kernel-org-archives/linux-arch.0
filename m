Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.pp.htv.fi ([213.243.153.35]:9672 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1161146AbWASBdE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 20:33:04 -0500
Received: from mail.internal.linux-sh.org (cs181080144.pp.htv.fi [82.181.80.144])
	by smtp2.pp.htv.fi (Postfix) with ESMTP id 100AB296B7E
	for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2006 03:33:03 +0200 (EET)
Received: from master.internal.linux-sh.org (Master.Internal.Linux-SH.ORG [192.168.1.2])
	by mail.internal.linux-sh.org (Postfix) with SMTP id D6F65C11CB
	for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2006 03:33:02 +0200 (EET)
Date: Thu, 19 Jan 2006 03:32:57 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] generic hardirq type setting
Message-ID: <20060119013257.GA18181@linux-sh.org>
References: <20060119011737.GA18038@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20060119011737.GA18038@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2006 at 03:17:37AM +0200, Paul Mundt wrote:
> Now that Russell's SA_TRIGGER_* changes went in, I've been updating some
> of the SH code to support it. ARM supports a ->set_type() through its
> struct irqchip so doesn't have to deal with this, but this requires a bit
> more work for architectures that are using generic hardirqs.
>=20
> I've added a ->set_type() to struct hw_interrupt_type to deal with this,
> which seems like the least invasive solution. dhowells made a note about
> handling and returning errors for invalid type configurations when
> Russell's initial patch was posted, so I've implemented this as well.
>=20
And here's the right patch without the misplaced ).. Sorry for the noise.

---

 arch/sh/kernel/cpu/irq/pint.c |   19 +++++++++++++++++++
 include/linux/irq.h           |    1 +
 kernel/irq/manage.c           |   19 +++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/irq/pint.c b/arch/sh/kernel/cpu/irq/pint.c
index 95d6024..ca4bb94 100644
--- a/arch/sh/kernel/cpu/irq/pint.c
+++ b/arch/sh/kernel/cpu/irq/pint.c
@@ -37,9 +37,28 @@ static unsigned int startup_pint_irq(uns
 	return 0; /* never anything pending */
 }
=20
+static int set_type_pint_irq(unsigned int irq, unsigned int type)
+{
+	unsigned int val;
+
+	/* Only level detection is possible */
+	if (unlikely(!(type & (SA_TRIGGER_HIGH | SA_TRIGGER_LOW))))
+		return -EINVAL;
+
+	val =3D ctrl_inw(INTC_ICR2);
+	if (type & SA_TRIGGER_HIGH)
+		val |=3D (1 << (irq - PINT_IRQ_BASE));
+	else
+		val &=3D ~(1 << (irq - PINT_IRQ_BASE));
+	ctrl_outw(val, INTC_ICR2);
+
+	return 0;
+}
+
 static struct hw_interrupt_type pint_irq_type =3D {
 	.typename =3D "PINT-IRQ",
 	.startup =3D startup_pint_irq,
+	.set_type =3D set_type_pint_irq,
 	.shutdown =3D shutdown_pint_irq,
 	.enable =3D enable_pint_irq,
 	.disable =3D disable_pint_irq,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6c5d4c8..904cffa 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -53,6 +53,7 @@ struct hw_interrupt_type {
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
 	void (*set_affinity)(unsigned int irq, cpumask_t dest);
+	int (*set_type)(unsigned int irq, unsigned int type);
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
 	void (*release)(unsigned int irq, void *dev_id);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 97d5559..4ec7c9a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -203,8 +203,12 @@ int setup_irq(unsigned int irq, struct i
 	spin_lock_irqsave(&desc->lock,flags);
 	p =3D &desc->action;
 	if ((old =3D *p) !=3D NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
+		/*
+		 * Can't share interrupts unless both agree to and are
+		 * the same type.
+		 */
+		if (!(old->flags & new->flags & SA_SHIRQ) ||
+		    (~old->flags & new->flags) & SA_TRIGGER_MASK) {
 			spin_unlock_irqrestore(&desc->lock,flags);
 			return -EBUSY;
 		}
@@ -220,6 +224,17 @@ int setup_irq(unsigned int irq, struct i
 	*p =3D new;
=20
 	if (!shared) {
+		if (desc->handler->set_type) {
+			unsigned int type =3D new->flags & SA_TRIGGER_MASK;
+			int ret;
+
+			ret =3D desc->handler->set_type(irq, type);
+			if (unlikely(ret !=3D 0)) {
+				spin_unlock_irqrestore(&desc->lock, flags);
+				return ret;
+			}
+		}
+
 		desc->depth =3D 0;
 		desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT |
 				  IRQ_WAITING | IRQ_INPROGRESS);

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzuxJ1K+teJFxZ9wRAkdZAJwKw7BPdK+VqipbXcwD+dUq5smwOgCfSgVs
QfdvRhO+6m/xmZ9wvh4U1q4=
=DrHf
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
