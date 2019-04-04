From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 4 Apr 2019 14:03:15 -0400
Message-ID: <6b5b03ae-d1f4-bfbb-5866-37046c8a47c8@redhat.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
 <20190404093859.GU4038@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404093859.GU4038@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

On 04/04/2019 05:38 AM, Peter Zijlstra wrote:
> On Thu, Apr 04, 2019 at 07:05:24AM +0200, Juergen Gross wrote:
>
>> Without PARAVIRT_SPINLOCK this would be just an alternative() then?
> That could maybe work yes. This is all early enough.

Yes, alternative() should work as it is done before SMP boot. The
slowpath should never be executed before SMP boot.

Cheers,
Longman
