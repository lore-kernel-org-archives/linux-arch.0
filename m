From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 00/16] compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu, 6 Mar 2014 17:14:55 +0100
Message-ID: <CAMuHMdWFNtuo0bK==yEUw++F1SciMoHXHHgxPCy-erN-L327hg@mail.gmail.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57794 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbaCFQO4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 11:14:56 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so2827426pab.22
        for <linux-arch@vger.kernel.org>; Thu, 06 Mar 2014 08:14:55 -0800 (PST)
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Thu, Mar 6, 2014 at 4:51 PM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> FWIW, this patch series omits the whole s390 patches, since I assume
> they are not very interesting to non-s390 people ;)

"Given enough eyeballs, all bugs are shallow"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
