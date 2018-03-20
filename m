Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56906 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753246AbeCTNW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Mar 2018 09:22:56 -0400
Date: Tue, 20 Mar 2018 21:22:38 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 14/19] csky: Misc headers
Message-ID: <20180320132237.GA11611@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com>
 <20180320033654.GA21731@guoren>
 <CAK8P3a1TokZ_odmBFy5FWCLp2ExF+uYR2X_pn-MSPbuM26MZ2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1TokZ_odmBFy5FWCLp2ExF+uYR2X_pn-MSPbuM26MZ2w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180320132238.GyuZYyYEW_I_X6z3zh0p2pOmNvvE8op68Nkd5o_f7F0@z>

On Tue, Mar 20, 2018 at 03:54:53PM +0800, Arnd Bergmann wrote:
> We generally assume that any upstream kernel ABI cannot be changed, so this
> has to be changed before the code gets merged upstream.
> 
> You can obviously maintain the old and the new ABI in parallel for a while,
> until the libc supports the new ABI, but you can't do that in the patches
> you send for integration.
> 
> This is more important for the list of system calls, but when you change
> the ABI, it should be changed all at once.
Ok, follow the rules. I will modify uclibc-ng and glibc now.
