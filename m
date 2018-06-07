Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33511 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbeFGIjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 04:39:01 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so5675415plp.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 01:39:00 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:08:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607074628.kd3iyxevwj3ypzbr@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org, alex.elder@linaro.org, Johan Hovold <johan@kernel.org>, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180607083856.-g6xIPx1uM_cF3AAtgjslhhl9NYpNrParGJ5owQdlb4@z>

On 07-06-18, 15:46, Du, Changbin wrote:
> I think if the destination is not a null terminated string (If I understand your
> description below), memcpy can be used to get rid of such warning. The warning
> makes sense in general as explained in mannual. Thanks!

The destination should be a null terminated string eventually, but we first need
to make sure src is a null terminated string.

-- 
viresh
