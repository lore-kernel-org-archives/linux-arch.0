Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46752 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfJKPZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 11:25:38 -0400
Received: by mail-yb1-f193.google.com with SMTP id h202so3204240ybg.13
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 08:25:36 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e09ca54-f353-9448-64ed-4ba1e38c6ebc@linaro.org>
Date: Fri, 11 Oct 2019 11:25:33 -0400
MIME-Version: 1.0
In-Reply-To: <20191011151028.GE33537@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011152533.Ktpb8kjrJGkyThtLzLSWxSspVMXFvVC8OlevjpYcFIM@z>

On 10/11/19 11:10 AM, Mark Rutland wrote:
> On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
>> @@ -730,6 +730,11 @@ static void setup_return
>>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
>>  	regs->pc = (unsigned long)ka->sa.sa_handler;
>>  
>> +	if (system_supports_bti()) {
>> +		regs->pstate &= ~PSR_BTYPE_MASK;
>> +		regs->pstate |= PSR_BTYPE_CALL;
>> +	}
>> +
> 
> I think we might need a comment as to what we're trying to ensure here.
> 
> I was under the (perhaps mistaken) impression that we'd generate a
> pristine pstate for a signal handler, and it's not clear to me that we
> must ensure the first instruction is a target instruction.

I think it makes sense to treat entry into a signal handler as a call.  Code
that has been compiled for BTI, and whose page has been marked with PROT_BTI,
will already have the pauth/bti markup at the beginning of the signal handler
function; we might as well verify that.

Otherwise sigaction becomes a hole by which an attacker can force execution to
start at any arbitrary address.


r~
