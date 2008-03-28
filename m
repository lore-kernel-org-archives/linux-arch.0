Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:56751 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbYC1Vvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2008 17:51:37 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m2SLpa62390386
	for <linux-arch@vger.kernel.org>; Fri, 28 Mar 2008 21:51:36 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m2SLpamv4362278
	for <linux-arch@vger.kernel.org>; Fri, 28 Mar 2008 22:51:36 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m2SLpZw4023565
	for <linux-arch@vger.kernel.org>; Fri, 28 Mar 2008 22:51:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 06/24] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Fri, 28 Mar 2008 22:51:34 +0100
References: <200803282115.m2SLFscm010265@imap1.linux-foundation.org> <alpine.LFD.1.00.0803281435090.14670@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0803281435090.14670@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200803282251.34635.borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, avi@qumranet.com, dwmw2@infradead.org, linux-arch@vger.kernel.org, sam@ravnborg.org
Message-ID: <20080328215134._zE0HEmHqJqGkxwC8mcySZlGWcn4odRow9yPehPpN10@z>

Am Freitag, 28. März 2008 schrieb Linus Torvalds:
> That makes no sense. Commit 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e is 
> "include falloc.h in header-y", and seems to have nothing to do with 
> kvm.h.
[...]
> So please - add the one-liner to all SHA1 ones, so that non-git people see 
> what it is all about, and so that people who just read the commit log can 
> make sense of it. And in trying to make sense of it, it can become obvious 
> that it doesn't actually make any sense!

Sorry, you are right. The proper commit is 
fb56dbb31c4738a3918db81fd24da732ce3b4ae6 (KVM: Export include/linux/kvm.h 
only if $ARCH actually supports KVM) and I have clue at all, why I wrote 
the wrong SHA1 id. Sorry, I will double check the next time and also add 
the description.

Christian
