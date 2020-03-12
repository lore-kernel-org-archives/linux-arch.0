From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] asm-generic: Provide generic
 {get,put}_unaligned_{l,b}e24()
Date: Thu, 12 Mar 2020 16:43:40 +0200
Message-ID: <20200312144340.GV1922688@smile.fi.intel.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <20200312140542.GA17152@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17696 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgCLOnn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 10:43:43 -0400
Content-Disposition: inline
In-Reply-To: <20200312140542.GA17152@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, bvanassche@acm.org

On Thu, Mar 12, 2020 at 03:05:42PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 12, 2020 at 01:39:41PM +0200, Andy Shevchenko wrote:
> > There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> > implementation. Provide generic helpers once for all.
> 
> I have a vague memory of Bart sending a patch like this a while ago,
> adding him to verify my theory.

Thanks!

> Also is there any good to have this in asm-generic/ vs linux/?

For now on it is least invasive. asm-generic/unaligned is a cross point for all
unaligned accessor helpers, since we here do byteshift approach for all
possible variants, I don't see any other header suitable. Or are you talking
about something like linux/unaligned/24bit.h -> #include <...> here?

-- 
With Best Regards,
Andy Shevchenko
