Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60428 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932282Ab1EXOk1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2011 10:40:27 -0400
Date: Tue, 24 May 2011 15:41:37 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: (Short?) merge window reminder
Message-ID: <20110524154137.5ab5e110@lxorguk.ukuu.org.uk>
In-Reply-To: <20110523231721.GM10009@thunk.org>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
	<20110523192056.GC23629@elte.hu>
	<BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
	<20110523231721.GM10009@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20110524144137.4TaPPoMiIxHcQ8_sjNr7asEH7vYzSQcd60v34L1WSOI@z>

> If we change from 2.6.X to 3.X, then if we don't change anything else,
> then successive stable release will cause the LINUX_VERSION_CODE to be
> incremented.  This isn't necessary bad, but it would be a different
> from what we have now.

I think I prefer 3 digits. Otherwise we will have to pass 3.0, 3.1 and
3.11 all of which numbers still give older sysadmins flashbacks and will
have them waking screaming in the middle of the night.

Also saves breaking all the tools and assumptions people have been used
to for some many years

Alan
