From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] ptrace: copy_process() should disable stepping
Date: Mon, 9 Nov 2009 17:24:08 +0100
Message-ID: <20091109162408.GA5160@redhat.com>
References: <20091106211637.GA1696@redhat.com> <20091106212554.BD731CF@magilla.sf.frob.com> <20091106215004.GA2232@redhat.com> <20091106221002.8057DCF@magilla.sf.frob.com> <20091107215547.GA25335@redhat.com> <20091109041546.925461E@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58794 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbZKIQ31 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Nov 2009 11:29:27 -0500
Content-Disposition: inline
In-Reply-To: <20091109041546.925461E@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 11/08, Roland McGrath wrote:
>
> That is inappropriate use of arch details in generic code.  It might
> happen to be harmless fritter in practice on the arch's we have but it
> is certainly not the correct way to go about things.  You should just
> call user_disable_single_step() unconditionally.  Even on an arch with
> no such machinery at all that should be defined safely as a no-op (see
> linux/ptrace.h).  If there is some reason not to do that, please
> explain it.

Yes, we have arch_has_single_step.

I added test_tsk_thread_flag(TIF_SINGLESTEP) check for 2 reasons: to
optimize out user_disable_single_step() in the likely case, and because
I wasn't sure it is safe to call user_disable_single_step() unconditionally.

OK, will resend, thanks.

Oleg.
