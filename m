From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Please include const-sections into linux-next
Date: Sun, 16 Oct 2011 05:35:14 +0200
Message-ID: <20111016033514.GC26654@one.firstfloor.org>
References: <20111013233818.GB26654@one.firstfloor.org> <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56155 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab1JPDfV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2011 23:35:21 -0400
Content-Disposition: inline
In-Reply-To: <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> I have no idea why, though.

Thanks for testing.

Yes it's hard to tell with plain gcc (before 4.7)
I have a special gcc patch to tell me the other symbol :)

Usually it's because some other symbol is wrong. In this 
case it must be in the same translation unit.

Can you please do

make mm/percpu.i 

on that build and send me the percpu.i in private email?

Thanks,
-Andi
