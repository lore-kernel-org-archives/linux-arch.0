Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel13.hp.com ([156.153.255.238]:57307 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265192AbUEMWdt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 18:33:49 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16547.63434.35149.755394@napali.hpl.hp.com>
Date: Thu, 13 May 2004 15:33:46 -0700
Subject: Re: atomic ops for a VM fix
In-Reply-To: <20040514015222.A1569@den.park.msu.ru>
References: <20040513133526.0e5efed3.akpm@osdl.org>
	<20040514015222.A1569@den.park.msu.ru>
Reply-To: davidm@hpl.hp.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 14 May 2004 01:52:22 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  Ivan> It seems atomic_inc_and_test() is missing on alpha.

  Ivan> +#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)

And I seem to have gotten the ia64-version wrong (it tests for != 0).
I'll fix that now.

Can someone say with certainty whether the s390 version is also
wrong?

	--david
