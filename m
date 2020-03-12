From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
Date: Thu, 12 Mar 2020 08:18:07 -0700
Message-ID: <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40466 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCLPSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2020 11:18:11 -0400
In-Reply-To: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On 2020-03-12 04:39, Andy Shevchenko wrote:
> There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> implementation. Provide generic helpers once for all.

Hi Andy,

Thanks for having done this work. In case you would not yet have noticed
the patch series that I posted some time ago but for which I did not
have the time to continue working on it, please take a look at
https://lore.kernel.org/lkml/20191028200700.213753-1-bvanassche@acm.org/.

Thanks,

Bart.
