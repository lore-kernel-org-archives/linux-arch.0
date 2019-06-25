Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYUIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 16:08:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so9470413pgp.11
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:08:09 -0700 (PDT)
Date: Tue, 25 Jun 2019 13:08:07 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: Detecting the availability of VSYSCALL
Message-ID: <201906251131.419D8ACB@keescook>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org, kernel-hardening@lists.openwall.com, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Carlos O'Donell <carlos@redhat.com>
Message-ID: <20190625200807.swUScyKrNz_bJ3knW85mVbDodC07CxcCVcLFpHMebEE@z>

On Tue, Jun 25, 2019 at 05:15:27PM +0200, Florian Weimer wrote:
> Should we try mapping something at the magic address (without MAP_FIXED)
> and see if we get back a different address?  Something in the auxiliary
> vector would work for us, too, but nothing seems to exists there
> unfortunately.

It seems like mmap() won't even work because it's in the high memory
area. I can't map something a page under the vsyscall page either, so I
can't distinguish it with mmap, mprotect, madvise, or msync. :(

-- 
Kees Cook
