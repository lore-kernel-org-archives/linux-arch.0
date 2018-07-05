Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56627 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbeGEFjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jul 2018 01:39:15 -0400
Date: Thu, 5 Jul 2018 13:38:43 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 05/19] csky: System Call
Message-ID: <20180705053842.GA11749@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
 <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com>
 <20180704114952.GB22857@guoren>
 <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180705053843.j9k12HRwXV6o8tyU22PinyW3IareSns1oxf6HZ8gwik@z>

On Wed, Jul 04, 2018 at 11:04:37PM +0200, Arnd Bergmann wrote:
> Right, I do understand what it's used for, my point was that you
> don't really need a separate system call number for it, just redirect
> the entry point using the same trick that nds32 has in
> arch/nds32/kernel/syscall_table.c:
> 
> #define sys_fadvise64_64 csky_fadvise64_64
Thx for the tip :)

 Guo Ren
