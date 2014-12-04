From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 9/9] kernel: tighten rules for ACCESS ONCE
Date: Thu, 04 Dec 2014 10:28:25 +0100
Message-ID: <54802939.8010701@de.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com> <1417645821-54731-10-git-send-email-borntraeger@de.ibm.com> <20141204001621.GF25340@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:33413 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbaLDJ2a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Dec 2014 04:28:30 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 4 Dec 2014 09:28:28 -0000
In-Reply-To: <20141204001621.GF25340@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

Am 04.12.2014 um 01:16 schrieb Paul E. McKenney:
>>   * merging, or refetching absolutely anything at any time.  Its main intended
>> >   * use is to mediate communication between process-level code and irq/NMI
>> >   * handlers, all running on the same CPU.
> This comment is obsolete in the same way as that of READ_ONCE() and
> ASSIGN_ONCE(), but probably more to the point to just get rid of
> ACCESS_ONCE().  ;-)
> 
>> > 

Its now 

/*
 * Prevent the compiler from merging or refetching accesses.  The compiler
 * is also forbidden from reordering successive instances of ACCESS_ONCE(),
 * but only when the compiler is aware of some particular ordering.  One way
 * to make the compiler aware of ordering is to put the two invocations of
 * ACCESS_ONCE() in different C statements.
 *
 * ACCESS_ONCE will only work on scalar types. For union types, ACCESS_ONCE
 * on a union member will work as long as the size of the member matches the
 * size of the union and the size is smaller than word size.
 *
 * The major use cases of ACCESS_ONCE used to be (1) Mediating communication
 * between process-level code and irq/NMI handlers, all running on the same CPU,
 * and (2) Ensuring that the compiler does not  fold, spindle, or otherwise
 * mutilate accesses that either do not require ordering or that interact
 * with an explicit memory barrier or atomic instruction that provides the
 * required ordering.
 *
 * If possible use READ_ONCE/ASSIGN_ONCE instead.
 */
