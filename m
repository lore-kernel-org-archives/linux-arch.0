Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54679 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086AbYICVXR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Sep 2008 17:23:17 -0400
Date: Wed, 3 Sep 2008 14:22:36 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
In-Reply-To: <1220473137.3254.29.camel@localhost.localdomain>
Message-ID: <alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
References: <1220473137.3254.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <20080903212236.ARUXD0MZL8vDDI5Intvb1g7ZBgW2IghgWefmQMdzk0M@z>



On Wed, 3 Sep 2008, James Bottomley wrote:
> 
> Make dereference_function_descriptor() more accommodating by allowing
> architecture overrides.

Don't do it like this.

We don't want some stupid useless weak function that is empty on all sane 
platforms.

Just do

	.. declare or create an inline 'parisc_function_descriptor()' ..

	#define dereference_function_descriptor(p) parisc_function_descriptor(p)

in some arch header file. And then use

	#ifndef dereference_function_descriptor
	#define dereference_function_descriptor(p) (p)
	#endif

in the generic code, so that sane architectures don't need to do anything 
at all.

		Linus
