Return-Path: <SRS0=UTne=45=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37499 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCLOFq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 10:05:46 -0400
Date: Thu, 12 Mar 2020 15:05:42 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] asm-generic: Provide generic
 {get,put}_unaligned_{l,b}e24()
Message-ID: <20200312140542.GA17152@lst.de>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, bvanassche@acm.org
Message-ID: <20200312140542.lyXVvAL8xWmkS55QSh376EdSSuqv_jMxyI2kaHC2R-8@z>

On Thu, Mar 12, 2020 at 01:39:41PM +0200, Andy Shevchenko wrote:
> There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> implementation. Provide generic helpers once for all.

I have a vague memory of Bart sending a patch like this a while ago,
adding him to verify my theory.

Also is there any good to have this in asm-generic/ vs linux/?
