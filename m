Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59598 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752055AbeC0B6u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Mar 2018 21:58:50 -0400
Date: Tue, 27 Mar 2018 09:58:36 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Message-ID: <20180327015835.GA10185@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180327015836.NYtEMFA4VUPlJL1rHMqGNTZ5YEqKbeZKNbR_7FRMn9c@z>

On Mon, Mar 26, 2018 at 03:30:34PM +0200, Arnd Bergmann wrote:
> Thanks for your submission. I had started reviewing it over a week
> ago, but never
> completed since I was travelling in the meantime. I've completed my first pass
> now and will wait for a new version before I take a more detailed look.
> 
> Overall, it looks nice, but changing the rest of the system call interface will
> take a while, this includes several points I've mentioned already, but
> to clarify,
> every file in arch/csky/include/uapi/asm/ needs to be carefully reviewed to
> contain only the minimum required additions to the asm-generic version.
> 
> Changing the ABI will obviously get in the way of testing, but this should
> be over as soon as the port is merged.
I entirely agree with you. After modify the unistd.h, we found a lot of
ltp-cases failed. We are dealing with them.

Best Regards
 Guo Ren
