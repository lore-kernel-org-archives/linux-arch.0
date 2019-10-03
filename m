Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJCVF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 17:05:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so2489778pfn.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 14:05:26 -0700 (PDT)
Date: Thu, 3 Oct 2019 14:05:24 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [REPOST][RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <201910031404.C30A0F16@keescook>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook>
 <87y2y271ws.fsf@mid.deneb.enyo.de>
 <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Message-ID: <20191003210524.Ceuv3sL8nLIPnT0RZe6Y7huBQsYVC8Ah5njdkLtQr5M@z>

On Thu, Oct 03, 2019 at 03:44:32PM -0500, Eric W. Biederman wrote:
> 
> This system call has been deprecated almost since it was introduced, and none
> of the common distributions enable it.  The only indication that I can find that
> anyone might care is that a few of the defconfigs in the kernel enable it.  However
> that is a small fractions of the defconfigs so I suspect it just a lack of care
> rather than a reflection of software using the the sysctl system call.
> 
> As there appear to be no users of the sysctl system call, remove the
> code so that the proc filesystem can be simplified.

nitpick: line lengths near 80 characters

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

But, yes, I would love to see this gone. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
