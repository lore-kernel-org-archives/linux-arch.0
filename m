Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268582AbUJTQ1A@vger.kernel.org>
Received: from fmr06.intel.com ([134.134.136.7]:48261 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266679AbUJTQX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2004 12:23:57 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 4level page tables architecture porting
Date: Wed, 20 Oct 2004 09:23:39 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F023640E7@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Andi Kleen <ak@suse.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>I don't see how that would work. The stack is always at the top
>and .text is near the beginning, so you need the maximum range of 
>address space, which means all possible levels.

It doesn't have to be that way ... you could start the stack in the
'middle' growing down towards the heap, and put the mmap playground
above the stack (growing up).  Here I'd define 'middle' as the
mid-point of the virtual space mappable with three level tables
so about half the space is available for mmap, shared mem, shared
libs etc.  If a process runs out of mmap virtual space, it can
switch to 4-levels.

-Tony
