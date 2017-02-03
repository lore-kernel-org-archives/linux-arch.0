From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 0/3] modversions: redefine kcrctab entries as 32-bit values
Date: Fri, 3 Feb 2017 08:30:09 -0800
Message-ID: <CA+55aFz8faoGYBqkHuGPy4yp+SU5brCbkOCdZNTgfdDzkN8hOw@mail.gmail.com>
References: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35541 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdBCQaL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2017 11:30:11 -0500
In-Reply-To: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Michal Marek <mmarek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 3, 2017 at 1:54 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
> relative CRC pointers' [...]

ok, I have this in a local branch now, assuming it passes my
(admittedly fairly superficial) testing I'll merge it so that we can
put this whole sorry saga behind us.

Thanks,

             Linus
