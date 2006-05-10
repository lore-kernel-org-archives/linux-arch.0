Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:39314 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1751465AbWEJPr2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 11:47:28 -0400
Date: Wed, 10 May 2006 08:47:02 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510154702.GA28938@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>, t@twiddle.net
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> With this patch, 64-bit powerpc uses __thread for per-cpu variables.

How do you plan to address the compiler optimizing

	__thread int foo;
	{
	  use(foo);
	  schedule();
	  use(foo);
	}

into

	{
	  int *tmp = &foo;	// tls arithmetic here
	  use(*tmp);
	  schedule();
	  use(*tmp);
	}

Across the schedule, we may have changed cpus, making the cached
address invalid.


r~
