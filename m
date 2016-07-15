From: panxinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Fri, 15 Jul 2016 14:28:29 +0800
Message-ID: <51cf6c4c-3626-c03d-a88a-955e14c6a4e5@linux.vnet.ibm.com>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160713195423.GD30921@twins.programming.kicks-ass.net>
 <578742EA.7060108@linux.vnet.ibm.com>
 <20160714093733.GF30909@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27495 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751804AbcGOG2T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Jul 2016 02:28:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6F6OQNT066245
	for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2016 02:28:19 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 246k21392q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2016 02:28:18 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui@linux.vnet.ibm.com>;
	Fri, 15 Jul 2016 00:28:18 -0600
In-Reply-To: <20160714093733.GF30909@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com



=E5=9C=A8 16/7/14 17:37, Peter Zijlstra =E5=86=99=E9=81=93:
> On Thu, Jul 14, 2016 at 03:44:42PM +0800, xinhui wrote:
>>> OK, so I poked at this a bit and I ended up with the below; but now
>>> qrwlock and qspinlock are inconsistent; although I suspect qspinloc=
k is
>>> similarly busted wrt endian muck.
>>>
>>> Not sure what to do..
>>>
>> Lets talk about the qspinlock.
>>
>> for x86, We has already assumed that ->locked sit at the low 8 bits,=
 as is
>> smp_store_release((u8 *)lock, 0);
>
> Right, true on x86 though :-) I noticed your PPC patches have a +3 in
> there conditional on __BIG_ENDIAN.
>
>> Then we can do a favor, export ->locked but other fields as reserved=
=2E
>> say
>>
>> struct __qspinlock_unlcok_interface {/* what name is better?*/
>> #ifdef __LITTLE_ENDIAN
>> 		u8      locked;
>> 		u8      reserved[3]; /* do not touch it, internally use only  */
>> #else
>> 		u8      reserved[3];
>> 		u8      locked;
>> #endif
>> };
>
> Right, maybe, although something like:
>
> static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
> {
> 	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
> }
>
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
> {
> 	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
> }
>
> is shorter?
>

yes, looks simpler. I will take them into my patch. thanks


>
>>>  /*
>>> + * Writer states & reader shift and bias.
>>> + *
>>> + *       | +0 | +1 | +2 | +3 |
>>> + *   ----+----+----+----+----+
>>> + *    LE | 12 | 34 | 56 | 78 | 0x12345678
>>> + *   ----+----+----+----+----+
>>> + *    BE | 78 | 56 | 34 | 12 | 0x12345678
>>> + *   ----+----+----+----+----+
>>> + *       | wr |      rd      |
>>> + *       +----+----+----+----+
>>> + *
>>>   */
>>
>> very clearly. :)
>
> I did one for the qspinlock code too..
>

hmm, pretty nice, I think I can include them into my patch too while I =
am at it.

thanks
xinhui

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index b2caec7315af..9191dc454e96 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -120,6 +120,23 @@ static inline __pure struct mcs_spinlock *decode=
_tail(u32 tail)
>   *
>   * This internal structure is also used by the set_locked function w=
hich
>   * is not restricted to _Q_PENDING_BITS =3D=3D 8.
> + *
> + *       | +0 | +1 | +2 | +3 |
> + *   ----+----+----+----+----+
> + *    LE | 78 | 56 | 34 | 12 |	val =3D 0x12345678
> + *   ----+----+----+----+----+
> + *    LE | 34 | 12 |		locked_pending =3D 0x1234
> + *   ----+----+----+----+----+
> + *       | L  | P  |  tail   |
> + *       +----+----+----+----+
> + *
> + *   ----+----+----+----+----+
> + *    BE | 12 | 34 | 56 | 78 |	val =3D 0x12345678
> + *   ----+----+----+----+----+
> + *    BE           | 12 | 34 |	locked_pending =3D 0x1234
> + *   ----+----+----+----+----+
> + *       |  tail   | P  | L  |
> + *       +----+----+----+----+
>   */
>  struct __qspinlock {
>  	union {
>
