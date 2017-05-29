From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Mon, 29 May 2017 10:14:50 -0700
Message-ID: <CA+55aFwofV0DZhh+yGH_=ceBzFcSr_tGexuGV4Wioao096R-uQ@mail.gmail.com>
References: <20170529081103.29999-1-npiggin@gmail.com> <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35458 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE2ROv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 13:14:51 -0400
In-Reply-To: <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, May 29, 2017 at 10:03 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So either thin archives work or they don't. Don't make it some painful
> drawn-out process that actually makes it harder to test rather than
> easier.

Side note: what would make them not work? Are there known bugs in 'ar'
wrt thin archives, versioning issues, or other issues?

                 Linus
