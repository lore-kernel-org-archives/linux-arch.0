From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/3]  Move ARCH specific fpu_counter out of task_struct
Date: Wed, 9 Oct 2013 11:25:29 +0530
Message-ID: <5254EFD1.8040100@synopsys.com>
References: <1381218389-16585-1-git-send-email-vgupta@synopsys.com> <20131008131430.f7f46ec85a6bf4e2d95819a6@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:55414 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3JIF56 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2013 01:57:58 -0400
In-Reply-To: <20131008131430.f7f46ec85a6bf4e2d95819a6@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <paul.mundt@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrew,

On 10/09/2013 01:44 AM, Andrew Morton wrote:
> On Tue, 8 Oct 2013 13:16:26 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> 
>> When debugging a ARC SMP 3.11 build failure due to a ST insn dealing with
>> task_struct.thread going out of range, I spotted @fpu_counter in task_struct
>> which only SH/x86 happen to use, and can be easily moved out into corresponding
>> ARCH specific thread_struct. This saves 4 bytes per task_struct instantiated,
>> for all the other 18 arches.
>>
>> While the change is relatively strightforward, I've failed to connect with
>> SH arch folks / Paul Mundt, latter's SH email keeps bouncing back.
>> Hence I'm taking the liberty to use his alternate email (as listed on his
>> github page) and I appologize in advance if this causes any inconvenience.
> 
> I can't find [patch v2 2/3] anywhere.  Resend, please?
> 

Somehow that e-mail was dropped by some fancy "detection" machinery at our email
servers ;-) which I got notified of later on.

Patch reposted to lists.

Thx,
-Vineet
