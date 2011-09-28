From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/24] C6X: New architecture
Date: Wed, 28 Sep 2011 16:33:05 +0200
Message-ID: <201109281633.05583.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <20110928091542.9b1e35afa2075106550de7be@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54044 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1I1OdN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:33:13 -0400
In-Reply-To: <20110928091542.9b1e35afa2075106550de7be@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wednesday 28 September 2011, Stephen Rothwell wrote:
>   Show Details
>   On Tue, 27 Sep 2011 16:29:41 -0400 Mark Salter <msalter@redhat.com> wrote:
> >
> > Here is v3 of the C6X architecture patch series. Patches are
> > available in 'upstream-v3' branch at:
> > 
> >     git@linux-c6x.org:/git/projects/linux-c6x-upstreaming
> 
> Is it time for this to be included in linux-next (i.e. are you intending
> to send this to Linus during the next merge window)?  If so, please send
> a request (cc'd to here, linux-next and linux-kernel) asking for
> inclusion.  I would prefer a publically fetchable tree (the tree above is
> (implicitly) fetched over ssh and is so not generally available) and
> branch name that does not change over time (like "for-next" or something)
> but it can just be an alias for the above.
> 
> Arnd, do you have an opinion on this?

From my perspective it can go into -next now. All the issues I have
reported in version 2 have been fixed, and the comments I made this
time are relatively insignificant, so I trust that Mark can fix those
either between now and the merge window or provide updates during the
3.2 bug fix phase. The only thing that absolutely needs to get fixed
before 3.2.0 IMO is the ptrace ABI since we can no longer change that
after a release, but it should also be a trivial change.

Thomas, you also had some important comments, please complain if you
see those as show-stoppers for integration into linux-next.

	Arnd
