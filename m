Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33948 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeFGKMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 06:12:54 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so11178218iog.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 03:12:53 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
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
 <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
From: Alex Elder <elder@linaro.org>
Message-ID: <314bb2b3-186e-d7b0-d800-f77a42fd80fa@linaro.org>
Date: Thu, 7 Jun 2018 05:12:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, Johan Hovold <johan@kernel.org>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>, "Du, Changbin" <changbin.du@intel.com>, Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org, alex.elder@linaro.org, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180607101251.Ih4CHgBp61fkh7ruuqF9PSOiRn0yZhWquJeeG7ZMVRE@z>

On 06/07/2018 04:19 AM, Viresh Kumar wrote:
> On 07-06-18, 11:18, Johan Hovold wrote:
>> If you want to work around the warning and think you can do it in some
>> non-contrived way, then go for it.
>>
>> Clearing the request buffer, checking for termination using strnlen, and
>> then using memcpy might not be too bad.
>>
>> But after all, it is a false positive, so leaving things as they stand
>> is fine too.
> 
> Leave it then :)
> 

It's interesting that the warning isn't reported for this in
fw_mgmt_interface_fw_version_operation().  The difference there is
that you actually put a zero byte at that last position before
returning.  I'm mildly impressed if gcc is distinguishing that.

You *are* returning the fw_info->firmware_tag array newly filled
with a non-null-terminated string in one of the two cases that
get warnings in "fw-management.c".  But the other one is only
updating a buffer in a local/automatic variable.

Weird.  I wish there were a non-clumsy way of marking false positives
like this as A-OK.

					-Alex
