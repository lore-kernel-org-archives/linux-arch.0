From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V4 02/15] entry: Provide generic syscall entry functionality
Date: Wed, 22 Jul 2020 09:34:51 +0200
Message-ID: <87o8o82eas.fsf@nanos.tec.linutronix.de>
References: <20200721105706.030914876@linutronix.de> <20200721110808.455350746@linutronix.de> <202007211426.B40A7A7BD@keescook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHez (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 03:34:55 -0400
In-Reply-To: <202007211426.B40A7A7BD@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 12:57:08PM +0200, Thomas Gleixner wrote:
>> --- /dev/null
>> +++ b/kernel/entry/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_GENERIC_ENTRY) += common.o
>
> But, my point is, let's avoid tripping over this again, and retain the
> disabling here:
>
> CFLAGS_common.o += -fno-stack-protector
>
> I can add this again later, but it'd be nice if it was done here to
> avoid gaining back the TIF_WORK stack protector overhead penalty (which
> we're free of in v5.8 for the first time). ;)

Duh, yes. I completely forgot about that.

Thanks for spotting it!

       tglx
