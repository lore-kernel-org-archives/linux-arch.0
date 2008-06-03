Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:39500 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756753AbYFCW7h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 18:59:37 -0400
Date: Wed, 4 Jun 2008 07:58:40 +0900
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <26320.1212484490@redhat.com>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
	<26320.1212484490@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20080604080140T.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20080603225840.JugsNE3Y9DWCW-aLtCq_SCDT9CNFvJIyNeysCg6WztM@z>

On Tue, 03 Jun 2008 10:14:50 +0100
David Howells <dhowells@redhat.com> wrote:

> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > - frv, m32r, mips, mn10300, and sh uses kmalloc/kfree instead of
> > __get_free_pages/free_pages. I let them alone but it could remove more
> > code if __get_free_pages/free_pages works for them.
> 
> On FRV, PAGE_SIZE is 16Kb, THREAD_SIZE is half that.

Thanks,

From a quick look, seems that on m32r, mips, mn10300, and sh,
THREAD_SIZE is a multiple of PAGE_SIZE.
