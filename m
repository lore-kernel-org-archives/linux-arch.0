Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:57571 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757439AbYAUUbK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Jan 2008 15:31:10 -0500
Date: Mon, 21 Jan 2008 21:31:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: improved Section mismatch detection
Message-ID: <20080121203117.GA752@uranus.ravnborg.org>
References: <20080120200527.GA23852@uranus.ravnborg.org> <20080120222754.GK8669@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080120222754.GK8669@does.not.exist>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>

On Mon, Jan 21, 2008 at 12:27:54AM +0200, Adrian Bunk wrote:
> On Sun, Jan 20, 2008 at 09:05:27PM +0100, Sam Ravnborg wrote:
> >...
> > Adrian reminded us that KCFLAGS=-fno-inline told
> > another story with more than 100 Section mismatch
> > warnings on 64 bit x86 with an allyesconfig build.
> >...
> 
> Not -fno-inline but -fno-inline-functions-called-once
> (completely different option).

Do you know when gcc started to support
-fno-inline-functions-called-once?

I do not have anything older than 3.4.5 build here.

I should have a gcc 3.2 (Documentation/Changes)
but no at the moment.

	Sam
