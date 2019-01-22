Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbfAVMkr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Jan 2019 07:40:47 -0500
Date: Tue, 22 Jan 2019 13:40:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v25 0/6] Add io{read|write}64 to io-64-atomic headers
Message-ID: <20190122124044.GA11753@kroah.com>
References: <20190116182523.19446-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116182523.19446-1-logang@deltatee.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Message-ID: <20190122124044.7rcGeT4oP496lkRxVTINoRWlcgKq-ZybJadVU_XVi3w@z>

On Wed, Jan 16, 2019 at 11:25:17AM -0700, Logan Gunthorpe wrote:
> This is resend number 6 since the last change to this series.
> 
> This cleanup was requested by Greg KH back in June of 2017. I've resent the series
> a couple times a cycle since then, updating and fixing as feedback was slowly
> recieved some patches were alread accepted by specific arches. In June 2018,
> Andrew picked the remainder of this up and it was in linux-next for a
> couple weeks. There were a couple problems that were identified and addressed
> back then and I'd really like to get the ball rolling again. A year
> and a half of sending this without much feedback is far too long.
> 
> @Andrew, can you please pick this set up again so it can get into
> linux-next? Or let me know if there's something else I should be doing.

version 25?  That's crazy, this has gone on too long.  I've taken this
into my char/misc driver tree now, so sorry for the long suffering you
have gone through for this.

Thanks for being persistent,

greg k-h
