From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v4 18/29] nios2: Signal handling support
Date: Thu, 9 Oct 2014 16:33:46 +0800
Message-ID: <CAFiDJ5_JSe+9iu+APwVHkcyoyyNwQWhWDeQQjgUxyhDUhQxd7A@mail.gmail.com>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
	<1412760595-3935-19-git-send-email-lftan@altera.com>
	<CAFLxGvyjd8kA=QwFEju4zWG-ntYsRHnk6p4Sh6Rf_GJQuDR1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39861 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804AbaJIIdt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Oct 2014 04:33:49 -0400
In-Reply-To: <CAFLxGvyjd8kA=QwFEju4zWG-ntYsRHnk6p4Sh6Rf_GJQuDR1tw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Chung-Lin Tang <cltang@codesourcery.com>

On Wed, Oct 8, 2014 at 7:29 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Wed, Oct 8, 2014 at 11:29 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> This patch adds support for signal handling.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>
> Maybe I'm misreading your code but where do you check for multiple
> pending signals?
> It looks like you're handling only exact one signal before retuning to
> userspace.
> This is a serious issue, if you post a SIGSEGV i.e. in
> do_rt_sigreturn() you need to handle it later
> instead of directly returning to userspace.
Yes, Al also pointing out this. Will update this.

Regards
Ley Foon
