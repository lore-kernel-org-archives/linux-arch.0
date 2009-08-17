From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Mon, 17 Aug 2009 12:26:32 +0200
Message-ID: <20090817102632.GA5629@osiris.boeblingen.de.ibm.com>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
 <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
 <20090814.131900.229343660.davem@davemloft.net>
 <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
 <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain>
 <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908161143410.3162@localhost.localdomain>
 <20090816203650.GB27764@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8.uk.ibm.com ([195.212.29.141]:56748 "EHLO
	mtagate8.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbZHQK0n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Aug 2009 06:26:43 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate8.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7HAQYbx562844
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 10:26:34 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7HAQYFF1429570
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 11:26:34 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7HAQXd3021215
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 11:26:34 +0100
Content-Disposition: inline
In-Reply-To: <20090816203650.GB27764@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

On Sun, Aug 16, 2009 at 10:36:50PM +0200, Ingo Molnar wrote:
> > > An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 
> > > 4.3.2 results in the following vmlinux sizes:
> > > 
> > > 574152755 2009-08-16 20:05 vmlinux-orig
> > > 574862000 2009-08-16 20:13 vmlinux-skb-inline
> > 
> > It's more relevant to look at just code size. BUG_ON() has more of 
> > an impact on data sizes, because it does something like 10-12 
> > bytes of exception data for each bug-on. But that exception data 
> > is out-of-line and not interesting.
> > 
> > If the code size blows up a lot, that's worse than if the data 
> > size expands a bit.
> 
> Also, allyesconfig isnt really relevant to inlining cost in general 
> as it enables everything. The defconfigs are better (at least on 
> x86) because they tend to be some distro-alike config - i.e. they 
> are closer to what most Linux users will run in the end.

Ok, I'm still using allyesconfig but still these numbers should be
good enough:

For the unpatched kernel we have

ffffffff81009000 T _stext
ffffffff83614130 T _etext
size: 39891248

ffffffff8460e250 R __start___bug_table
ffffffff8462e9ec R __stop___bug_table
size: 133020

And for the patched kernel (inlined functions) we get

ffffffff81009000 T _stext
ffffffff83627250 T _etext
size: 39969360

ffffffff84621080 R __start___bug_table
ffffffff84649c4c R __stop___bug_table
size: 166860

We have CONFIG_GENERIC_BUG, CONFIG_GENERIC_BUG_RELATIVE_POINTERS and
CONFIG_DEBUG_BUGVERBOSE all enabled. So the size of each bug table entry
is 10 bytes.
We end up with 3384 additional bug table entries caused by inlining.
Text size increased by 78112 bytes which makes an average extra 23 bytes
for each call site.
