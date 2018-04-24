Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42101 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932842AbeDXIcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2018 04:32:55 -0400
MIME-Version: 1.0
In-Reply-To: <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 24 Apr 2018 10:32:53 +0200
Message-ID: <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20180424083253.5gOjajXHVBnVN_IorY1z8hpjOlZaUqCIlmpSoyRzRMg@z>

On Fri, Apr 20, 2018 at 6:06 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
> On 04/20/18 15:38, Eric W. Biederman wrote:
>>
>> Today user mode linux only works on x86 and x86_64 and this allows
>> simplifications of relay_signal.
>
>
> I believe someone recently fixed the ARM port. I have not had the time to
> try the fixes though.

Huh? UML is for ages x86 only.

-- 
Thanks,
//richard
