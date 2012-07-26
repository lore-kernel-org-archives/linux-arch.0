From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] page-table walkers vs memory order
Date: Thu, 26 Jul 2012 22:39:29 +0200
Message-ID: <1343335169.32120.18.camel@twins>
References: <1343064870.26034.23.camel@twins>
	 <alpine.LSU.2.00.1207241356350.2094@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LSU.2.00.1207241356350.2094@eggly.anvils>
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@kernel.dk>, Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2012-07-24 at 14:51 -0700, Hugh Dickins wrote:
> I do love the status quo, but an audit would be welcome.  When
> it comes to patches, personally I tend to prefer ACCESS_ONCE() and
> smp_read_barrier_depends() and accompanying comments to be hidden away
> in the underlying macros or inlines where reasonable, rather than
> repeated all over; but I may have my priorities wrong on that.
>=20
>=20
Yeah, I was being lazy, and I totally forgot to actually look at the
alpha code.

How about we do a generic (cribbed from rcu_dereference):

#define page_table_deref(p)					\
({								\
	typeof(*p) *______p =3D (typeof(*p) __force *)ACCESS_ONCE(p);\
	smp_read_barrier_depends();				\
	((typeof(*p) __force __kernel *)(______p));		\
})

and use that all over to dereference page-tables. That way all this
lives in one place. Granted, I'll have to go edit all arch code, but I
seem to be doing that on a frequent basis anyway :/


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
