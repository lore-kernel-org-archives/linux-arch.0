From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/4] [RFC] mcount address adjustment
Date: Thu, 12 May 2011 11:24:54 +0200
Message-ID: <20110512112454.2fa7e6d6@mschwide>
References: <20110510081039.241831019@de.ibm.com>
	<BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:51898 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab1ELJZE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2011 05:25:04 -0400
Received: from d06nrmr1307.portsmouth.uk.ibm.com (d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4C9Ov9J016619
	for <linux-arch@vger.kernel.org>; Thu, 12 May 2011 09:24:57 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4C9Ov4x2351314
	for <linux-arch@vger.kernel.org>; Thu, 12 May 2011 10:24:57 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4C9OtkN012454
	for <linux-arch@vger.kernel.org>; Thu, 12 May 2011 03:24:57 -0600
In-Reply-To: <BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rabin Vincent <rabin@rab.in>
Cc: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, 11 May 2011 22:53:55 +0530
Rabin Vincent <rabin@rab.in> wrote:

> On Tue, May 10, 2011 at 13:40, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > That leaves arm as the last remaining architecture with a non trivial
> > ftrace_call_adjust function. There the least significant bit is removed
> > from the address with an and operation. The comment says this is done
> > for Thumb-2. This implies that for Thumb-1 the offset is 0 and for
> > Thumb-2 the offset is -1, correct?
> 
> ARM supports building the kernel using either the ARM instruction set or
> the Thumb-2 instruction set.  The kernel cannot be built with the
> "Thumb-1" instruction set (btw usually referred to as just Thumb).
> 
> Thumb-2 via recordmcount.pl needs the clearing of the lsb because the
> relocation (R_ARM_ABS32) that gets used for the assembly file
> that recordmcount.pl generates and assembles dictates that the lsb be
> set if the target symbol is Thumb/Thumb-2 function.  mcount_adjust would
> not help here since the ORing is done later, when the relocation is
> applied.

Hmm, from what I can make out the C version of recordmcount uses R_ARM_ABS32
as well. 
 
> Thumb-2 via recordmcount.c does not need the clearing of the lsb in
> ftrace_call_adjust.

So the clearing of the lsb is only required if the recordmcount.pl script
is used?

> Building with the ARM instruction set also does not need the clearing
> of the lsb.

Who does the ORing? I can't find anything in recordmount.pl/recordmcount.c
which looks like doing an OR, does the assembler do that based on the
symbol type?

> > Thumb-2 the offset is -1, correct? If there is a way to distinguish
> > the two targets in recordmcount at compile time we could convert arm
> > as well. Which would allow us to remove the ftrace_call_adjust function.
> 
> To remove ftrace_call_adjust, we could either deprecate the
> recordmcount.pl usage for ARM (you already have to edit the Kconfig to
> use it) or modify it to generate specific relocations explicitly instead
> of using the assembler data directives.

Hmm, it would be a desirable property if the C version and the pearl
version of recordmcount would do the same. Or we could remove the arm
support from the pearl script, the C version is faster anyway.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
