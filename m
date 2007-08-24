Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.233]:32114 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbXHXMAM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Aug 2007 08:00:12 -0400
Received: by hu-out-0506.google.com with SMTP id 19so484728hue
        for <linux-arch@vger.kernel.org>; Fri, 24 Aug 2007 05:00:10 -0700 (PDT)
From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] i386: Fix a couple busy loops in mach_wakecpu.h:wait_for_init_deassert()
Date: Fri, 24 Aug 2007 12:59:32 +0100
References: <46C2350A.1010807@redhat.com> <20070815081841.GA16551@osiris.boeblingen.de.ibm.com> <alpine.LFD.0.999.0708160606580.24380@enigma.security.iitk.ac.in>
In-Reply-To: <alpine.LFD.0.999.0708160606580.24380@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708241259.33659.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
To: Satyam Sharma <satyam@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, Chris Snook <csnook@redhat.com>, clameter@sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, ak@suse.de, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com, segher@kernel.crashing.org
List-ID: <linux-arch.vger.kernel.org>

On Thursday 16 August 2007 01:39, Satyam Sharma wrote:
>
>  static inline void wait_for_init_deassert(atomic_t *deassert)
>  {
> -	while (!atomic_read(deassert));
> +	while (!atomic_read(deassert))
> +		cpu_relax();
>  	return;
>  }

For less-than-briliant people like me, it's totally non-obvious that
cpu_relax() is needed for correctness here, not just to make P4 happy.

IOW: "atomic_read" name quite unambiguously means "I will read
this variable from main memory". Which is not true and creates
potential for confusion and bugs.
--
vda
