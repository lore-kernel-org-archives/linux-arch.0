From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] ptrace: copy_thread() should clear TIF_SINGLESTEP and
	X86_EFLAGS_TF
Date: Fri,  6 Nov 2009 13:25:54 -0800 (PST)
Message-ID: <20091106212554.BD731CF@magilla.sf.frob.com>
References: <20091106211637.GA1696@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbZKFV0W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Nov 2009 16:26:22 -0500
In-Reply-To: Oleg Nesterov's message of  Friday, 6 November 2009 22:16:37 +0100 <20091106211637.GA1696@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

There is also the TIF_FORCED_TF logic to check.  Probably it should just
call user_disable_single_step() instead.  Perhaps copy_process() should
just call that and then no per-arch changes would be required.


Thanks,
Roland
