Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:54590 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965472AbWI0Jbf
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Sep 2006 05:31:35 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8R9VYfn119066
	for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2006 09:31:34 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8R9XWCY2556106
	for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2006 11:33:32 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8R9VXT2017603
	for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2006 11:31:33 +0200
Subject: Re: Fw: [PATCH] Fix zeroing on exception in copy_*_user
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060926171150.bab8a5c1.akpm@osdl.org>
References: <20060926171150.bab8a5c1.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 11:31:32 +0200
Message-Id: <1159349492.24891.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-26 at 17:11 -0700, Andrew Morton wrote:
> I guess other architectures will need to do this.  See
> 01408c4939479ec46c15aa7ef6e2406be50eeeca and
> 7c12d81134b130ccd4c286b434ca48c4cda71a2f for the rationale.

Urgh, s390 does not have the problem that is does pad the leftover bytes
in __copy_from_user_inatomic but that is does NOT pad the leftover bytes
in __copy_from_user ..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


