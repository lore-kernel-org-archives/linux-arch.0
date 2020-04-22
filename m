Return-Path: <SRS0=8toe=6G=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVPBo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 11:01:44 -0400
Date: Wed, 22 Apr 2020 16:01:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Implement close-on-fork
Message-ID: <20200422150107.GK23230@ZenIV.linux.org.uk>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420071548.62112-1-nate.karstens@garmin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nate Karstens <nate.karstens@garmin.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>
Message-ID: <20200422150107.COX9VKp2BwGhjmjZdQo_ifSgW7MuyvPoB0fG3LswdqE@z>

On Mon, Apr 20, 2020 at 02:15:44AM -0500, Nate Karstens wrote:
> Series of 4 patches to implement close-on-fork. Tests have been
> published to https://github.com/nkarstens/ltp/tree/close-on-fork.
> 
> close-on-fork addresses race conditions in system(), which
> (depending on the implementation) is non-atomic in that it
> first calls a fork() and then an exec().
> 
> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

What exactly the reasons are and why would we want to implement that?

Pardon me, but going by the previous history, "The Austin Group Says It's
Good" is more of a source of concern regarding the merits, general sanity
and, most of all, good taste of a proposal.

I'm not saying that it's automatically bad, but you'll have to go much
deeper into the rationale of that change before your proposal is taken
seriously.
