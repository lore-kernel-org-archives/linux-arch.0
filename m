Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39894 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751085AbeC1DuL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Mar 2018 23:50:11 -0400
Date: Wed, 28 Mar 2018 11:49:59 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Message-ID: <20180328034957.GA4482@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren>
 <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
 <20180321124137.GA21320@guoren>
 <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
 <20180327023927.GA11454@guoren>
 <CAK8P3a3A+BEmBnGCSiRdoaiqSJjhC5zaZebcq2GPVaLJatBk8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3A+BEmBnGCSiRdoaiqSJjhC5zaZebcq2GPVaLJatBk8Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180328034959.BrCvtjEL1_xtwnGdlFqO5icegrVyV4PUitK497m9X5o@z>

Hi Arnd,

On Tue, Mar 27, 2018 at 09:38:56AM +0200, Arnd Bergmann wrote:
> Usually the way gcc handles this, either each CPU is a strict superset
> of another
> one, so you just need to specify the one with the smallest instruction set,
> or you have an option like -mcpu=generic that produces the common subset.
>
ck807 ck810 ck860 are diffrent architecture, so they can not be strict
superset and there is no option like '-mcpu=generic' in our gcc and
binutils.

I know you want one vmlinux which could run on all ck807 ck810 ck860 with
different dts-setting. But now, may I keep current design for abiv1&abiv2?

In abiv3, we will take your advice seriously.

Best Regards
 Guo Ren
