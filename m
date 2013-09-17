From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH REBASED 1/3] sh: Move fpu_counter into ARCH specific
 thread_struct
Date: Tue, 17 Sep 2013 08:14:34 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307514C36B@IN01WEMBXA.internal.synopsys.com>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
 <1379398639-27403-2-git-send-email-vgupta@synopsys.com>
 <20130917080017.GC12926@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:41713 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3IQIOi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 04:14:38 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

On 09/17/2013 01:30 PM, Peter Zijlstra wrote:

On Tue, Sep 17, 2013 at 11:47:17AM +0530, Vineet Gupta wrote:


Only a couple of arches (sh/x86) use fpu_counter in task_struct so it
can be moved out into ARCH specific thread_struct, reducing the size of
task_struct for other arches.

Compile tested sh defconfig + sh4-linux-gcc (4.6.3)

Signed-off-by: Vineet Gupta <vgupta@synopsys.com><mailto:vgupta@synopsys.com>
Cc: Paul Mundt <lethal@linux-sh.org><mailto:lethal@linux-sh.org>
Cc: Michel Lespinasse <walken@google.com><mailto:walken@google.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com><mailto:kuninori.morimoto.gx@renesas.com>
Cc: Al Viro <viro@zeniv.linux.org.uk><mailto:viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org><mailto:akpm@linux-foundation.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com><mailto:jesper.nilsson@axis.com>
Cc: Chris Metcalf <cmetcalf@tilera.com><mailto:cmetcalf@tilera.com>
Cc: "David S. Miller" <davem@davemloft.net><mailto:davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org<mailto:linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org<mailto:linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com><mailto:mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org><mailto:peterz@infradead.org>
Cc: linux-sh@vger.kernel.org<mailto:linux-sh@vger.kernel.org>



Your mailer didn't actually pick up any of those and I'm sure Paul Mundt
would love to see patches to his arch land in his Inbox.. Added him to
CC.


Thx.

For some reason the email to Paul bounced last time as well

--------------->8-----------------------
lethal@linux-sh.org<mailto:lethal@linux-sh.org>>: host mail.linux-sh.org[111.68.239.195] said: 550 5.7.1
    <lethal@linux-sh.org><mailto:lethal@linux-sh.org>... Relaying denied. Proper authentication required.
    (in reply to RCPT TO command)
--------------->8-----------------------

Did you get that too after sending this CCed email to him.

And that in turns causes some weirdness with git send-email ignoring all the CCs in individual patches - weird !

-Vineet
