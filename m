Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfH2QMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 12:12:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so2353757pfc.13
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 09:12:13 -0700 (PDT)
Date: Thu, 29 Aug 2019 09:12:10 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <201908290910.BA3ED6BDEF@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
 <201908241206.D223659@keescook>
 <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190829161210.yD2bkRSIswrnGW_o_yfKQvlGAVQZXyvuuhvRwMXeja4@z>

On Thu, Aug 29, 2019 at 06:55:59AM +0200, Christophe Leroy wrote:
> Euh ... only received this mail yesterday. Same for the other answer.

Yeah, my outbound mail was busted. :(

> I think you wanted to use In-reply-to:
> [...]
> But still, Andrew is seing double ... And me as well :)
> 
> Fixes: Fixes:

I had a lot of failures in that email. :)

Thank you Andrew for cleaning this up.

-- 
Kees Cook
