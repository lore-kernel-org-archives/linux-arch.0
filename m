Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:39552 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263536AbUCTUb2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 15:31:28 -0500
Subject: Re: compat-signal-noarch-2004-01-29.patch again
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040320122048.70db9888.akpm@osdl.org>
References: <20040319214949.6b7d50bc.akpm@osdl.org>
	<20040320051519.780318b8.ak@suse.de>
	<20040319223744.1f003f9f.akpm@osdl.org>
	<20040320055753.27517d88.ak@suse.de>
	<20040320133634.GU25059@parcelfarce.linux.theplanet.co.uk>
	<20040320122048.70db9888.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 20 Mar 2004 15:31:13 -0500
Message-Id: <1079814674.1778.148.camel@mulgrave>
Mime-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, ak@suse.de, linux-arch@vger.kernel.org, Carlos O'Donell <carlos@baldric.uwo.ca>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2004-03-20 at 15:20, Andrew Morton wrote:
> I can sort-of-see Andi's worry.
> 
> The issue appears to be that at some time in the future he will have 64-bit
> applications using the 32-bit API without PER_LINUX32 set.  So the proposed
> is_compat_task() is meaningless in this context - hence Andi doesn't want
> is_compat_task() propagated around the place.
> 
> This begs the question of how his kernel correctly handle these
> pseudo-32-bit tasks.

Actually, I'd take the opposite view:  is_compat_task() abstracts out
the job of discovering whether the task is using the 32 bit API on 64
bits.

However it's done on every arch that supports it, there must be always
an unequivocal answer to "is this task running 32 bits?" which this
macro supplies.  I agree it's not always going to be dependent on
PER_LINUX32 being set, but providing arch's with a way to override it
answers that point, I think.

It's in generic code because there's a standard way of identifying these
compat tasks (PER_LINUX32) and it's overrideable for arch's that want to
do it in a non-standard way.

James
