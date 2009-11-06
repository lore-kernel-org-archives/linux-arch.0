From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] ptrace: copy_thread() should clear TIF_SINGLESTEP and
	X86_EFLAGS_TF
Date: Fri,  6 Nov 2009 14:10:02 -0800 (PST)
Message-ID: <20091106221002.8057DCF@magilla.sf.frob.com>
References: <20091106211637.GA1696@redhat.com>
	<20091106212554.BD731CF@magilla.sf.frob.com>
	<20091106215004.GA2232@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759945AbZKFWKJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Nov 2009 17:10:09 -0500
In-Reply-To: Oleg Nesterov's message of  Friday, 6 November 2009 22:50:04 +0100 <20091106215004.GA2232@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> I thought this flag has no effect without TIF_SINGLESTEP, and it is
> always updated by enable_single_step().

Right, but to be anal about the semantics you shouldn't clear TF if it's
not set, etc.

> user_disable_single_step() is very much arch-dependent, I am worried
> if it is safe to call it from copy_process(), when the new task_struct,
> thread_info, etc are not properly initialized yet...

Well, arch people can weigh in about if it is problematical.
Skimming over the existing arch definitions, it looks OK to me.


Thanks,
Roland
