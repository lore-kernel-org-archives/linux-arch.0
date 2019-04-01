Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDAJJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Apr 2019 05:09:53 -0400
Date: Mon, 1 Apr 2019 11:09:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20190401090943.GG11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190401090943.BQTUsQfHTPMZbQU4d-ZNXnW2Se3GTmj-EgeFs-RtNis@z>

On Fri, Mar 29, 2019 at 11:20:01AM -0400, Alex Kogan wrote:
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). 

The other interesting number is on a !NUMA machine. What do these
patches do there? Remember, most people do not in fact have numa.
