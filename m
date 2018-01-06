From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 10:00:19 +0100
Message-ID: <20180106090019.GD4380@kroah.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeAFJAQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 04:00:16 -0500
Content-Disposition: inline
In-Reply-To: <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On Fri, Jan 05, 2018 at 05:11:10PM -0800, Dan Williams wrote:
> Static analysis reports that 'offset' may be a user controlled value
> that is used as a data dependency reading from a raw_frag_vec buffer.
> In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue further
> reads based on an invalid '*(rfv->c + offset)' value.
> 
> Based on an original patch by Elena Reshetova.

I thought we "proved" that this patch was not needed at all, based on
previous review.  It doesn't look like that review cycle got
incorporated into this patch series at all, I guess I have to go back
and do it all again :(

thanks,

greg k-h
