From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read notrace
Date: Fri, 16 Sep 2016 09:19:49 -0400
Message-ID: <20160916091949.3b8c0e52@gandalf.local.home>
References: <1473497134-27807-1-git-send-email-zhang.chunyan@linaro.org>
        <CAG2=9p-v53OJovx4f=YsHD71vNz4EksJ_7tKfzMZeaK3qYxuog@mail.gmail.com>
        <20160916095309.GM3380@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:40788 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752881AbcIPNTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Sep 2016 09:19:53 -0400
In-Reply-To: <20160916095309.GM3380@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>

On Fri, 16 Sep 2016 10:53:09 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Fri, Sep 16, 2016 at 04:42:44PM +0800, Chunyan Zhang wrote:
> > Hi Will and Steven,
> > 
> > May I have a review or an acked-by from you on this patch so that Arnd
> > can pick it up.
> > 
> > I have tested this patch on arm qemu, I'm sure it can solve the
> > problem described in commit message.  
> 
> It looks fine to me; we took your equivalent patch for arm64 already, so:
> 

Looks good to me too.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
