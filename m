Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeIGGqq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 02:46:46 -0400
Date: Thu, 6 Sep 2018 19:08:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 00/26] C-SKY(csky) Linux Kernel Port
Message-ID: <20180907020818.GA9110@roeck-us.net>
References: <cover.1536138304.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180907020818.Iuyu12TkMhPNEEZMLgjDqgWQHtwbdqqMUxqCOApU1hU@z>

Hi,

On Wed, Sep 05, 2018 at 08:07:39PM +0800, Guo Ren wrote:
> This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> Thanks to everyone who provided feedback on the previous version.
> 
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.18.4
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> 	 SMP ...)
> 

My key question is about upstream toolchain support.
The buildroot clone tells me

$ git describe csky/master
2017.11-2111-ge9cc5a5

and

$ git log --oneline origin/master..csky/master  | wc
   1180    7436   57104

with
$ git remote -v
csky	https://gitlab.com/c-sky/buildroot.git 
origin	git://git.buildroot.net/buildroot

So it looks like there are more thasn a thousand patches on top of
buildroot. Adding an architecture to buildroot should only take a
single patch, or maybe a few, but not more than a thousand.
This strongly suggests that a lot of changes are not upstream
but only available in the buildroot clone. 

When are we going to see all those changes in upstream gcc, binutils,
and qemu ? I don't really want to dig through more than a thousand
patches in a buildroot clone to find out details about the status
of upstream toolchain support.

Thanks,
Guenter
