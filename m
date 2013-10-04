From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH REBASED 2/3] x86: Move fpu_counter into ARCH specific
 thread_struct
Date: Fri, 4 Oct 2013 16:54:57 +0530
Message-ID: <524EA589.6040604@synopsys.com>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com> <1379398639-27403-3-git-send-email-vgupta@synopsys.com> <20130923083316.GB10891@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:34831 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab3JDLZZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Oct 2013 07:25:25 -0400
In-Reply-To: <20130923083316.GB10891@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

Hi Ingo,

On 09/23/2013 02:03 PM, Ingo Molnar wrote:
> 
> * Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> 
>> Only a couple of arches (sh/x86) use fpu_counter in task_struct so it
>> can be moved out into ARCH specific thread_struct, reducing the size of
>> task_struct for other arches.
>>
>> Compile tested i386_defconfig + gcc 4.7.3
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Vincent Palatin <vpalatin@chromium.org>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Cc: Pekka Riikonen <priikone@iki.fi>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Dave Jones <davej@redhat.com>
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/x86/include/asm/fpu-internal.h | 10 +++++-----
>>  arch/x86/include/asm/processor.h    |  9 +++++++++
>>  arch/x86/kernel/i387.c              |  2 +-
>>  arch/x86/kernel/process_32.c        |  4 ++--
>>  arch/x86/kernel/process_64.c        |  2 +-
>>  arch/x86/kernel/traps.c             |  2 +-
>>  6 files changed, 19 insertions(+), 10 deletions(-)
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> Thanks,
> 
> 	Ingo
> 

We are still at girdlock here because linux-sh mailing list seems be /dev/null,
while email to Paul Mundt kept bouncing.

I tried to contact someone in SuperH community, via the superH Linux portal - and
got this.

-------------->8--------------
Vineet

Unfortunately Paul Mundt is no longer work for Renesas and SuperH Linux.
Maybe he intentionally shutdown his e-mail server. So this is not a simple
server problem.  Very sorry for your inconvenience.
-------------->8--------------

So do you think it would appropriate to take this patch series anyways. For last
several months none of the cross-arch sweeping patches have had any ACK's from
them plus this is a straight forward mechanical change.

-Vineet
