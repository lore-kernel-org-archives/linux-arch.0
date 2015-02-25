Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32983 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbBYLfm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 06:35:42 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so32559957wiw.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2015 03:35:40 -0800 (PST)
Message-ID: <54EDB2FC.4050901@vanguardiasur.com.ar>
Date: Wed, 25 Feb 2015 08:33:16 -0300
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Subject: Re: nios2: is the ptrace ABI correct?
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <5636312.0WGrbVlVgB@wuerfel> <54EC98A9.9080203@vanguardiasur.com.ar> <10088870.tldQegtTla@wuerfel>
In-Reply-To: <10088870.tldQegtTla@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150225113316.dxX1Ll7GSJcoLEBBaLAIxoE7K3lT6MKs9_9swZfeF40@z>



On 02/24/2015 04:25 PM, Arnd Bergmann wrote:
> On Tuesday 24 February 2015 12:28:41 Ezequiel Garcia wrote:
>>
>> Gah, no, you are right. I got confused.
>>
>> So it would be OK to avoid remove pt_regs from the uapi headers?
>> How does this affect the signal handling nios2 implementation?
>>
> 
> We have a number of architectures that don't provide this structure:
> 
> $ git grep -L pt_regs arch/*/include/uapi/asm/ptrace.h
> arch/frv/include/uapi/asm/ptrace.h
> arch/metag/include/uapi/asm/ptrace.h
> arch/openrisc/include/uapi/asm/ptrace.h
> arch/s390/include/uapi/asm/ptrace.h
> 
> so I'd assume it's ok in general not to have it. However, on
> nios2, struct pt_regs is embedded inside of struct sigcontext.
> If I read the code in arch/nios2/kernel/signal.c correctly,
> this is actually a bug and you should use a different structure
> there too, because pt_regs does not match the layout of the
> stack either. This means that the (rare) user programs that
> would know about the architecture to modify signal stacks
> are currently broken.
> 

/me is more confused now

In arch/nios2/include/asm/ucontext.h

struct ucontext {
        unsigned long     uc_flags;
        struct ucontext  *uc_link;
        stack_t           uc_stack;
        struct mcontext   uc_mcontext;
        sigset_t          uc_sigmask;
};

And in include/uapi/asm-generic/ucontext.h:

struct ucontext {
        unsigned long     uc_flags;
        struct ucontext  *uc_link;
        stack_t           uc_stack;
        struct sigcontext uc_mcontext;
        sigset_t          uc_sigmask;
};

Which one is the one that userspace sees? And why does the kernel has
two different structures?

Given this oddities, I'm wondering how troublesome would be to just
re-do this and break the ptrace and signal ABI. For instance, just
pushing pt_regs in PTRACE_GETREGSET would make things much clearer.

I guess Linus would burn me for even suggesting to breaking users... but
do we have any users at all? This arch has just been mainlined. Altera's
out-of-tree is already ABI-incompatible with mainline so that's not an
issue.

The only one using this ABI is gdb, which is easily fixed.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
