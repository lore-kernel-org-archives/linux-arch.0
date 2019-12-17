From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 5/5] locking/qspinlock: Introduce the shuffle reduction
 optimization into CNA
Date: Tue, 17 Dec 2019 15:05:13 -0500
Message-ID: <64c7b7fd-079c-55d1-258c-8c23802b992d@redhat.com>
References: <f1164ae9-ebcf-41f0-8395-224cdb0f249d@default>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1164ae9-ebcf-41f0-8395-224cdb0f249d@default>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: rahul.x.yadav@oracle.com, tglx@linutronix.de, linux@armlinux.org.uk, hpa@zytor.com, dave.dice@oracle.com, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, jglauber@marvell.com, guohanjun@huawei.com, x86@kernel.org, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, bp@alien8.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/10/19 1:56 PM, Alex Kogan wrote:
> ----- longman@redhat.com wrote:
>
>> On 11/25/19 4:07 PM, Alex Kogan wrote:
>>> @@ -234,12 +263,13 @@ __always_inline u32 cna_pre_scan(struct
>> qspinlock *lock,
>>>  	struct cna_node *cn =3D (struct cna_node *)node;
>>> =20
>>>  	/*
>>> -	 * setting @pre_scan_result to 1 indicates that no post-scan
>>> +	 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
>>>  	 * should be made in cna_pass_lock()
>>>  	 */
>>>  	cn->pre_scan_result =3D
>>> -		cn->intra_count =3D=3D intra_node_handoff_threshold ?
>>> -			1 : cna_scan_main_queue(node, node);
>>> +		(node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
>>> +			1 : cn->intra_count =3D=3D intra_node_handoff_threshold ?
>>> +			2 : cna_scan_main_queue(node, node);
>>> =20
>>>  	return 0;
>>>  }
>>> @@ -253,12 +283,15 @@ static inline void cna_pass_lock(struct
>> mcs_spinlock *node,
>>> =20
>>>  	u32 scan =3D cn->pre_scan_result;
>>> =20
>>> +	if (scan =3D=3D 1)
>>> +		goto pass_lock;
>>> +
>>>  	/*
>>>  	 * check if a successor from the same numa node has not been found
>> in
>>>  	 * pre-scan, and if so, try to find it in post-scan starting from
>> the
>>>  	 * node where pre-scan stopped (stored in @pre_scan_result)
>>>  	 */
>>> -	if (scan > 1)
>>> +	if (scan > 2)
>>>  		scan =3D cna_scan_main_queue(node, decode_tail(scan));
>>> =20
>>>  	if (!scan) { /* if found a successor from the same numa node */
>>> @@ -281,5 +314,6 @@ static inline void cna_pass_lock(struct
>> mcs_spinlock *node,
>>>  		tail_2nd->next =3D next;
>>>  	}
>>> =20
>>> +pass_lock:
>>>  	arch_mcs_pass_lock(&next_holder->locked, val);
>>>  }
>> I think you might have mishandled the proper accounting of
>> intra_count.
>> How about something like:
>>
>> diff --git a/kernel/locking/qspinlock_cna.h
>> b/kernel/locking/qspinlock_cna.h
>> index f1eef6bece7b..03f8fdec2b80 100644
>> --- a/kernel/locking/qspinlock_cna.h
>> +++ b/kernel/locking/qspinlock_cna.h
>> @@ -268,7 +268,7 @@ __always_inline u32 cna_pre_scan(struct qspinlock
>> *lock,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->pre_scan_result =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (node->locked <=3D 1 &&
>> probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->i=
ntra_count =3D=3D
>> intra_node_handoff_threshold ?
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->i=
ntra_count >=3D
>> intra_node_handoff_threshold ?
> We reset =E2=80=98intra_count' in cna_init_node(), which is called befo=
re we enter=20
> the slow path, and set it at most once when we pass the internal (CNA) =
lock
> by taking the owner=E2=80=99s value + 1. Only after we get the internal=
 lock, we
> call this cna_pre_scan() function, where we check the threshold.=20
> IOW, having 'intra_count > intra_node_handoff_threshold' would mean a b=
ug,=20
> and having =E2=80=9C>=3D=E2=80=9C would mask it.=20
> Perhaps I can add WARN_ON(cn->intra_count > intra_node_handoff_threshol=
d)
> here instead, although I'm not sure if that is a good idea performance-=
wise.

The code that I added below could have the possibility of making
intra_count > intra_node_handoff_threshold. I agree with your assessment
of the current code. This conditional check is fine if no further change
is made.


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 : cn=
a_scan_main_queue(node, node);
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -283,9 +283,6 @@ static inline void cna_pass_lock(struct
>> mcs_spinlock
>> *node,
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 scan =3D cn->pre_scan_r=
esult;
>> =C2=A0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan =3D=3D 1)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto pass_lock;
>> -
> The thing is that we want to avoid as much of the shuffling-related ove=
rhead
> as we can when the spinlock is only lightly contended. That's why we ha=
ve this
> early exit here that avoids the rest of the logic of triaging through p=
ossible
> 'scan' values.
That is a valid point. Maybe you can document that fact you are
optimizing for performance instead of better correctness.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check if a successo=
r from the same numa node has not been
>> found in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pre-scan, and if so=
, try to find it in post-scan starting
>> from the
>> @@ -294,7 +291,13 @@ static inline void cna_pass_lock(struct
>> mcs_spinlock *node,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan > 2)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 scan =3D cna_scan_main_queue(node, decode_tail(scan));
>> =C2=A0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!scan) { /* if found a succe=
ssor from the same numa node
>> */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan <=3D 1) { /* if found a=
 successor from the same numa
>> node */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not
>> empty */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra=
_count + (node->locked > 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if ((scan =3D=3D 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto pass=
_lock;
>> +
> Hmm, I am not sure this makes the code any better/more readable,
> while this does add the overhead of going through 3 branches before
> jumping to 'pass_lock'.
>
This is just a suggestion for improving the correctness of the code. I
am fine if you opt for better performance.

Cheers,
Longman
