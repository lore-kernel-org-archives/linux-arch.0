Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:34861 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYG2DOo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 23:14:44 -0400
Date: Mon, 28 Jul 2008 23:06:47 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to
	convert
Message-ID: <20080729030647.GA11425@phobos.i.cabal.ca>
References: <20080728200500.GA14284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080728200500.GA14284@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20080729030647.PTqj8VaPsnWtp72d5L7Zw_CuY2EBgDGKi8KLnzgFoaI@z>

On Mon, Jul 28, 2008 at 10:05:00PM +0200, Sam Ravnborg wrote:
> I am limited in time and resources at the moment but I
> would be glad to help out as time permits should there
> be any questions.
> 

Just a quick one... I moved the files on parisc, but found we're still
using include/asm-$foo/asm-offsets.h. A quick glance at Kbuild seems to
indicate so. Is this expected?

cheers, Kyle
