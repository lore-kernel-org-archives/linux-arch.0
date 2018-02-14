From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 08/37] nds32: Exception handling
Date: Wed, 14 Feb 2018 15:31:44 +0100
Message-ID: <CAK8P3a3hnHVrMJuTfDwWcy1R3C=o9UzDVN=OtsZdUzXboYPT5w@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <5d7538f6cad0763594f968d58625c7c7a99f3225.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35859 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeBNObp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Feb 2018 09:31:45 -0500
In-Reply-To: <5d7538f6cad0763594f968d58625c7c7a99f3225.1518505384.git.greentime@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch includes the exception/interrupt entries, pt_reg structure and
> related accessors.
>
> /* Unaligned accessing handling*/
> Andes processors cannot load/store information which is not naturally
> aligned on the bus, i.e., loading a 4 byte data whose start address must
> be divisible by 4. If unaligned data accessing is happened, data
> unaligned exception will be triggered and user will get SIGSEGV or
> kernel oops according to the unaligned address. In order to make user be
> able to load/store data from an unaligned address, software load/store
> emulation is implemented in arch/nds32/mm/alignment.c to address data
> unaligned exception.
>
> Unaligned accessing handling is disabled by default because it is not a
> normal case. User can enable this feature by following steps.
>
> A. Compile time:
>     1. Enable kernel config CONFIG_ALIGNMENT_TRAP
> B. Run time:
>     1. Enter /proc/sys/nds32/unaligned_acess folder
>     2. Write 1 to file enable_mode to enable unaligned accessing
>        handling. User can disable it by writing 0 to this file.
>     3. Write 1 to file debug to show which unaligned address is under
>        processing. User can disable it by writing 0 to this file.
>
> However, unaligned accessing handler cannot work if this unaligned
> address is not accessible such as protection violation. On this
> condition, the default behaviors for addressing data unaligned exception
> still happen
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
