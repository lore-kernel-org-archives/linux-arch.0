From: Kees Cook <keescook@chromium.org>
Subject: Re: [kernel-hardening] [PATCH v4 0/8] introduce post-init read-only memory
Date: Fri, 22 Jan 2016 11:57:05 -0800
Message-ID: <CAGXu5j+5EB5f335RHOP+CugFC1z29cAV0pWy6zB34dQBz7W6_Q@mail.gmail.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
	<20160122171954.GA3945@davidb.org>
	<56A28029.2060608@labbott.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36608 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbcAVT5G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jan 2016 14:57:06 -0500
Received: by mail-io0-f180.google.com with SMTP id g73so101168288ioe.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2016 11:57:05 -0800 (PST)
In-Reply-To: <56A28029.2060608@labbott.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <laura@labbott.name>
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Fri, Jan 22, 2016 at 11:16 AM, Laura Abbott <laura@labbott.name> wrote:
> On 1/22/16 9:19 AM, David Brown wrote:
>>
>> On Tue, Jan 19, 2016 at 10:08:34AM -0800, Kees Cook wrote:
>>
>>> This introduces __ro_after_init as a way to mark such memory, and uses
>>> it on the x86 vDSO to kill an extant kernel exploitation method. Also
>>> adds a new kernel parameter to help debug future use and adds an lkdtm
>>> test to check the results.
>>
>>
>> I've tested these patches on 32-bit ARM using the provoke-crashes
>> test.  However, they do require CONFIG_ARM_KERNMEM_PERMS to be enabled
>> as well, which does incur additional memory usage.

Thanks for testing!

>> Do we want to consider making CONFIG_ARM_KERNMEM_PERMS default y for
>> security reasons, and just document that memory-constrained systems
>> may want to turn it off?
>>
>> I'll test the arm64 next.
>>
>> David
>
>
> Kees had previously pushed a patch to do so but it exposed a couple of
> underlying issues, mostly with low power paths
> (c.f. http://article.gmane.org/gmane.linux.ports.arm.kernel/471199,
> http://article.gmane.org/gmane.linux.kernel.mm/143489)
> Those will need to be all fixed up before this could be made default.

Yeah, I've got a patch waiting to reorganize CONFIG_ARM_KERNMEM_PERMS
to look more like arm64 (and x86) and get the feature correctly under
CONFIG_DEBUG_RODATA. I made it default=y on v7+. rmk asked me to wait
until -rc1 before resubmitting it.

http://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/commit/?h=kspp/arm-rodata&id=08bebfd2e7fb8a9f364ced74c356642d64e1f43e

and a small improvement too:

http://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/commit/?h=kspp/arm-rodata&id=8e16f005ce0d4069aee5502379cff845b4c6f950

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
