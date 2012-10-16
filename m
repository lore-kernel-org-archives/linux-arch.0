From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [git pull] signals pile 3
Date: Tue, 16 Oct 2012 15:05:25 +0100
Message-ID: <20121016140525.GG21164@n2100.arm.linux.org.uk>
References: <20121013005334.GM2616@ZenIV.linux.org.uk> <507ADBBB.9090209@gmail.com> <20121014202431.GL21164@n2100.arm.linux.org.uk> <20121014222449.GN21164@n2100.arm.linux.org.uk> <507B3F2C.1090500@gmail.com> <20121014231649.GO21164@n2100.arm.linux.org.uk> <20121016140414.GS639@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121016140414.GS639@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Mack <zonque@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2012 at 04:04:14PM +0200, Uwe Kleine-K=F6nig wrote:
> I used:
>  	movne	r0, r4
> -	movne	lr, pc
> -	movne	pc, r5
> +	blxne	r5
>  	get_thread_info tsk
>=20
> but I assume Russell's patch is better. (Probably because blx doesn't
> exist everywhere?!)

Correct.

> So if it's not too late yet:
>=20
> Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

It is, because it's already in Linus' tree.
