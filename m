Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1862 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeFGJyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 05:54:03 -0400
Message-ID: <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Date: Thu, 07 Jun 2018 11:03:19 +0200
In-Reply-To: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
         <201806060501.btF3aJMZ%fengguang.wu@intel.com>
         <20180606095714.1d3c2def@vmware.local.home>
         <20180606142600.GN13775@localhost>
         <20180606142622.2338abf6@vmware.local.home>
         <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
         <20180607074628.kd3iyxevwj3ypzbr@intel.com>
         <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org, alex.elder@linaro.org, Johan Hovold <johan@kernel.org>, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180607090319.nL4m_7K3DSt9fZnNFtx-pF2CTbapOKhvAjxVZzvV9yc@z>

On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> On 07-06-18, 15:46, Du, Changbin wrote:
> > I think if the destination is not a null terminated string (If I understand your
> > description below), memcpy can be used to get rid of such warning. The warning
> > makes sense in general as explained in mannual. Thanks!
> 
> The destination should be a null terminated string eventually, but we first need
> to make sure src is a null terminated string.

Is there strnlen() or memchr() in the kernel?
Then check the source before copying it.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
