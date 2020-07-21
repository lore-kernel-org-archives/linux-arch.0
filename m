From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned
 sections
Date: Tue, 21 Jul 2020 14:18:50 -0700
Message-ID: <202007211416.1A2B618DE@keescook>
References: <202007211143.AC36D096@keescook>
 <87r1t43a8e.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgGUVSw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:18:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA12C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so10792289plt.7
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87r1t43a8e.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>, Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com, Arvind Sankar <nivedita@alum.mit.edu>, Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 10:05:05PM +0200, Thomas Gleixner wrote:
> Kees,
> 
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
> >> From: Joerg Roedel <jroedel@suse.de>
> >> 
> >> Align the end of the .bss..page_aligned and .data..page_aligned section
> >> on page-size too. Otherwise the linker might place other objects on the
> >> page of the last ..page_aligned object. This is inconsistent with other
> >> objects in those sections, which all have their own page.
> >
> > What problem was actually encountered? (i.e. why is it a problem for the
> > other data to be in the page of the page-aligned data? shouldn't those
> > data have their own, separate, alignment hint?)
> 
> See: lore.kernel.org/r/87sgdmm8u4.fsf@nanos.tec.linutronix.de

Ah-ha: "But with explicit sections which store only page aligned objects
there is an implicit guarantee that the object is alone in the page
in which it is placed. That works for all objects except the last
one. That's inconsistent."

Understood now. The bit in this commit log for "which all have their own
page" wasn't clear to me about _why_ (it was coming from .page_aligned,
which means both aligned and dedicated).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
