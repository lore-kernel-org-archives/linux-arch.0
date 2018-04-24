From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
Date: Tue, 24 Apr 2018 10:59:46 -0500
Message-ID: <87zi1sd28d.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-19-ebiederm@xmission.com>
        <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
        <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
        <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk> (Anton
        Ivanov's message of "Tue, 24 Apr 2018 09:44:22 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Martin =?utf-8?Q?P=C3=A4rt?= =?utf-8?Q?el?= <martin.partel@gmail.com>
List-Id: linux-arch.vger.kernel.org

Sigh I should have Cc'd Martin Partel as well as this bit is his
original code.

Anton Ivanov <anton.ivanov@kot-begemot.co.uk> writes:

> Hi Richard,
>
> There was a post to uml-devel during the days when the sourceforge mailing list
> was working in random drop mode which claimed that "this fixes the arm build".
>
> I have not kept it locally and I do not see it the archive (I do not see a few
> other posts there either - including some of mine).
>
> The joys of having a broken list :(
>
> Whoever posted it, if you are reading it, please re-post again so we can have a
> look.
>
> In the meantime we are as you said - x86 only.

The only case I can see my changed relay_signal affecting on arm is the
nasty hach where errno is set in conjunction with trap_trace.

Having a second look I really don't understand what relay_signal is
trying to do.

The function relay_signal does not pass siginfo through unchanged.
The function relay_signal does not handle cases where si_code is
not SI_USER or SI_KERNEL, or any of the other signal independent
si_codes.

In my change I believe I have preserved the character of relay_signal of
just passing through the fault.

Still even after reading the commit that upgraded relay_signal to
preserve si_code and si_addr I really don't understand the intended
logic.

Am I missing something subtle or have the subtle details of siginfo just
always been ignored?

commit d3c1cfcdb43e023ab1b1c7a555cd9e929026500a
Author: Martin Pärtel <martin.partel@gmail.com>
Date:   Thu Aug 2 00:49:17 2012 +0200

    um: pass siginfo to guest process
    
    UML guest processes now get correct siginfo_t for SIGTRAP, SIGFPE,
    SIGILL and SIGBUS. Specifically, si_addr and si_code are now correct
    where previously they were si_addr = NULL and si_code = 128.
    
    Signed-off-by: Martin Pärtel <martin.partel@gmail.com>
    Signed-off-by: Richard Weinberger <richard@nod.at>

Eric
