Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfDDSDU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 14:03:20 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
 <20190404093859.GU4038@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <6b5b03ae-d1f4-bfbb-5866-37046c8a47c8@redhat.com>
Date: Thu, 4 Apr 2019 14:03:15 -0400
MIME-Version: 1.0
In-Reply-To: <20190404093859.GU4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190404180315.0n3ap9rqkW5XFp8rjaHKdVvg1_-WrZylvDbL8I7FWlw@z>

On 04/04/2019 05:38 AM, Peter Zijlstra wrote:
> On Thu, Apr 04, 2019 at 07:05:24AM +0200, Juergen Gross wrote:
>
>> Without PARAVIRT_SPINLOCK this would be just an alternative() then?
> That could maybe work yes. This is all early enough.

Yes, alternative() should work as it is done before SMP boot. The
slowpath should never be executed before SMP boot.

Cheers,
Longman
