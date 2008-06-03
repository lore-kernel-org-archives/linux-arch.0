From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Date: Tue, 03 Jun 2008 10:14:50 +0100
Message-ID: <26320.1212484490@redhat.com>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38507 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbYFCJPK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 05:15:10 -0400
In-Reply-To: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> - frv, m32r, mips, mn10300, and sh uses kmalloc/kfree instead of
> __get_free_pages/free_pages. I let them alone but it could remove more
> code if __get_free_pages/free_pages works for them.

On FRV, PAGE_SIZE is 16Kb, THREAD_SIZE is half that.

David
