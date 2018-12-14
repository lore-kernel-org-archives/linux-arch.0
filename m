Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:36618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNXY3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Dec 2018 18:24:29 -0500
Date: Fri, 14 Dec 2018 15:24:24 -0800 (PST)
Message-ID: <20181214.152424.610334997107326314.davem@davemloft.net>
Subject: Re: [PATCH v2 0/8] net: y2038-safe socket timestamps 
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181211202520.16799-1-deepa.kernel@gmail.com>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: deepa.kernel@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, chris@zankel.net, deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com, isdn@linux-pingi.de, jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net, schwidefsky@de.ibm.com, tglx@linutronix.de, ubraun@linux.ibm.com, linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Message-ID: <20181214232424.7L7T3Kt4t4Yr031tGBcrVfXSD59kEGfR6m9nv3weXws@z>

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 11 Dec 2018 12:25:12 -0800

> The series introduces new socket timestamps that are
> y2038 safe.

Please address Willem's feedback, thank you.
