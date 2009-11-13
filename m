From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH v2 3/5] ptrace: change tracehook_report_syscall_exit()
	to handle stepping
Date: Fri, 13 Nov 2009 12:15:51 -0800 (PST)
Message-ID: <20091113201551.14769F4A@magilla.sf.frob.com>
References: <20091112173853.GA12279@redhat.com>
	<20091113112530.c10a3743.akpm@linux-foundation.org>
	<20091113195858.GA12049@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757270AbZKMUQH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Nov 2009 15:16:07 -0500
In-Reply-To: Oleg Nesterov's message of  Friday, 13 November 2009 20:58:58 +0100 <20091113195858.GA12049@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Srinivasa Ds <srinivasa@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

> Roland, given that you are going to send the updated utrace patch,
> perhaps it makes sense to drop this old utrace-core.patch from -mm?

Yes, I think that's the easiest thing to do.  When we send new utrace and
ptrace code, we can make that relative to -mm or at least relative to the
all ptrace-related patches you've already submitted in this cycle.


Thanks,
Roland
