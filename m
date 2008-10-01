From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: RFC: remove ibcs2/PER_SVR4?
Date: Wed, 01 Oct 2008 18:17:41 +0200
Message-ID: <1222877861.32562.14.camel@localhost>
References: <1222850741.32562.4.camel@localhost>
	 <20081001160827.GA13102@linux-mips.org>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38344 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYJAQZz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Oct 2008 12:25:55 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m91GPrYA277736
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 16:25:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m91GPqxn1056880
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 18:25:52 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m91GPnZv010221
	for <linux-arch@vger.kernel.org>; Wed, 1 Oct 2008 18:25:49 +0200
In-Reply-To: <20081001160827.GA13102@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org

On Wed, 2008-10-01 at 17:08 +0100, Ralf Baechle wrote:
> Doesn't look like it; all invocations of SET_PERSONALITY are passing 0 for
> the ibcs2 argument.  So I think the 2nd argument should go entirely.  MIPS
> segment against linux-next is below.  As you may notice it's actually a
> bug fix, there was a missing else statement that didn't bite bite anybody
> thanks to the unusedness :-)

Hmpf, yes, it is the second argument..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
