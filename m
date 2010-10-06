From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: + mm-retry-page-fault-when-blocking-on-disk-transfer.patch
 added to -mm tree
Date: Wed, 6 Oct 2010 10:46:05 +0800
Message-ID: <20101006024605.GC8454@localhost>
References: <201010052015.o95KFP1G017428@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11594 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756680Ab0JFCqM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Oct 2010 22:46:12 -0400
Content-Disposition: inline
In-Reply-To: <201010052015.o95KFP1G017428@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "walken@google.com" <walken@google.com>, "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "hpa@zytor.com" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "nickpiggin@yahoo.com.au" <nickpiggin@yahoo.com.au>, "riel@redhat.com" <riel@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "yinghan@google.com" <yinghan@google.com>

On Wed, Oct 06, 2010 at 04:15:25AM +0800, Andrew Morton wrote:
> 
> The patch titled
>      mm: retry page fault when blocking on disk transfer
> has been added to the -mm tree.  Its filename is
>      mm-retry-page-fault-when-blocking-on-disk-transfer.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: mm: retry page fault when blocking on disk transfer
> From: Michel Lespinasse <walken@google.com>
> 
> This change reduces mmap_sem hold times that are caused by waiting for
> disk transfers when accessing file mapped VMAs.
> 
> It introduces the VM_FAULT_ALLOW_RETRY flag, which indicates that the call
> site wants mmap_sem to be released if blocking on a pending disk transfer.
>  In that case, filemap_fault() returns the VM_FAULT_RETRY status bit and
> do_page_fault() will then re-acquire mmap_sem and retry the page fault.
> 
> It is expected that the retry will hit the same page which will now be
> cached, and thus it will complete with a low mmap_sem hold time.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Acked-by: Rik van Riel <riel@redhat.com>

Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>

Also would like to see Ying Han's Signed-off-by :)

Thanks,
Fengguang
