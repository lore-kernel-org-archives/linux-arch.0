Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:46905 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYBFLNB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2008 06:13:01 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m16BD0wD173636
	for <linux-arch@vger.kernel.org>; Wed, 6 Feb 2008 11:13:00 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m16BCxq22326528
	for <linux-arch@vger.kernel.org>; Wed, 6 Feb 2008 12:12:59 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m16BCw4E018584
	for <linux-arch@vger.kernel.org>; Wed, 6 Feb 2008 12:12:59 +0100
Date: Wed, 6 Feb 2008 12:12:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
Message-ID: <20080206111258.GA1742@osiris.boeblingen.de.ibm.com>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org> <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com> <20080206110425.GB25012@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080206110425.GB25012@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>, torvalds@linux-foundation.org, davidel@xmailserver.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de

> Wasn't there a decision at a kernel summit that anything which adds
> new syscalls should have a test program included so that architecture
> maintainers can test the functionality on their architectures?
> 
> I seem to remember that it came up because the merged timerfd was a
> pile of utter crap which didn't have a hope in hells chance of working.
> 
> So... where is the new timerfd test program?

As described in git commit 4d672e7ac79b5ec5cdc90e450823441e20464691 it's here:
http://www.xmailserver.org/timerfd-test2.c
I used it to test the s390 backend.
