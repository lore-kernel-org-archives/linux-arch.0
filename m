Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:60371 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbXIKNs3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Sep 2007 09:48:29 -0400
Subject: Re: [PATCH 3/4] ia64: fix sn to add include files using EXTRA_CFLAGS
References: <20070909180254.GA20086@uranus.ravnborg.org>
	<20070909180623.GD20086@uranus.ravnborg.org>
From: Jes Sorensen <jes@sgi.com>
Date: 11 Sep 2007 09:48:28 -0400
In-Reply-To: <20070909180623.GD20086@uranus.ravnborg.org>
Message-ID: <yq0odg9e2j7.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

>>>>> "Sam" == Sam Ravnborg <sam@ravnborg.org> writes:

Sam> Changing the global CPPFLAGS is not the recommended way to add
Sam> additional include dirs.  Changed to use EXTRA_CFLAGS.

Sam> Signed-off-by: Sam Ravnborg <sam@ravnborg.org> ---

As SN maintainer I'll add an

Acked-by: Jes Sorensen <jes@sgi.com>

I haven't tested your patch, but I'll take your word for it being
correct - it seems the right thing to do.

Cheers,
Jes
