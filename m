From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/44] metag: Use get_signal() signal_setup_done()
Date: Mon, 3 Mar 2014 11:15:12 +0000
Message-ID: <53146440.707@imgtec.com>
References: <1393804646-7797-1-git-send-email-richard@nod.at> <1393804646-7797-2-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="d8V3PGl5ELvXKeuSWonKftvQgGEsidMj5"
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393804646-7797-2-git-send-email-richard-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, a-jacquiot-l0cyMroinI0@public.gmane.org, starvik-VrBV9hrLPhE@public.gmane.org, jesper.nilsson-VrBV9hrLPhE@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, yasutake.koichi-NAum8xwdG0+S7A1Ibl2khg@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org, gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, oleg@redhat.
List-Id: linux-arch.vger.kernel.org

--d8V3PGl5ELvXKeuSWonKftvQgGEsidMj5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 02/03/14 23:57, Richard Weinberger wrote:
> @@ -235,10 +230,8 @@ static void handle_signal(unsigned long sig, sigin=
fo_t *info,
>  static int do_signal(struct pt_regs *regs, int syscall)
>  {
>  	unsigned int retval =3D 0, continue_addr =3D 0, restart_addr =3D 0;
> -	struct k_sigaction ka;
> -	siginfo_t info;
> -	int signr;
>  	int restart =3D 0;
> +	struct ksignal ksig;
> =20
>  	/*
>  	 * By the end of rt_sigreturn the context describes the point that th=
e
> @@ -272,30 +265,30 @@ static int do_signal(struct pt_regs *regs, int sy=
scall)
>  	}
> =20
>  	/*
> -	 * Get the signal to deliver. When running under ptrace, at this poin=
t
> -	 * the debugger may change all our registers ...
> -	 */
> -	signr =3D get_signal_to_deliver(&info, &ka, regs, NULL);
> -	/*
>  	 * Depending on the signal settings we may need to revert the decisio=
n
>  	 * to restart the system call. But skip this if a debugger has chosen=
 to
>  	 * restart at a different PC.
>  	 */
>  	if (regs->REG_PC !=3D restart_addr)
>  		restart =3D 0;
> -	if (signr > 0) {
> +
> +	/*
> +	 * Get the signal to deliver. When running under ptrace, at this poin=
t
> +	 * the debugger may change all our registers ...
> +	 */
> +	if (get_signal(&ksig)) {

The patch all looks good to me except for this bit. You've moved the bit
at which a ptrace debugger can alter the registers to after the check
for whether the PC has been altered, which would still need to cancel
the restart.

Does something like the hunks below look reasonable to you?

Would you like me to take this patch through the metag tree or do you
want to keep them together?

Cheers
James

@@ -275,7 +268,7 @@ static int do_signal(struct pt_regs *regs, int syscal=
l)
 	 * Get the signal to deliver. When running under ptrace, at this point
 	 * the debugger may change all our registers ...
 	 */
-	signr =3D get_signal_to_deliver(&info, &ka, regs, NULL);
+	get_signal(&ksig);
 	/*
 	 * Depending on the signal settings we may need to revert the decision
 	 * to restart the system call. But skip this if a debugger has chosen t=
o
@@ -283,19 +276,19 @@ static int do_signal(struct pt_regs *regs, int sysc=
all)
 	 */
 	if (regs->REG_PC !=3D restart_addr)
 		restart =3D 0;
-	if (signr > 0) {
+	if (ksig.sig > 0) {
 		if (unlikely(restart)) {
 			if (retval =3D=3D -ERESTARTNOHAND
 			    || retval =3D=3D -ERESTART_RESTARTBLOCK
 			    || (retval =3D=3D -ERESTARTSYS
-				&& !(ka.sa.sa_flags & SA_RESTART))) {
+				&& !(ksig.ka.sa.sa_flags & SA_RESTART))) {
 				regs->REG_RETVAL =3D -EINTR;
 				regs->REG_PC =3D continue_addr;
 			}
 		}
=20
 		/* Whee! Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		return 0;
 	}
=20


--d8V3PGl5ELvXKeuSWonKftvQgGEsidMj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJTFGRMAAoJEKHZs+irPybfNMkQAKVmUuho1EqnH4mXchsFEDZT
qEsiOMB9WKgE1DqtlhU1Aumj+ji1Ck8JKtXMZiKmXCLp09ZLQYT/w5y0T4riXGqr
O55XUDjXh9qEbSiN2ZlndzOOFCxxSBA7kNflQMZv4QYLarayadoaeR5ubw9KLxJy
JtkUH2SR5FZ00rtGQz+TZe2B5tXwwq7A3E7xr2gGamza9KqJyS+tznRplKkXimqA
DYghTcyY6MtOdF72XWsTNBuejRyfMTVEfJ6kq6hzhz9qA9nxW8R79o6KsLOApezq
BowqWUu3T+TJsNAO6FjmjZXoEw6Q+cbECdE7VMNYOKjQ3CdqxROBl7YrsLjgmakm
VhFArpBIHO7mLYigKtrNTUr61nzohMEWzXvdtpM+RMLUuMtYe7EzzSk1JZEikDUs
VY3LHeCCap3K5U7dcDrdTg/khcDSnXZ2uQN+9V8TQ75zoOXf4otDSl6j8DtpZCVZ
s+MZrxL9ewvT+Rc42YDKBUHdoIEiasCI/bNx2yFBoE/gu0Kof31Y1P7c4GFhncO/
TMBmyfKI9IipgVCO19xu+WEVwLmPbHaok8QHBni952dUrOPaIrUqUNpxJ1oF2Eya
apQducBpF5ep9vUDfRYOqDHwZ2PdwI3Ch8uU9CnjE/e3zRuRB+0LMsf3Io2urZlk
KEghC1TqDIgQ2fAucpQT
=fyQJ
-----END PGP SIGNATURE-----

--d8V3PGl5ELvXKeuSWonKftvQgGEsidMj5--
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
