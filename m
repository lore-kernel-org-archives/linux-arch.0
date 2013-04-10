From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/7] x86: don't show trace beyond show_stack(NULL, NULL)
Date: Wed, 10 Apr 2013 11:54:14 -0700
Message-ID: <20130410185414.GE17641@mtj.dyndns.org>
References: <1365016497-32033-1-git-send-email-tj@kernel.org>
 <1365016497-32033-2-git-send-email-tj@kernel.org>
 <20130408160811.GA20612@gmail.com>
 <20130408175734.GH3021@htj.dyndns.org>
 <20130410103508.GD28505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:60673 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab3DJSyW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2013 14:54:22 -0400
Content-Disposition: inline
In-Reply-To: <20130410103508.GD28505@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, cmetcalf@tilera.com, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com

On Wed, Apr 10, 2013 at 12:35:08PM +0200, Ingo Molnar wrote:
> Ok - but my other observation probably holds, that the bp == 0 special case in 
> dump_trace() should be changed to a [printk()-ed] warning or so? No user will pass 
> in bp == 0 legitimately, AFAICS.

Yeah, seems so.  I'll verify and add a warning message if both @bp and
@regs aren't specified in dump_trace().

Thanks.

-- 
tejun
