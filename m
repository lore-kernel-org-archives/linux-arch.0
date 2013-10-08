From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3]  Move ARCH specific fpu_counter out of
 task_struct
Date: Tue, 8 Oct 2013 13:14:30 -0700
Message-ID: <20131008131430.f7f46ec85a6bf4e2d95819a6@linux-foundation.org>
References: <1381218389-16585-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44082 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab3JHUOb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Oct 2013 16:14:31 -0400
In-Reply-To: <1381218389-16585-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <paul.mundt@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 8 Oct 2013 13:16:26 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> When debugging a ARC SMP 3.11 build failure due to a ST insn dealing with
> task_struct.thread going out of range, I spotted @fpu_counter in task_struct
> which only SH/x86 happen to use, and can be easily moved out into corresponding
> ARCH specific thread_struct. This saves 4 bytes per task_struct instantiated,
> for all the other 18 arches.
> 
> While the change is relatively strightforward, I've failed to connect with
> SH arch folks / Paul Mundt, latter's SH email keeps bouncing back.
> Hence I'm taking the liberty to use his alternate email (as listed on his
> github page) and I appologize in advance if this causes any inconvenience.

I can't find [patch v2 2/3] anywhere.  Resend, please?
