From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 10:01:54 +0100
Message-ID: <20180106090154.GE4380@kroah.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 05, 2018 at 05:11:10PM -0800, Dan Williams wrote:
> Static analysis reports that 'offset' may be a user controlled value

Can I see the rule that determined that?  It does not feel like that is
correct, given the 3+ levels deep that this function gets this value
from...

Same for the ipv6 patch, it's the same code logic.

thanks,

greg k-h
