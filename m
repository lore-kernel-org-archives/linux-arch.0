Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267678AbUHaJ4o@vger.kernel.org>
Received: from zero.aec.at ([193.170.194.10]:21764 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266895AbUHaJ4o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2004 05:56:44 -0400
Subject: domain setup in 2.6.9rc1-bk6
From: Andi Kleen <ak@muc.de>
Date: Tue, 31 Aug 2004 11:56:34 +0200
Message-ID: <m3llfvk4vh.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Someone deleted arch/x86_64/kernel/domain.c in current BK 
and moved the SMT domain setup to generic code.

Problem is that I need a architecture specific hook to 
turn off SMT idle for AMD dual core CPUs, which otherwise
look like SMT siblings. I suppose I will do more tunings
in this area in the future anyways, so having it in the 
architecture would be better.

It seems a bit counterintuitive that we have such a configurable
scheduler, and then there is only a "one size fits all" way
to configure it.

Can part of this code please be moved back to the architecture? 

Thanks,

-Andi
