From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 0/4] xtensa: conversion to generic kernel_thread and
 friends
Date: Mon, 29 Oct 2012 18:11:56 +0000
Message-ID: <20121029181156.GZ2616@ZenIV.linux.org.uk>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
 <508EAD7B.9000303@zankel.net>
 <CAMo8BfKUDHyMjDRUO8jRJ=RFWcsasXKe0_Rr88+xjLkkzTa_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47887 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2J2SL7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 14:11:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMo8BfKUDHyMjDRUO8jRJ=RFWcsasXKe0_Rr88+xjLkkzTa_Ng@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: czankel <chris@zankel.net>, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>

On Mon, Oct 29, 2012 at 07:58:02PM +0300, Max Filippov wrote:
> On Mon, Oct 29, 2012 at 8:23 PM, czankel <chris@zankel.net> wrote:
> > Hi Max,
> >
> > Has anything changed from the version that's already in linux-next? I wanted
> > to push that version upstream today.
> 
> It's the same. I sent self-contained series to Al in case it blocks whatever.

I'd very much prefer to pull from xtensa tree, to avoid the PITA with
merge conflicts later.  It's your current #for_next, right?  And there's
not much besides those commits in there, so I'm grabbing that one...
