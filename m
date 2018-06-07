Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43840 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeFGJT0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 05:19:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id j20-v6so4604167pff.10
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 02:19:26 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:49:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
References: <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607091816.GT13775@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>, "Du, Changbin" <changbin.du@intel.com>, Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org, alex.elder@linaro.org, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180607091923.BcslzNSwAXbn3xl-LPZRk3hKlN6cJt4KXRttdro4hHw@z>

On 07-06-18, 11:18, Johan Hovold wrote:
> If you want to work around the warning and think you can do it in some
> non-contrived way, then go for it.
> 
> Clearing the request buffer, checking for termination using strnlen, and
> then using memcpy might not be too bad.
> 
> But after all, it is a false positive, so leaving things as they stand
> is fine too.

Leave it then :)

-- 
viresh
