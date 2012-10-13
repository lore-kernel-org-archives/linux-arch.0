From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 15/25] openrisc: Use Kbuild infrastructure for kvm_para.h
Date: Sat, 13 Oct 2012 09:55:13 -0400
Message-ID: <1350136513.24256.97.camel@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	 <20121013022954.595178706@goodmis.org>
	 <CACM3HyHnMHj=DB5FeLUfRsKT-a=KzcmdpSbudoLU7O48RzuPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14408 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab2JMNzQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 09:55:16 -0400
In-Reply-To: <CACM3HyHnMHj=DB5FeLUfRsKT-a=KzcmdpSbudoLU7O48RzuPoA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, 2012-10-13 at 08:32 +0200, Jonas Bonn wrote:
> On 13 October 2012 04:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> > From: Steven Rostedt <srostedt@redhat.com>
> >
> > All the headers but kvm_para.h use the Kbuild infrastructure to
> > get to the asm-generic headers.
> >
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux@lists.openrisc.net
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Acked-by: Jonas Bonn <jonas@southpole.se>

Thanks Jonas,

Would you like to pull this into your tree? It's not dependent on any of
the other patches. Or I can take care of it too.

-- Steve
