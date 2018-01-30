From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 04/12] x86: introduce __uaccess_begin_nospec and ifence
Date: Tue, 30 Jan 2018 07:56:53 +0100
Message-ID: <20180130065653.gsp7blb3jttd6e6t@gmail.com>
References: <151703971300.26578.1185595719337719486.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151703973427.26578.15693075353773519333.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180128091437.4lbll5bev7mgdpug@gmail.com>
 <CAPcyv4hmkJyFgCBCXR8A1ykzk1tsxX-Lg4qgimhGxne=iG1Hzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38481 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeA3G45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 01:56:57 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4hmkJyFgCBCXR8A1ykzk1tsxX-Lg4qgimhGxne=iG1Hzg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andi Kleen <ak@linux.intel.com>, Kees Cook <keescook@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


* Dan Williams <dan.j.williams@intel.com> wrote:

> > The flip side is that if the MFENCE stalls the STAC that is ahead of it could be
> > processed for 'free' - while it's always post barrier with my suggestion.
> 
> This 'for free' aspect is what I aiming for.

Ok.

> >
> > But in any case it would be nice to see a discussion of this aspect in the
> > changelog, even if the patch does not change.
> 
> I'll add a note to the changelog that having the fence after the
> 'stac' hopefully allows some overlap of the cost of 'stac' and the
> flushing of the instruction pipeline.

Perfect!

Thanks,

	Ingo
