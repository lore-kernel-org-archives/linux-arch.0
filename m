From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 22/25] mm: Convert anon_vma->lock to a mutex
Date: Fri,  4 Feb 2011 13:35:27 +0900 (JST)
Message-ID: <20110204133458.17CE.A69D9226@jp.fujitsu.com>
References: <20110203142716.93C5.A69D9226@jp.fujitsu.com> <1296745495.26581.370.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1296745495.26581.370.camel@laptop>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>
List-Id: linux-arch.vger.kernel.org

> On Thu, 2011-02-03 at 14:27 +0900, KOSAKI Motohiro wrote:
> > > Straight fwd conversion of anon_vma->lock to a mutex.
> > >=20
> > > Acked-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >=20
> > Don't I ack this series at previous iteration? If not, Hmmm.. I haven=
't remenber
> > the reason.
>=20
> I got a +1 email from you on the spinlock to mutex conversion patch, I
> wasn't quite sure to what tag that translated.

I'm sorry. Maybe Im busy and I wrote unkindly mail. yes, it's my fault.


> >  Anyway
> > 	Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>=20
> Is this for this particular patch, or for the series?=20

series. please.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
