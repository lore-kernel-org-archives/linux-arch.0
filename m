From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] siginfo fix for 4.16-rc1
Date: Wed, 31 Jan 2018 11:30:58 -0800
Message-ID: <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com> <87607im26i.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:51590 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeAaTa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jan 2018 14:30:59 -0500
In-Reply-To: <87607im26i.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On Wed, Jan 31, 2018 at 8:19 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I had a brain fart when I received Stephen email about a compile failure
> in linux-next.  I thought the powerpc call to memory_failure had not
> merged yet.  Instead it simply failed to compile :(
>
> Linus can you please pull Stephen's fix so that powerpc builds correctly.

I fixed this up in the merge already, afaik. Or is there some other failure?

                     Linus
