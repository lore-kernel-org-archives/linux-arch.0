From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
Date: Thu, 12 Mar 2020 18:25:07 +0200
Message-ID: <20200312162507.GF1922688@smile.fi.intel.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7804 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCLQZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 12:25:09 -0400
Content-Disposition: inline
In-Reply-To: <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Thu, Mar 12, 2020 at 08:18:07AM -0700, Bart Van Assche wrote:
> On 2020-03-12 04:39, Andy Shevchenko wrote:
> > There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> > implementation. Provide generic helpers once for all.
> 
> Hi Andy,
> 
> Thanks for having done this work. In case you would not yet have noticed
> the patch series that I posted some time ago but for which I did not
> have the time to continue working on it, please take a look at
> https://lore.kernel.org/lkml/20191028200700.213753-1-bvanassche@acm.org/.

Can you send a new version?

Also, consider to use byteshift to avoid this limitation:
"Only use get_unaligned_be24() if reading p - 1 is allowed."


-- 
With Best Regards,
Andy Shevchenko
