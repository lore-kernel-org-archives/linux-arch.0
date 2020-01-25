From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Date: Sat, 25 Jan 2020 14:41:39 -0500
Message-ID: <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgAYTlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 14:41:52 -0500
In-Reply-To: <20200125045844.GC2935@paulmck-ThinkPad-P72>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com

On 1/24/20 11:58 PM, Paul E. McKenney wrote:
> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
>> On 1/24/20 8:59 PM, Waiman Long wrote:
>>>> You called it!  I will play with QEMU's -numa argument to see if I can get
>>>> CNA to run for me.  Please accept my apologies for the false alarm.
>>>>
>>>> 							Thanx, Paul
>>>>
>>> CNA is not currently supported in a VM guest simply because the numa
>>> information is not reliable. You will have to run it on baremetal to
>>> test it. Sorry for that.
>> Correction. There is a command line option to force CNA lock to be used
>> in a VM. Use the "numa_spinlock=on" boot command line parameter.
> As I understand it, I need to use a series of -numa arguments to qemu
> combined with the numa_spinlock=on (or =1) on the kernel command line.
> If the kernel thinks that there is only one NUMA node, it appears to
> avoid doing CNA.
>
> Correct?
>
> 							Thanx, Paul
>
In auto-detection mode (the default), CNA will only be turned on when
paravirt qspinlock is not enabled first and there are at least 2 numa
nodes. The "numa_spinlock=on" option will force it on even when both of
the above conditions are false.

Cheers,
Longman
