From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] vfs.git: poll annotations
Date: Wed, 31 Jan 2018 17:50:01 +0000
Message-ID: <20180131175001.GA1433@ZenIV.linux.org.uk>
References: <20180130183939.GB29051@ZenIV.linux.org.uk>
 <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
 <20180131031300.GE29051@ZenIV.linux.org.uk>
 <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
 <20180131044620.GF29051@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60394 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeAaRuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jan 2018 12:50:02 -0500
Content-Disposition: inline
In-Reply-To: <20180131044620.GF29051@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Wed, Jan 31, 2018 at 04:46:20AM +0000, Al Viro wrote:

> MSG and REMOVE are never triggered, so it's all down to {WR{NORM,BAND},RDHUP}.

Actually, POLLREMOVE is an amusing story (FSVO amusing): it's a part of
UnixWare /dev/poll ABI.  It had _not_ lasted in Linux - epoll_ctl()
EPOLL_CTL_DEL is used for the same purpose.  Chronology:

Oct 29 2002: davidel introduces it into the tree (and defines for i386)
Oct 31 2002: jgarzik has noticed broken alpha build and added definition
within a few hours the same had been done for itanic (davidm)
afternoon of the same day: Alan's merge of v850 adds definition there
Nov 1 2002: rmk adds definition for arm
Nov 2 2002: anton does the same for ppc64
Nov 2 2002: ak does the same for amd64
Nov 2 2002: davidel removes the sole user of that thing.
But that, of course, does not stop the propagation of the (now and forever)
useless definition - the same day it infects m68k; next day it's
parisc and sparc.  On Nov 8 it hits ppc32, Nov 17 - s390.
In June 2003 mips gets it, in July sh is brought in with that
thing already in it and the damn thing spreads to cris.  And so it goes;
the last flash of infection had been in 2007 when asm-generic/poll.h
had been introduced.

Its only user has lasted in the tree for four days.  Definitions
will probably stay forever...
