Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41446 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751096AbWGCKfZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Jul 2006 06:35:25 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k63AZMQk099948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 10:35:24 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com [9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k63Ac1Vh119984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 12:38:02 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k63AZJ9q027511
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 12:35:20 +0200
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060703022026.495cdb2c.akpm@osdl.org>
References: <1151670404.11575.5.camel@localhost>
	 <20060630104103.0b394b20.akpm@osdl.org> <1151917853.5334.6.camel@localhost>
	 <20060703022026.495cdb2c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 12:35:10 +0200
Message-Id: <1151922910.5334.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-07-03 at 02:20 -0700, Andrew Morton wrote:
> > That would be a very useful feature to have. There are some border cases
> > where no real positive dependency exist. For that a "disable xxx" would
> > be perfect. But we still should use positive dependencies where possible
> > to keep the disable lists short.
> > 
> 
> I don't understand that.
> 
> 	depends on !DISABLE_FOO
> 
> is short?

I was after the options that can be dealt with an existing positive
dependency, e.g. "depends on PCI", or "depends on ISA". I have a handful
of these in my patch. 

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


