Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937073AbXHMKz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Aug 2007 06:55:27 -0400
Message-ID: <46C03885.7000109@redhat.com>
Date: Mon, 13 Aug 2007 06:55:01 -0400
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
Subject: [PATCH 0/23] make atomic_read() and atomic_set() behavior consistent
 across all architectures
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, Segher Boessenkool <segher@kernel.crashing.org>, "Luck, Tony" <tony.luck@intel.com>, Chris Friesen <cfriesen@nortel.com>, "Robert P. J. Day" <rpjday@mindspring.com>, Chris Snook <csnook@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

By popular demand, I've redone the patchset to include volatile casts in 
atomic_set as well.  I've also converted the macros to inline functions, to help 
catch type mismatches at compile time.

This will do weird things on ia64 without Andreas Schwab's fix:

http://lkml.org/lkml/2007/8/10/410

Notably absent is a patch for powerpc.  I expect Segher Boessenkool's assembly 
implementation should suffice there:

http://lkml.org/lkml/2007/8/10/470

Thanks to all who commented on previous incarnations.

	-- Chris Snook
