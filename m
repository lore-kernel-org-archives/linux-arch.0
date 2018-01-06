From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 12:23:47 +0000
Message-ID: <20180106122347.7a5c8ee6@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20180106090154.GE4380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55012 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbeAFMYr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jan 2018 07:24:47 -0500
In-Reply-To: <20180106090154.GE4380@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On Sat, 6 Jan 2018 10:01:54 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jan 05, 2018 at 05:11:10PM -0800, Dan Williams wrote:
> > Static analysis reports that 'offset' may be a user controlled value  
> 
> Can I see the rule that determined that?  It does not feel like that is
> correct, given the 3+ levels deep that this function gets this value
> from...

On a current x86 you can execute something upwards of 150 instructions in
a speculation window.

Alan
