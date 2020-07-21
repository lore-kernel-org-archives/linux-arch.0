From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned sections
Date: Tue, 21 Jul 2020 22:05:05 +0200
Message-ID: <87r1t43a8e.fsf@nanos.tec.linutronix.de>
References: <202007211143.AC36D096@keescook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:05:09 -0400
In-Reply-To: <202007211143.AC36D096@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>, Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com, Arvind Sankar <nivedita@alum.mit.edu>, Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Kees,

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>> 
>> Align the end of the .bss..page_aligned and .data..page_aligned section
>> on page-size too. Otherwise the linker might place other objects on the
>> page of the last ..page_aligned object. This is inconsistent with other
>> objects in those sections, which all have their own page.
>
> What problem was actually encountered? (i.e. why is it a problem for the
> other data to be in the page of the page-aligned data? shouldn't those
> data have their own, separate, alignment hint?)

See: lore.kernel.org/r/87sgdmm8u4.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
