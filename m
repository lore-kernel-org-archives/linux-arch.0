From: David Howells <dhowells@redhat.com>
Subject: How best to write a series of related test_bit() calls?
Date: Tue, 24 Feb 2015 14:58:37 +0000
Message-ID: <22657.1424789917@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbbBXO6k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Feb 2015 09:58:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1OEweic003015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2015 09:58:40 -0500
Content-ID: <22656.1424789917.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

I have a situation where I want to do something that boils down to:

	if (test_bit(BIT_A, &p->flags) {
	   	...
	} else if (test_bit(BIT_B, &p->flags) {
		...
	} else if (test_bit(BIT_C, &p->flags) {
		...
	} else if (test_bit(BIT_D, &p->flags) {
		...
	} else if (test_bit(BIT_E, &p->flags) {
	}

Note that all bits are in the same unsigned long and I don't necessarily
expect the contents of p->flags to change whilst I'm looking at it.

Since the address parameter for test_bit() contains a 'volatile' keyword, the
compiler will emit a separate load (or bit test) for each condition when in
fact the most efficient way is almost certainly one load and a bunch of
bitwise-and or bit-test-in-register instructions.

Is it worth adding a __test_bit() that doesn't have the volatile?  Or should I
just rewrite it manually as?

	unsigned long flags = p->flags;
	if (test_bit(BIT_A, &flags) {
	   	...
	} else if (test_bit(BIT_B, &flags) {
	...

Or even:

	unsigned long flags = p->flags;
	if ((1 << BIT_A) & flags) {
	   	...
	} else if ((1 << BIT_B) & flags) {
	...

David
