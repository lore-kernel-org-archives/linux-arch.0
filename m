Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:40106 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCROJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 13:14:09 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190401090943.GG11158@hirez.programming.kicks-ass.net>
Date: Wed, 3 Apr 2019 13:13:39 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <6E1DD598-2493-4C81-9CB6-8024E9244574@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190401090943.GG11158@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403171339.8lYlVPlYdXcpJSUBhXfW-isf31E6vv-MNxwC3GsAKjc@z>


> On Apr 1, 2019, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 29, 2019 at 11:20:01AM -0400, Alex Kogan wrote:
>> The following locktorture results are from an Oracle X5-4 server
>> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
>> cores each).=20
>=20
> The other interesting number is on a !NUMA machine. What do these
> patches do there? Remember, most people do not in fact have numa.
I will make sure to include numbers from a !NUMA machine in the next =
revision of the patch.

Regards,
=E2=80=94 Alex=
