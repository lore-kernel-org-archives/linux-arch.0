Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j19CK8vU212356
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 12:20:08 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j19CK8n1146716
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 13:20:08 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j19CK7Tq030170
	for <linux-arch@vger.kernel.org>; Wed, 9 Feb 2005 13:20:07 +0100
In-Reply-To: <20050209103139.GA3387@wotan.suse.de>
Subject: Re: [PATCH] Fix compat shmget overflow
Message-ID: <OF7A093288.675DC94F-ON41256FA3.0042F2DF-41256FA3.0043C2ED@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 9 Feb 2005 13:20:08 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, anton@samba.org, corryk@us.ibm.com, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote on 09.02.2005 11:31:39:

> > As you mention sys_shmget, I'm currently trying to find out why the
> > second argument of sys_ipc for ppc64, s390-64 and sparc64 has been
> > changed from "long" to "int". This limits the maximum size of a shared
> > memory segment to 2GB for the three archs. A cast to unsigned would
> > allow 4GB, still not enough for a 64 bit architecture in the long run.
> > Before I submit a patch to replace "int" with "long" again I'd like
> > to understand the reason for the change.
>
> I don't know. Look up the Cset at linux.bkbits.net and if it's not clear
> from the description ask the submitter?

Wasn't that easy because arch/s390x/.. isn't under revision control anymore.
Everything in arch/s390x and include/asm-s390x has been removed with 2.5.68.
This is at the same time the revision the shmget bug has been introduced to
s390-64. The second parameter of sys_ipc has been a "long" in the s390x version
of sys_s390.c until s390x got merged into s390 with the step from 2.5.67
to 2.5.68.
That explains it for s390-64 and I'll fix this by changing "int second" to
"unsigned long second" and adding a few casts. While I'm at it I'll fix this
for ppc64 and sparc64 as well.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
