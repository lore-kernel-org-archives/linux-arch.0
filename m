From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] generic debug pagealloc
Date: Tue, 3 Mar 2009 17:05:03 +0100
Message-ID: <20090303160503.GA6538@elte.hu>
References: <20090303160103.GB5812@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54448 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbZCCQFN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Mar 2009 11:05:13 -0500
Content-Disposition: inline
In-Reply-To: <20090303160103.GB5812@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org


* Akinobu Mita <akinobu.mita@gmail.com> wrote:

> CONFIG_DEBUG_PAGEALLOC is now supported by x86, powerpc, sparc 
> (64bit), and s390. This patch implements it for the rest of 
> the architectures by filling the pages with poison byte 
> patterns after free_pages() and verifying the poison patterns 
> before alloc_pages().
> 
> This generic one cannot detect invalid read accesses and it 
> can only detect invalid write accesses after a long delay. But 
> it is an feasible way for nommu architectures.

if every architecture supports it now then i guess this config 
switch can go away:

> +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> +	def_bool y

	Ingo
