From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 00/15] decouple pagefault_disable() from
 preempt_disable()
Date: Mon, 18 May 2015 15:04:10 +0200
Message-ID: <1431954250.3322.0.camel@twins>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	 <alpine.DEB.2.11.1505151620390.4225@nanos>
	 <20150518144624.3fb3fa46@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150518144624.3fb3fa46@thinkpad-w530>
Sender: owner-linux-mm@kvack.org
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2015-05-18 at 14:46 +0200, David Hildenbrand wrote:
> > Thanks for picking that up (again)!
> >=20
> > We've pulled the lot into RT and unsurprisingly it works like a charm :=
)
> >=20
> > Works on !RT as well.=20
> >=20
> > Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>
> >=20
>=20
> Thanks a lot Thomas!
>=20
> @Ingo, @Andrew, nothing changed during the review of this version and Tho=
mas
> gave it a review + test.
>=20
> Any of you willing to pick this up to give it a shot? Or should I resend =
it with
> Thomas' tags added.

I've got it queued.

Thanks!

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
