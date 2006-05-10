Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:54159 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965062AbWEJXFu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 19:05:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.29128.591758.502430@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 09:05:44 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510154702.GA28938@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
To: Richard Henderson <rth@twiddle.net>
Cc: t@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

Richard Henderson writes:

> How do you plan to address the compiler optimizing
> 
> 	__thread int foo;
> 	{
> 	  use(foo);
> 	  schedule();
> 	  use(foo);
> 	}
> 
> into
> 
> 	{
> 	  int *tmp = &foo;	// tls arithmetic here
> 	  use(*tmp);
> 	  schedule();
> 	  use(*tmp);
> 	}

Hmmm...  Would it be sufficient to use a RELOC_HIDE in __get_cpu_var,
like this?

#define __get_cpu_var(x)	(*(RELOC_HIDE(&per_cpu__##x, 0)))

Paul.
