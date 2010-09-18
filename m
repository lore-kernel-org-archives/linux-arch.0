From: Greg McGary <greg@mcgary.org>
Subject: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sat, 18 Sep 2010 14:42:35 -0700
Message-ID: <4C95324B.2030707@mcgary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:60099 "EHLO
	mpls-qmqp-04.inet.qwest.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753304Ab0IRVt7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 18 Sep 2010 17:49:59 -0400
Received: from giga.mcgary.org (unknown [65.101.31.122])
	by mpls-qmqp-04.inet.qwest.net (Postfix) with ESMTP id 3E9B522DCB5
	for <linux-arch@vger.kernel.org>; Sat, 18 Sep 2010 21:42:41 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

  I am porting Linux to a new architecture (a massively multi-threaded network processor), which has a unique and bothersome characteristic: sizeof (void*) > sizeof (long).  In most regards, it is a 32-bit machine, but pointers and all GPRs are 48 bit.  Pointers occupy 64 bits in memory, with 16 bits ignored by load/store.

Unfortunately, the kernel is thick with pointer/int casts and universally assumes that sizeof (void*) == sizeof(long).  The first phase of the port is s/long/intptr_t/ and s/unsigned long/uintptr_t/ for data that hold addresses and for casts to/from address data.  I think it improves code comprehensibility to use (u)intptr_t for opaque types and for address arithmetic.  I'm three weeks into the project and have almost 5000 changes.  I probably have another week and a few thousand more to go before I have eliminated the pointer/int cast warnings and can work on more substantive phases.

For most (all?) existing ports, (u)intptr_t=(unsigned) long, so in theory there should be zero change to the compiled Linux image for conventional ILP=32 LP=64 architectures.

If the intent is really to extend or truncate with a cast between pointer and integer, it can be done like so:

     void *ptr;
     long l;
     int i;
     long long ll;

     ptr = (void *)(intptr_t) l;
     l = (long)(intptr_t) ptr;

     ptr = (void *)(intptr_t) ll;
     ll = (long long)(intptr_t) ptr;

     ptr = (void *)(intptr_t) i;
     i = (int)(intptr_t) ptr;

Are maintainers willing to accept patches to covert from (unsigned) long and (u)intptr_t ?  I propose to do this in many small installments for digestibility and to moderate the downstream impact of merge conflicts.

G
