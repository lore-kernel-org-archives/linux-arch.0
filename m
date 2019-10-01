Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJASqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 14:46:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so8684173pfo.10
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 11:46:47 -0700 (PDT)
Date: Tue, 1 Oct 2019 11:46:45 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <201910011140.EA0181F13@keescook>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736gcjosv.fsf@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Alex Smith <alex.smith@imgtec.com>, Anders Berg <anders.berg@lsi.com>, Apelete Seketeli <apelete@seketeli.net>, Arnd Bergmann <arnd@arndb.de>, Chee Nouk Phoon <cnphoon@altera.com>, Chris Zankel <chris@zankel.net>, Christian Ruppert <christian.ruppert@abilis.com>, Greg Ungerer <gerg@uclinux.org>, Harvey Hunt <harvey.hunt@imgtec.com>, Helge Deller <deller@gmx.de>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, Huacai Chen <chenhc@lemote.com>, John Crispin <blogic@openwrt.org>, Jonas Jensen <jonas.jensen@gmail.com>, Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>, Kevin Hilman <khilman@linaro.org>, Kevin Wells <kevin.wells@nxp.com>, Kumar Gala <galak@codeaurora.org>, Lars-Peter Clausen <lars@metafoo.de>, Ley Foon Tan <lftan@altera.com>, Linus Walleij <linus.walleij@linaro.org>, Markos Chandras <markos.chandras@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Noam Camus <noamc@ezchip.com>, Olof Johansson <olof@lixom.net>, Paul Burton <paul.burton@mips.com>, Paul Mundt <lethal@linux-sh.org>, Phil Edworthy <phil.edworthy@renesas.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, Ralf Baechle <ralf@linux-mips.org>, Roland Stigge <stigge@antcom.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Scott Telford <stelford@cadence.com>, Stephen Boyd <sboyd@codeaurora.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, Tanmay Inamdar <tinamdar@apm.com>, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20191001184645.trB5swzfG2zjnAWbu1BtQEkj-ye6whRoJk83y-rHRJY@z>

On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
> 
> This system call has been deprecated almost since it was introduced, and
> in a survey of the linux distributions I can no longer find any of them
> that enable CONFIG_SYSCTL_SYSCALL.  The only indication that I can find
> that anyone might care is that a few of the defconfigs in the kernel
> enable CONFIG_SYSCTL_SYSCALL.  However this appears in only 31 of 414
> defconfigs in the kernel, so I suspect this symbols presence is simply
> because it is harmless to include rather than because it is necessary.
> 
> As there appear to be no users of the sysctl system call, remove the
> code.  As this removes one of the few uses of the internal kernel mount
> of proc I hope this allows for even more simplifications of the proc
> filesystem.

I'm for it. :) I tripped over this being deprecated over a decade ago. :P

I think you can actually take this further and remove (or at least
empty) the uapi/linux/sysctl.h file too.

-- 
Kees Cook
