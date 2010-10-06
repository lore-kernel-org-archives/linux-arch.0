From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: + mm-filemap_fault-unique-path-for-locking-page.patch added to
 -mm tree
Date: Wed, 6 Oct 2010 09:34:08 +0800
Message-ID: <20101006013408.GA8454@localhost>
References: <201010052015.o95KFMaG017421@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43758 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab0JFBeO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Oct 2010 21:34:14 -0400
Content-Disposition: inline
In-Reply-To: <201010052015.o95KFMaG017421@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "walken@google.com" <walken@google.com>, "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "hpa@zytor.com" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "nickpiggin@yahoo.com.au" <nickpiggin@yahoo.com.au>, "riel@redhat.com" <riel@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "yinghan@google.com" <yinghan@google.com>

On Wed, Oct 06, 2010 at 04:15:22AM +0800, Andrew Morton wrote:
> 
> The patch titled
>      mm: filemap_fault: unique path for locking page
> has been added to the -mm tree.  Its filename is
>      mm-filemap_fault-unique-path-for-locking-page.patch
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
> Subject: mm: filemap_fault: unique path for locking page
> From: Michel Lespinasse <walken@google.com>
> 
> Introduce a single location where filemap_fault() locks the desired page. 
> There used to be two such places, depending if the initial find_get_page()
> was successful or not.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Acked-by: Rik van Riel <riel@redhat.com>

Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
