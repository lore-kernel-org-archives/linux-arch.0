From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 00/24] C6X: New architecture
Date: Wed, 5 Oct 2011 18:16:43 +0200
Message-ID: <201110051816.44080.arnd@arndb.de>
References: <1317746641-26725-1-git-send-email-msalter@redhat.com> <3214215.H2jdYLnAju@wuerfel> <1317819123.2703.8.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61032 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934476Ab1JEQQ6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2011 12:16:58 -0400
In-Reply-To: <1317819123.2703.8.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 05 October 2011, Mark Salter wrote:
> On Tue, 2011-10-04 at 21:27 +0200, Arnd Bergmann wrote:
> > On Tuesday 04 October 2011 12:43:37 Mark Salter wrote:
> > > Here is v4 of the C6X architecture patch series. Patches are
> > > available in 'for-linux-next' branch at:
> > > 
> > >     http://linux-c6x.org/git/projects/linux-c6x-upstreaming.git
> > 
> > Hi Mark,
> > 
> > This looks all good to me, great work!
> > 
> >       Arnd
> 
> Thanks! So what is the next step?

Easy:
* Make sure the code is in linux-next
* Make sure that linux-next actually still works for you, with everything else that 
  went in
* Wait for Linus to open the merge window, then send him a pull request,
  with the same Cc list as this review.

Once everything is merged, you are alone responsible for deciding what
goes in, but we will be there to give advice when needed.

	Arnd
