From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 22:25:39 +0100
Message-ID: <20170513212538.GJ390@ZenIV.linux.org.uk>
References: <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
 <20170513203703.GG390@ZenIV.linux.org.uk>
 <CA+55aFyozYzFGoW4gg=7xMquY3T7us9MEn7Nu4-SMwUfMZ3-gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdEMVZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 17:25:40 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyozYzFGoW4gg=7xMquY3T7us9MEn7Nu4-SMwUfMZ3-gQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 01:52:29PM -0700, Linus Torvalds wrote:
> I wouldn't change the existing "memdup_user()" interface itself, but
> if there really are users that can validly pass in a maxbyte value,
> why not add a new helper:
> 
>   void *memdup_user_limit(userptr, nmember, nsize, maxsize);
> 
> and then have
> 
>   #define memdup_user(ptr,size) memdup_user_limit(ptr, size, 1, -1)
> 
> or something. I definitely see a couple of memdup_user() people who do
> that "num*size" multiplication by hand, and it's very easy to get
> wrong and have an overflow.
> 
> And for a kvmalloc/kvfree() interface, you *definitely* want that
> maxsize thing, since it absolutely needs an upper limit.

*nod*

Speaking of insanities around open-coded memdup_user()...  Enjoy:

                ias_opt = kmalloc(sizeof(struct irda_ias_set), GFP_ATOMIC);
                if (ias_opt == NULL) {
                        err = -ENOMEM;
                        goto out;
                }

                /* Copy query to the driver. */
                if (copy_from_user(ias_opt, optval, optlen)) {

Can't have it block, sir, has to be GFP_ATOMIC...  Whaddya mean, "what
if copy_from_user() blocks?"  As far as I can see, that came in circa
2.4.6, when local sturct irda_ias_set got switched to dynamic allocation...
