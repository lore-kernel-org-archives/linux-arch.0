Return-Path: <SRS0=zFKq=3O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 06:24:02 -0500
Date: Sat, 25 Jan 2020 12:23:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros
 and make them more generic
Message-ID: <20200125112341.GY11457@worktop.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-2-alex.kogan@oracle.com>
 <20200122091547.GU14879@hirez.programming.kicks-ass.net>
 <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, Will Deacon <will.deacon@arm.com>, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20200125112341.cSCox4gulD1D6B6xIbXrVS5esTopHB7ffMZIV35E0ik@z>

On Thu, Jan 23, 2020 at 06:51:11PM -0500, Alex Kogan wrote:
> > On Jan 22, 2020, at 4:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, pass_lock seems unfortunately named…

> Well, I know the guy who should be blamed for that one :)
> https://lkml.org/lkml/2019/7/16/212 <https://lkml.org/lkml/2019/7/16/212>

Ha, yes, that guy is an idiot sometimes ;-)
