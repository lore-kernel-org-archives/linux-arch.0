From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 60/73] drivers/bluetooth: delete non-required instances of include <linux/init.h>
Date: Tue, 21 Jan 2014 13:55:01 -0800
Message-ID: <8861C0F9-FF68-47B8-B9EB-E52BF6A72A6F@holtmann.org>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-61-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45863 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbaAUVzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 16:55:09 -0500
In-Reply-To: <1390339396-3479-61-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>

Hi Paul,

> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> drivers/bluetooth/ath3k.c       | 1 -
> drivers/bluetooth/bcm203x.c     | 1 -
> drivers/bluetooth/bfusb.c       | 1 -
> drivers/bluetooth/bluecard_cs.c | 1 -
> drivers/bluetooth/bpa10x.c      | 1 -
> drivers/bluetooth/bt3c_cs.c     | 1 -
> drivers/bluetooth/btuart_cs.c   | 1 -
> drivers/bluetooth/dtl1_cs.c     | 1 -
> 8 files changed, 8 deletions(-)

I can take this single patch via bluetooth-next tree or if Linus for example wants to take the whole series, then that is fine with me as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel
