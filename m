From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Date: Tue, 3 Jun 2008 09:06:26 +0300
Message-ID: <84144f020806022306h236a48cbv32b82cfa83fe4ee6@mail.gmail.com>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:3905 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbYFCGG3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jun 2008 02:06:29 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1409464rvb.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Jun 2008 23:06:27 -0700 (PDT)
In-Reply-To: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Tue, Jun 3, 2008 at 8:02 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> Is there a reason we duplicate alloc/free_thread_info defines on many
> platforms?

No. The patch looks good.

On Tue, Jun 3, 2008 at 8:02 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> Note:
>
> - I don't like __HAVE_ARCH_THREAD_INFO_ALLOCATOR name much. I chose
> that name just because we define __HAVE_ARCH_TASK_STRUCT_ALLOCATOR in
> the same place.
>
> - frv, m32r, mips, mn10300, and sh uses kmalloc/kfree instead of
> __get_free_pages/free_pages. I let them alone but it could remove more
> code if __get_free_pages/free_pages works for them.

Yeah, I too have wondered why some architectures use kmalloc() whereas
others use the page allocator. Is THREAD_SIZE significantly smaller
than PAGE_SIZE for those?
