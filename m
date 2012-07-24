From: Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 00/13] UAPI header file split
Date: Tue, 24 Jul 2012 14:48:38 +0200
Message-ID: <CAHO5Pa0NOUk=Z8SNQ9t=Oi6aU96o-JtMuAytAoXJ2v1L0ntNww@mail.gmail.com>
References: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49128 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2GXMs7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jul 2012 08:48:59 -0400
In-Reply-To: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com

On Fri, Jul 20, 2012 at 11:56 PM, David Howells <dhowells@redhat.com> wrote:

[...]

> ===================
> IMPLEMENTING STEP 1
> ===================
>
> The patches actually posted here are the manual preparation for the UAPI split
> in step (1) above.  I haven't posted the patches that do the actual splitting
> by email as the largest of them is in excess of 120,000 lines.  However, the
> patches are available through GIT:
>
>         http://git.infradead.org/users/dhowells/linux-headers.git
>
> The patches are to be found on the uapi-split branch.  The patches posted here
> are from the base of that branch up to the uapi-prep tag; the automated split
> follows thereafter to the uapi-post-split tag.

In the uapi-split branch, there are now 44 empty Kbuild files. Was
that intended? Or, should these files rather be removed by your
patches?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface", http://blog.man7.org/
