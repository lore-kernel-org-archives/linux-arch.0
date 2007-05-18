Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:42201 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365AbXERJU4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 05:20:56 -0400
Date: Fri, 18 May 2007 11:21:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 06/14] kbuild: introduce __init_refok/__initdata_refok to supress section mismatch warnings
Message-ID: <20070518092153.GB12551@uranus.ravnborg.org>
References: <20070518064126.GA12193@uranus.ravnborg.org> <20070518065352.GF12284@uranus.ravnborg.org> <jefy5uec5e.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jefy5uec5e.fsf@sykes.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, May 18, 2007 at 11:03:57AM +0200, Andreas Schwab wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > + * The follwoing markers are used for the cases where the reference to
> 
> s/follwoing/following/
> 
> Andreas.

Thnaks, fixed locally.

	Sam
