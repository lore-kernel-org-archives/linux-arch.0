From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 14:05:27 +0200
Message-ID: <20170513120527.sdmkwveoo2mq32hf@angband.pl>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:49801 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdEMMFe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 08:05:34 -0400
Content-Disposition: inline
In-Reply-To: <20170513065745.GV390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 07:57:45AM +0100, Al Viro wrote:
> On Fri, May 12, 2017 at 06:00:44PM -0700, Linus Torvalds wrote:
> > But the *first* thing I'd like to do would be to just get rid of
> > __get_user/__put_user as a thing. It really does generate nasty code,
> > and we might as well just make it do that function call.
> 
> But IMO the first step is not to convert __get_user()/__put_user() to
> aliases of get_user()/put_user() - it's to get rid of their infestations
> outside of arch/*.  They are concentrated in relatively few places, so
> we can deal with those individually and then just fucking ban their use
> outside of arch/*.  That's easy enough to watch for - simple git grep will do,
> so anything creeping back will be immediately spotted.

As someone from the peanuts gallery, I took a look for __put_user() in my
usual haunt, drivers/tty/vt/

* use 1: con_[gs]et_trans_*():
  Copies a linear array of 256 bytes/shorts, one by one.
  The obvious patch has 9 insertions(+), 22 deletions(-).

* use 2: con_[gs]et_unimap():
  Ditto, up to 65535*2 shorts, also in a nice linear array.

* use 3: tioclinux():
  Does a __put into a place that was checked only for read.  This got me
  frightened as it initially looked like something that can allow an user to
  write where they shouldn't.  Fortunately, it turns out the first argument
  to access_ok() is ignored on every single architecture -- why does it even
  exist then?  I imagined it's there for some odd arch that allows writes
  when in privileged mode, but unlike what the docs say, VERIFY_WRITE is
  exactly same as VERIFY_READ.

Ie, every use in this sample is wrong.  I suspect the rest of the kernel
should be similar.


Meow!
-- 
Don't be racist.  White, amber or black, all beers should be judged based
solely on their merits.  Heck, even if occasionally a cider applies for a
beer's job, why not?
On the other hand, corpo lager is not a race.
