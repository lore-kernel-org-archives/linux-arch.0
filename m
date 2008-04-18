Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:40725 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbYDRGoZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2008 02:44:25 -0400
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@ozlabs.org>
In-Reply-To: <20080417211905.8ff769fa.akpm@linux-foundation.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	 <20080413171953.bde5e9ac.akpm@linux-foundation.org>
	 <1208133506.6958.82.camel@pasglop>
	 <20080413191338.9776ebd0.akpm@linux-foundation.org>
	 <1208491086.6958.381.camel@pasglop>
	 <20080417211905.8ff769fa.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 16:44:21 +1000
Message-ID: <1208501061.6958.394.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20080418064421.h2ahzLsrlqHWc2bQIE_6r0m312Z0QbS63ruonOQFLwE@z>


> > so what
> > about the patch below ?
> 
> I like it, but the compiler won't ;)
> 
> > If you're ok, I'll re-send with appropriate sob
> > & adapted powerpc part.
> 
> Sure.
> 
> > +void __init __attribute__((weak) thread_info_cache_init(void)
> 
> s/weak)/weak))/

Yeah, missing quilt ref :-)

I'll send the proper patches in a minute.

Cheers,
Ben.


