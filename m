Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:44966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQOxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 10:53:15 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190717085900.GS3463@hirez.programming.kicks-ass.net>
Date: Wed, 17 Jul 2019 10:52:05 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <57614CAF-AF4C-4814-A628-2D30B399C117@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
 <20190717085900.GS3463@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717145205.O2YNLjSNSDYYaai0bY8V0TStVoEqh8JulEPW-yA87nQ@z>


> On Jul 17, 2019, at 4:59 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jul 17, 2019 at 10:39:44AM +0200, Peter Zijlstra wrote:
>> On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:
>=20
>>> My primary concern was readability; I find the above suggestion much
>>> more readable. Maybe it can be written differently; you'll have to =
play
>>> around a bit.
>>=20
>> static void cna_splice_tail(struct cna_node *cn, struct cna_node =
*head, struct cna_node *tail)
>> {
>> 	struct cna_node *list;
>>=20
>> 	/* remove [head,tail] */
>> 	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
>> 	tail->mcs.next =3D NULL;
>>=20
>> 	/* stick [head,tail] on the secondary list tail */
>> 	if (cn->mcs.locked <=3D 1) {
>> 		/* create secondary list */
>> 		head->tail =3D tail;
>> 		cn->mcs.locked =3D head->encoded_tail;
>> 	} else {
>> 		/* add to tail */
>> 		list =3D (struct cna_node *)decode_tail(cn->mcs.locked);
>> 		list->tail->next =3D head;
>> 		list->tail =3D tail;
>> 	}
>> }
>>=20
>> static struct cna_node *cna_find_next(struct mcs_spinlock *node)
>> {
>> 	struct cna_node *cni, *cn =3D (struct cna_node *)node;
>> 	struct cna_node *head, *tail =3D NULL;
>>=20
>> 	/* find any next lock from 'our' node */
>> 	for (head =3D cni =3D (struct cna_node =
*)READ_ONCE(cn->mcs.next);
>> 	     cni && cni->node !=3D cn->node;
>> 	     tail =3D cni, cni =3D (struct cna_node =
*)READ_ONCE(cni->mcs.next))
>> 		;
>=20
> I think we can do away with those READ_ONCE()s, at this point those
> pointers should be stable. But please double check.

I think we can get rid of WRITE_ONCE above and the first READ_ONCE, as =
the=20
=E2=80=9Cfirst=E2=80=9D next pointer (in the node of the current lock =
holder) is stable at this
point, and is not read / written concurrently. We do need the second =
READ_ONCE
as we traverse the list and can come across a next pointer being =
changed.

=E2=80=94 Alex

>=20
>> 	/* when found, splice any skipped locks onto the secondary list =
*/
>> 	if (cni && tail)
>> 		cna_splice_tail(cn, head, tail);
>>=20
>> 	return cni;
>> }
>>=20
>> How's that?
