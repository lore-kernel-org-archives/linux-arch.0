Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49103 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751003AbWGCJLa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Jul 2006 05:11:30 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.6/8.13.6) with ESMTP id k639B4DF040252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 09:11:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k639Da8V034048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 11:13:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k639Apbm006852
	for <linux-arch@vger.kernel.org>; Mon, 3 Jul 2006 11:10:52 +0200
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060630104103.0b394b20.akpm@osdl.org>
References: <1151670404.11575.5.camel@localhost>
	 <20060630104103.0b394b20.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 11:10:53 +0200
Message-Id: <1151917853.5334.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-06-30 at 10:41 -0700, Andrew Morton wrote:
> Even better would be to teach the Kconfig sytem about this, so in
> arch/s390/Kconfig we do
> 
> disable	VT
> 
> and the Kconfig system knows not to offer VT, so there's no need to go
> adding `depends on !DISABLE_foo' all over the place.  The above DISABLE_foo
> convention just simulates that missing feature.

That would be a very useful feature to have. There are some border cases
where no real positive dependency exist. For that a "disable xxx" would
be perfect. But we still should use positive dependencies where possible
to keep the disable lists short.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


