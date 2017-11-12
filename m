Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750977AbdKLXv7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 12 Nov 2017 18:51:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vACNpKsu024395
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2017 18:51:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e6nyf472w-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2017 18:51:58 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <benh@au1.ibm.com>;
        Sun, 12 Nov 2017 23:51:55 -0000
Subject: Re: [RFC PATCH v2] Fix: x86: Add missing core serializing
 instruction on migration
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Mon, 13 Nov 2017 10:51:47 +1100
In-Reply-To: <1510529164.12797.41.camel@kernel.crashing.org>
References: <20171111150357.26072-1-mathieu.desnoyers@efficios.com>
         <1510529164.12797.41.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <1510530707.12797.42.camel@au1.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrea Parri <parri.andrea@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch@vger.kernel.org, stable@kernel.org
Message-ID: <20171112235147.1ae-9od_oApXsCEG-30WmES_rnlel9qLchQTO4laNno@z>

On Mon, 2017-11-13 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2017-11-11 at 10:03 -0500, Mathieu Desnoyers wrote:
> > x86 has a missing core serializing instruction in migration scenarios.
> > 
> > Given that x86-32 can return to user-space with sysexit, and x86-64
> > through sysretq and sysretl, which are not core serializing, the
> > following user-space self-modifiying code (JIT) scenario can occur:
> 
> Is this about load/store consistency ? In this case, don't you also
> have problems with get/put_user and not just going to userspace ?

Ah forget it, I saw Linus earlier messages.

Cheers,
Ben.
