From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 5/5] locking/qspinlock: Introduce the shuffle reduction
 optimization into CNA
Date: Fri, 6 Dec 2019 17:00:24 -0500
Message-ID: <1fce5ebf-7f80-fb9e-92b1-74062a6611a5@redhat.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-6-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191125210709.10293-6-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

On 11/25/19 4:07 PM, Alex Kogan wrote:
> @@ -234,12 +263,13 @@ __always_inline u32 cna_pre_scan(struct qspinlock *=
lock,
>  =09struct cna_node *cn =3D (struct cna_node *)node;
> =20
>  =09/*
> -=09 * setting @pre_scan_result to 1 indicates that no post-scan
> +=09 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
>  =09 * should be made in cna_pass_lock()
>  =09 */
>  =09cn->pre_scan_result =3D
> -=09=09cn->intra_count =3D=3D intra_node_handoff_threshold ?
> -=09=09=091 : cna_scan_main_queue(node, node);
> +=09=09(node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> +=09=09=091 : cn->intra_count =3D=3D intra_node_handoff_threshold ?
> +=09=09=092 : cna_scan_main_queue(node, node);
> =20
>  =09return 0;
>  }
> @@ -253,12 +283,15 @@ static inline void cna_pass_lock(struct mcs_spinloc=
k *node,
> =20
>  =09u32 scan =3D cn->pre_scan_result;
> =20
> +=09if (scan =3D=3D 1)
> +=09=09goto pass_lock;
> +
>  =09/*
>  =09 * check if a successor from the same numa node has not been found in
>  =09 * pre-scan, and if so, try to find it in post-scan starting from the
>  =09 * node where pre-scan stopped (stored in @pre_scan_result)
>  =09 */
> -=09if (scan > 1)
> +=09if (scan > 2)
>  =09=09scan =3D cna_scan_main_queue(node, decode_tail(scan));
> =20
>  =09if (!scan) { /* if found a successor from the same numa node */
> @@ -281,5 +314,6 @@ static inline void cna_pass_lock(struct mcs_spinlock =
*node,
>  =09=09tail_2nd->next =3D next;
>  =09}
> =20
> +pass_lock:
>  =09arch_mcs_pass_lock(&next_holder->locked, val);
>  }

I think you might have mishandled the proper accounting of intra_count.
How about something like:

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.=
h
index f1eef6bece7b..03f8fdec2b80 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -268,7 +268,7 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock=
,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->pre_scan_result =3D
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (node->locked <=3D 1 &&
probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count =3D=3D
intra_node_handoff_threshold ?
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count >=3D
intra_node_handoff_threshold ?
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 : cna_sca=
n_main_queue(node, node);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
@@ -283,9 +283,6 @@ static inline void cna_pass_lock(struct mcs_spinlock
*node,
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 scan =3D cn->pre_scan_result=
;
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan =3D=3D 1)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto pass_lock;
-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check if a successor fro=
m the same numa node has not been
found in
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pre-scan, and if so, try=
 to find it in post-scan starting
from the
@@ -294,7 +291,13 @@ static inline void cna_pass_lock(struct
mcs_spinlock *node,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan > 2)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 scan =3D cna_scan_main_queue(node, decode_tail(scan));
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!scan) { /* if found a successor =
from the same numa node */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan <=3D 1) { /* if found a succ=
essor from the same numa node */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not empty */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((scan =3D=3D 1)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto pass_lock=
;
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 next_holder =3D node->next;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * we unlock successor by passing a non-zero value,
@@ -302,9 +305,6 @@ static inline void cna_pass_lock(struct mcs_spinlock
*node,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * if we acquired the MCS lock when its queue was empt=
y
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 val =3D node->locked ? node->locked : 1;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not empty */
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (node->locked > 1) {=
=C2=A0=C2=A0=C2=A0 /* if secondary queue is not
empty */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* next holder will be the first node in the secondary
queue */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tail_2nd =3D decode_tail(node->locked);

The meaning of scan value:

0 - pass to next cna node, which is in the same numa node. Additional
cna node may or may not be added to the secondary queue

1 - pass to next cna node, which may not be in the same numa node. No
change to secondary queue

2 - exceed intra node handoff threshold, unconditionally merge back the
secondary queue cna nodes, if available

>2 no cna node of the same numa node found, unconditionally merge back
the secondary queue cna nodes, if available

The code will be easier to read if symbolic names instead of just numbers.

Cheers,
Longman
