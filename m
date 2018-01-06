From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 16:14:24 +0100
Message-ID: <20180106151424.GA17924@kroah.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180106090154.GE4380@kroah.com>
 <20180106122347.7a5c8ee6@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180106122347.7a5c8ee6@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 06, 2018 at 12:23:47PM +0000, Alan Cox wrote:
> On Sat, 6 Jan 2018 10:01:54 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Jan 05, 2018 at 05:11:10PM -0800, Dan Williams wrote:
> > > Static analysis reports that 'offset' may be a user controlled value  
> > 
> > Can I see the rule that determined that?  It does not feel like that is
> > correct, given the 3+ levels deep that this function gets this value
> > from...
> 
> On a current x86 you can execute something upwards of 150 instructions in
> a speculation window.

Yeah, I agree, it's deep :(

But for this patch, I thought the prior review determined that it was
not a problem.  Was that somehow proven incorrect?

thanks,

greg k-h
