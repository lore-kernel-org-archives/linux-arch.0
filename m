Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeAaDNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 22:13:02 -0500
Date: Wed, 31 Jan 2018 03:13:00 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] vfs.git: poll annotations
Message-ID: <20180131031300.GE29051@ZenIV.linux.org.uk>
References: <20180130183939.GB29051@ZenIV.linux.org.uk>
 <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180131031300.WGozyBcqih6-50MXHEamuxXhgnjnI-MAdrr0J3lW_EM@z>

On Tue, Jan 30, 2018 at 06:21:37PM -0800, Linus Torvalds wrote:
> On Tue, Jan 30, 2018 at 10:39 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >         Introduces a __bitwise type for POLL... bitmap, propagates
> > the annotations through the tree.
> 
> Ok, I'm not entirely happy with this.
> 
> I don't think the mangle/demangle_poll() stuff should be in the uapi
> headers, and it really worries me that we use the same names - with
> different values - for the kernel and user versions of the POLLxyz
> macros.

I'm not happy with that either, but the alternative would be to
rename almost every instance of POLL... in the tree.  All of them
except for poll.h, actually.  And then keep playing whack-a-mole
for resurfacing POLL... in drivers.

Sure, we can do that, but at least let's do that as a single
search-and-replace job in -rc1.  Too many conflicts otherwise.
No need to invent KPOLLIN et.al. - we have perfectly usable
EPOLLIN and friends.

A bit of a problem in places like
                        mask & POLLOUT ? "POLLOUT" : "",
but it's not too terrible.  I'll experiment a bit - should be able to
post a script to run.

As for the place for mangle/demangle... where would you prefer them?
