From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 18:12:50 +0100
Message-ID: <20170513171249.GY390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdEMRMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 13:12:52 -0400
Content-Disposition: inline
In-Reply-To: <20170513170056.GX390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 06:00:56PM +0100, Al Viro wrote:

> > But I don't see the excuse for not just doing it. If nobody notices,
> > it's an obvious improvement. And if somebody *does* notice, we know
> > how to do it properly with unsafe_xyz_user(), because "__xyz_user()"
> > most definitely isn't it.
> 
> I think we ought to actually look through those places - there are few
> enough of them (outside of arch/, that is) and stac/clac overhead is
> not the only problem they tend to have.

PS: just to make it clear - I do _not_ propose to keep that shit around
indefinitely; I want __get_user()/__put_user() gone by the end of that
work.
