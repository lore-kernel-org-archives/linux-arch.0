Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 14:18:03 -0500
Date: Thu, 22 Feb 2018 13:17:58 -0600
From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: Removing architectures without upstream gcc support
Message-ID: <20180222191758.GB5180@codeaurora.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
> * Hexagon is Qualcomm's DSP architecture. It is being actively used
>   in all Snapdragon ARM SoCs, but the kernel code appears to be
>   the result of a failed research project to make a standalone Hexagon
>   SoC without an ARM core. There is some information about the
>   project at https://wiki.codeaurora.org/xwiki/bin/Hexagon/ and
>   https://unix.stackexchange.com/questions/246243/what-is-was-the-qualcomm-hexagon-comet-board
>   There is a port to gcc-4.5 on the project page, which is evidently
>   abandoned, but there is an active upstream LLVM port that is
>   apparently used to build non-Linux programs.
>   I would consider this one a candidate for removal as well, given that
>   there were never any machines outside of Qualcomm that used this,
>   and they are no longer interested themselves.

It's difficult for me to speak to the decisions as I can understand
your point of view, but maybe I can speak to some of the status.

We still use the port internally for kicking the tools around and other
research projects.  As you noticed we're not doing gcc anymore; we're
using LLVM for both kernel and userspace.  Yes there have been some
caveats but it does work within confines.

Time is unfortunately just limited for me to upstream some of my kernel
fixes and cleanups, and there are some things that just haven't shown
up externally yet.

However, as James Hogan mentioned, having it in the tree really has been
useful because it gets included in the various upstream changes and
fixes, which we appreciate.

So hopefully this will help inform the decision a little better.

If you have any other questions please let me know.


Thanks,
Richard Kuo



-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
