Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:17608 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965087AbWIKXmB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 19:42:01 -0400
Date: Mon, 11 Sep 2006 19:40:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060911234050.GB6855@ccure.user-mode-linux.org>
References: <20060824234445.6B519D52@localhost.localdomain> <20060911005118.GA22161@ccure.user-mode-linux.org> <1158000185.26324.137.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158000185.26324.137.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 11, 2006 at 11:43:05AM -0700, Dave Hansen wrote:
> When UML needs this, the thing to do is to make a set of UML Kconfig
> options, just like sparc64 has.
> 
> config UML_PAGE_SIZE_NNNK
> 	def_bool y

OK, just wanted to check that this wasn't precluding non-4K page sizes
for UML.

				Jeff
