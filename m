From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 19/76] ARC: Signal handling
Date: Sat, 19 Jan 2013 03:34:07 +0000
Message-ID: <20130119033407.GK4939@ZenIV.linux.org.uk>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-20-git-send-email-vgupta@synopsys.com>
 <20130119032357.GB23552@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130119032357.GB23552@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 19, 2013 at 03:23:57AM +0000, Al Viro wrote:
> ITYM current_pt_regs()...
> 
> > +	if (unlikely(is_do_ss_needed(magic)))
> > +		if (do_sigaltstack(&sf->uc.uc_stack, NULL, regs->sp) == -EFAULT)
> 	if (!restore_altstack(&sf->uc.uc_stack))
> please...

... only without the braino - if (restore_altstack(...))
