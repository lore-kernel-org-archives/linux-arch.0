From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -tip -v10 5/7] x86: add pt_regs register and stack
	access APIs
Date: Mon, 6 Jul 2009 22:06:34 +0200
Message-ID: <20090706200634.GA1380@basil.fritz.box>
References: <20090701010838.32547.62843.stgit@localhost.localdomain> <20090701010911.32547.1313.stgit@localhost.localdomain> <871votop6a.fsf@basil.nowhere.org> <4A525042.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:54354 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbZGFUGd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2009 16:06:33 -0400
Content-Disposition: inline
In-Reply-To: <4A525042.5030702@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>, systemtap <systemtap@sources.redhat.com>, kvm <kvm@vger.kernel.org>, DLE <dle-develop@lists.sourceforge.net>, Christoph Hellwig <hch@infradead.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Roland McGrath <roland@redhat.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-arch@vger.kernel.org

On Mon, Jul 06, 2009 at 03:28:02PM -0400, Masami Hiramatsu wrote:
> I'm not so sure about your idea.
> Would you mean below code?
> 
> int offs_table[NR_REGPARMS] = {

not REGPARMS of course

> 	[0] = offsetof(struct pt_regs, di),
> 	...
> };
> if (n < NR_REGPARMS)
> 	return *((unsigned long *)regs + offs_table[n]);

Yes.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
