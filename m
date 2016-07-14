From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
Date: Thu, 14 Jul 2016 15:44:42 +0800
Message-ID: <578742EA.7060108@linux.vnet.ibm.com>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160713195423.GD30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22211 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750739AbcGNHpM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jul 2016 03:45:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6E7iHFO013091
	for <linux-arch@vger.kernel.org>; Thu, 14 Jul 2016 03:45:11 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24567duxsa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 14 Jul 2016 03:45:10 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Thu, 14 Jul 2016 13:15:06 +0530
In-Reply-To: <20160713195423.GD30921@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com



On 2016=E5=B9=B407=E6=9C=8814=E6=97=A5 03:54, Peter Zijlstra wrote:
> On Mon, Jun 20, 2016 at 02:20:52PM +0800, Pan Xinhui wrote:
>> This patch aims to get rid of endianness in queued_write_unlock(). W=
e
>> want to set  __qrwlock->wmode to NULL, however the address is not
>> &lock->cnts in big endian machine. That causes queued_write_unlock()
>> write NULL to the wrong field of __qrwlock.
>>
>> Actually qrwlock can have same layout, IOW we can remove the #if
>> __little_endian in struct __qrwlock. With such modification, we only
>> need define some _QW* and _QR* with corresponding values in differen=
t
>> endian systems.
>>
>> Suggested-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> Acked-by: Waiman Long <Waiman.Long@hpe.com>
>> ---
>
> Urgh, I hate this stuff :/
>
> OK, so I poked at this a bit and I ended up with the below; but now
> qrwlock and qspinlock are inconsistent; although I suspect qspinlock =
is
> similarly busted wrt endian muck.
>
> Not sure what to do..
>
Lets talk about the qspinlock.

for x86, We has already assumed that ->locked sit at the low 8 bits, as=
 is
smp_store_release((u8 *)lock, 0);

Then we can do a favor, export ->locked but other fields as reserved.
say

struct __qspinlock_unlcok_interface {/* what name is better?*/
#ifdef __LITTLE_ENDIAN
		u8      locked;
		u8      reserved[3]; /* do not touch it, internally use only  */
#else
		u8      reserved[3];
		u8      locked;
#endif
};

I think it is acceptable. and we can do similar things with qrwlock, to=
o.

any thoughts?


>   /*
> - * Writer states & reader shift and bias
> + * Writer states & reader shift and bias.
> + *
> + *       | +0 | +1 | +2 | +3 |
> + *   ----+----+----+----+----+
> + *    LE | 12 | 34 | 56 | 78 | 0x12345678
> + *   ----+----+----+----+----+
> + *    BE | 78 | 56 | 34 | 12 | 0x12345678
> + *   ----+----+----+----+----+
> + *       | wr |      rd      |
> + *       +----+----+----+----+
> + *
>    */

very clearly. :)

thanks
xinhui
