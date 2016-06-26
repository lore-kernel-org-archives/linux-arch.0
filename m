Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34356 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbcFZRAF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jun 2016 13:00:05 -0400
Received: by mail-vk0-f47.google.com with SMTP id c2so176161514vkg.1
        for <linux-arch@vger.kernel.org>; Sun, 26 Jun 2016 10:00:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160624153503.oeivkn7djnxdi5oq@treble>
References: <cover.1466741835.git.luto@kernel.org> <f76b49739625fce1264428155540ca7161925511.1466741835.git.luto@kernel.org>
 <20160624153503.oeivkn7djnxdi5oq@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 26 Jun 2016 09:59:44 -0700
Message-ID: <CALCETrXz_GHZzx=F3AgQ8FNQ0BJROhnvK5E6-zQd57xpBFAreA@mail.gmail.com>
Subject: Re: [PATCH v4 13/16] x86/dumpstack: Try harder to get a call trace on
 stack overflow
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160626165944.ySHI1hUltBkermI2XtS0H6s9sH47MzkA9j602jDc2KU@z>

On Fri, Jun 24, 2016 at 8:35 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Jun 23, 2016 at 09:23:08PM -0700, Andy Lutomirski wrote:
>> If we overflow the stack, print_context_stack will abort.  Detect
>> this case and rewind back into the valid part of the stack so that
>> we can trace it.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
>

FWIW, I'm making a trivial change here for v4: task->stack ->
task_stack_page(task).  Since it seems inconsequential, I'm keeping
your reviewed-by.

> --
> Josh



-- 
Andy Lutomirski
AMA Capital Management, LLC
