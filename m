Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:12988 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964860AbWIKAw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 20:52:26 -0400
Date: Sun, 10 Sep 2006 20:51:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060911005118.GA22161@ccure.user-mode-linux.org>
References: <20060824234445.6B519D52@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> +	default "12" # arm || h8300 || i386 | m68knommu |ppc
> +		     # s390 || um || v850 || xtensa

UML inherits its page size from the host architecture.  So far, that's
always 4096, but as soon as that changes, the construction above breaks
it.

				Jeff
