From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Date: Wed, 4 Jun 2008 07:58:40 +0900
Message-ID: <20080604080140T.fujita.tomonori@lab.ntt.co.jp>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
	<26320.1212484490@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757501AbYFCW7v@vger.kernel.org>
In-Reply-To: <26320.1212484490@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dhowells@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
