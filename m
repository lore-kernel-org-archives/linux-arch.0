From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel-hardening] [PATCH v4 26/29] sched: Allow putting
 thread_info into task_struct
Date: Mon, 11 Jul 2016 09:42:42 -0700
Message-ID: <CA+55aFz7TTf-MaF+a=qF+KX=G0S51v97xsOsJJVsi8ahNUBtMQ@mail.gmail.com>
References: <cover.1466974736.git.luto@kernel.org> <aeea9c1c41e889065b2c9ecd6d0694e4dfb529c8.1466974736.git.luto@kernel.org>
 <20160711100808.GB31221@leverpostej> <CALCETrWnw0WjionuGAT1F8r5y_t5CbYh+TmDL4s2d=ZbiinspA@mail.gmail.com>
 <CA+55aFy2Sno+bS0A2k0cMWpEJy-bpXufSAw3+ufrfQYbp9rcMQ@mail.gmail.com> <20160711163110.GD7691@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36030 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcGKQmo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2016 12:42:44 -0400
In-Reply-To: <20160711163110.GD7691@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jul 11, 2016 at 9:31 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> So until you do the wire that actually disables preemption you can
>> schedule away as much as you want, and after that write you no longer
>> will.
>
> I was assuming a percpu pointer to current (or preempt count).

So for the same reason that is ok *iff* you have

 - some kind of dedicated percpu register (or other base pointer - x86
has the segment thing) that gets updated when you schedule.

 - an instruction that can load 'current' directly off that register atomically.

But yes, percpu data in general is obviously not safe to access
without preemption.

         Linus
