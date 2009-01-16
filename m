Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:51442 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbZAPQxb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jan 2009 11:53:31 -0500
Message-ID: <cfd18e0f0901160853v4cf76602g4ab389dc30a5a225@mail.gmail.com>
Date: Sat, 17 Jan 2009 05:53:28 +1300
From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Reply-To: mtk.manpages@gmail.com
Subject: Re: [PATCH v6 0/5] Add preadv & pwritev system calls.
In-Reply-To: <1232124344-25892-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1232124344-25892-1-git-send-email-kraxel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, aarcange@redhat.com
Message-ID: <20090116165328.2F8LBxi2geqlWMZP6PqQPgMJdgIqAcAB16UciqlZC5g@z>

Gerd,

On Sat, Jan 17, 2009 at 5:45 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>  Hi folks,
>
> Next round of the preadv & pwritev patch series.

Have you somewhere along the way posted some userland example/test
programs for these syscalls?  If not, could you provide some?

Cheers,

Michael

> Had no review comments
> to fix.  That means it is ready to be merged, right?
>
> Changes:
>  - compat_sys_{read,write}v bugfix patch dropped (merged).
>  - rebase to latest git, adapt to CVE-2009-0029 changes.
>
> How to proceed now?  Is there a syscall maintainer where I could queue
> up the patches?  If not, anyone (akpm?) willng to pick this up?  Should
> I try to send to Linus directly?
>
> What is the usual way to handle the arch-specific syscall windup?  I'd
> prefer to leave that to the arch maintainers as they know best what
> needs to be done, is that ok?  Right now only x86 (/me) and mips (patch
> from Ralf Baechle) is covered ...
>
> cheers,
>  Gerd
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
