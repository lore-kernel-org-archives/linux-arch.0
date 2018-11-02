Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 16:31:17 -0400
Date: Fri, 2 Nov 2018 12:24:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V13 0/2] C-SKY(csky) Timer Driver
In-Reply-To: <c84a6479-d418-7cd8-ec65-c6ad374ec3f3@linaro.org>
Message-ID: <alpine.DEB.2.21.1811021224120.1895@nanos.tec.linutronix.de>
References: <cover.1540947083.git.ren_guo@c-sky.com> <c84a6479-d418-7cd8-ec65-c6ad374ec3f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Guo Ren <ren_guo@c-sky.com>, arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org

On Fri, 2 Nov 2018, Daniel Lezcano wrote:

> On 31/10/2018 03:06, Guo Ren wrote:
> > Hi Daniel & Thomas,
> > 
> > I sent you "PATCH V13" a few days ago, but no-reply:
> > https://lkml.org/lkml/2018/10/29/608
> > Now I send again.
> > 
> > Although csky subsystem has been merged into linux-4.20, but there is no
> > timer drivers for csky. A lot of boards need these timer drivers.
> > 
> > Please help merge them into linux-4.20, wait for you reply.
> 
> Thomas,
> 
> is it fine if I sent you a late PR based in tip/timers/urgent ?
> 
> These are new drivers.

Sure
