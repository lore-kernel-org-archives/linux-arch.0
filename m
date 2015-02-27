Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:42934 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbB0LVh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Feb 2015 06:21:37 -0500
Received: by wesw62 with SMTP id w62so19508644wes.9
        for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2015 03:21:36 -0800 (PST)
Message-ID: <54F052B1.4070300@vanguardiasur.com.ar>
Date: Fri, 27 Feb 2015 08:19:13 -0300
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Subject: Re: nios2: is the ptrace ABI correct?
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <10088870.tldQegtTla@wuerfel> <54EDB2FC.4050901@vanguardiasur.com.ar> <10841724.NbdcAaCe1a@wuerfel> <54F03184.7080600@codesourcery.com>
In-Reply-To: <54F03184.7080600@codesourcery.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <cltang@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Tobias Klauser <tklauser@distanz.ch>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150227111913.B7y7YOZ1TgD-otHlsaHs4rW8stvzmI7MzkmqaeGVu_4@z>

Hi Chung-Lin Tang,

On 02/27/2015 05:57 AM, Chung-Lin Tang wrote:
> On 15/2/25 10:07 PM, Arnd Bergmann wrote:
>> On Wednesday 25 February 2015 08:33:16 Ezequiel Garcia wrote:
>>>
>>> /me is more confused now
>>>
>>> In arch/nios2/include/asm/ucontext.h
>>>
>>> struct ucontext {
>>>         unsigned long     uc_flags;
>>>         struct ucontext  *uc_link;
>>>         stack_t           uc_stack;
>>>         struct mcontext   uc_mcontext;
>>>         sigset_t          uc_sigmask;
>>> };
>>>
>>> And in include/uapi/asm-generic/ucontext.h:
>>>
>>> struct ucontext {
>>>         unsigned long     uc_flags;
>>>         struct ucontext  *uc_link;
>>>         stack_t           uc_stack;
>>>         struct sigcontext uc_mcontext;
>>>         sigset_t          uc_sigmask;
>>> };
>>>
>>> Which one is the one that userspace sees? And why does the kernel has
>>> two different structures?
>>
>> Userspace sees the asm-generic header, which I assume is a bug
>> in this case.
> 
> Yes, I believe nios2 doesn't not need this asm-generic/ucontext.h
> header; OTOH it just isn't used; no real harm done, so easily fixed.
> 
>>> Given this oddities, I'm wondering how troublesome would be to just
>>> re-do this and break the ptrace and signal ABI. For instance, just
>>> pushing pt_regs in PTRACE_GETREGSET would make things much clearer.
>>
>> Could you change pt_regs to match the layout you have for PTRACE_GETREGSET
>> instead? It seems much more intuitive.
> 
> There is a reason for this pt_regs arrangement: the nios2 syscall
> interface uses r4-r9 for parameters, while the usual C conventions use
> only r4-r7, placing r8-r9 at the start of pt_regs creates a natural
> stack layout for entering C code after the asm shims in entry.S
> 
>>> I guess Linus would burn me for even suggesting to breaking users... but
>>> do we have any users at all? This arch has just been mainlined. Altera's
>>> out-of-tree is already ABI-incompatible with mainline so that's not an
>>> issue.
>>>
>>> The only one using this ABI is gdb, which is easily fixed.
>>
>> You can change anything you like as long as nobody complains about
>> regressions.
> 
> PTRACE_GET/SETREGSET is a new feature in nios2-linux that we're still
> about to support in upstream GDB, so things could be fixed if needed,
> but why can't you just use the [0...] ordering in userspace?
> 

Sure, that's doable. However, I believe the problem is the pt_regs
struct is exported in ptrace.h so we seem to be telling userspace to use it.

> BTW, it's even that way in signal stacks as well; nios2 does not
> use/export sigcontext inside struct ucontext. We just use a int[32]
> array there.
> 

I think we are more or less on the same page.

Right now, my biggest problem is how to remove the pt_regs from being
exported to userspace, without breaking things. The struct is defined
and used in a few UAPI headers:

arch/nios2/include/uapi/asm/ptrace.h
arch/nios2/include/uapi/asm/sigcontext.h
arch/nios2/include/uapi/asm/elf.h

For ucontext, we would need to remove
arch/nios2/include/uapi/asm/sigcontext.h and avoid using
asm-generic/ucontext.h.

For ptrace, we could move pt_regs from the UAPI header to some internal
header. That way userspace is not exposed the wrong struct.

For the elf coredump, I have no idea yet :)
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
