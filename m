Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbdLGQpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2017 11:45:08 -0500
Date: Thu, 7 Dec 2017 16:45:06 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 08/35] nds32: Process management
Message-ID: <20171207164506.GE21978@ZenIV.linux.org.uk>
References: <cover.1511785528.git.green.hu@gmail.com>
 <53789f9af98217d24580479c55e550301651d4a8.1511785528.git.green.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53789f9af98217d24580479c55e550301651d4a8.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171207164506.sjLJB1bkpVC6Llw5JbVtcvII9Ml5dDfsTFo7DyWOhPU@z>

On Mon, Nov 27, 2017 at 08:27:55PM +0800, Greentime Hu wrote:

> +#define start_thread(regs,pc,stack)			\
> +({							\
> +	set_fs(USER_DS);				\

Not the job of start_thread() - its users (->load_binary() methods of
assorted binfmt) must (and do) call flush_old_exec() first.  And
that will switch to USER_DS just fine.
