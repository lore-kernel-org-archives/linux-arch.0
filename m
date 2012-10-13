From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/25] blackfin: Use Kbuild infrastructure for kvm_para.h
Date: Sat, 13 Oct 2012 09:54:36 -0400
Message-ID: <1350136476.24256.96.camel@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	 <20121013022953.015897288@goodmis.org>
	 <201210130012.40451.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:30339 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2JMNyh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 09:54:37 -0400
In-Reply-To: <201210130012.40451.vapier@gentoo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, 2012-10-13 at 00:12 -0400, Mike Frysinger wrote:
> On Friday 12 October 2012 22:26:36 Steven Rostedt wrote:
> > From: Steven Rostedt <srostedt@redhat.com>
> > 
> > All the headers but kvm_para.h use the Kbuild infrastructure to
> > get to the asm-generic headers.
> 
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> -mike

Thanks Mike,

Would you want to pull this patch into your tree? It's not dependent on
any of the other patches.

-- Steve
