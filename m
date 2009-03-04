From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] generic debug pagealloc
Date: Wed, 4 Mar 2009 23:12:40 +0900
Message-ID: <20090304141238.GA7168@localhost.localdomain>
References: <20090303160103.GB5812@localhost.localdomain> <20090303160503.GA6538@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:31948 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbZCDOMv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2009 09:12:51 -0500
Content-Disposition: inline
In-Reply-To: <20090303160503.GA6538@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org

On Tue, Mar 03, 2009 at 05:05:03PM +0100, Ingo Molnar wrote:
> if every architecture supports it now then i guess this config 
> switch can go away:
> 
> > +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > +	def_bool y

The generic debug pagealloc needs the poison flag for each struct page.

So I introduced CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC for x86, powerpc,
sparc (64bit), and s390. If there is no CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC,
make config prompts the generic debug pagealloc in mm/Kconfig.debug for the
other architectures.

I was trying to add cleaner config dependency but
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC is my solution for now.
