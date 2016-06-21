Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32815 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcFUTof (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 15:44:35 -0400
Received: by mail-vk0-f43.google.com with SMTP id d185so34501662vkg.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2016 12:44:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3742830.xcm4l8nxyl@wuerfel>
References: <cover.1466466093.git.luto@kernel.org> <CAGXu5jJjihEU0HkSTWJymLZ5y=J03bkBHNgVf9QOSgWz6bf-SQ@mail.gmail.com>
 <1466533948.2756.56.camel@redhat.com> <3742830.xcm4l8nxyl@wuerfel>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 21 Jun 2016 12:43:56 -0700
Message-ID: <CALCETrXB5UuChvGPODfsP0jE3f3yaG8SgtukyfH26jcK2=Jpvw@mail.gmail.com>
Subject: Re: [kernel-hardening] Re: [PATCH v3 06/13] fork: Add generic
 vmalloced stack support
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rik van Riel <riel@redhat.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160621194356.kHNmK4Nj1XRwvXt0edywpNMeobZG5111L0NWzwuz4xc@z>

On Tue, Jun 21, 2016 at 12:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, June 21, 2016 2:32:28 PM CEST Rik van Riel wrote:
>> On Tue, 2016-06-21 at 10:13 -0700, Kees Cook wrote:
>> > On Tue, Jun 21, 2016 at 9:59 AM, Andy Lutomirski <luto@amacapital.net
>> > > wrote:
>> > >
>> > > I'm tempted to explicitly disallow VM_NO_GUARD in the vmalloc
>> > > range.
>> > > It has no in-tree users for non-fixed addresses right now.
>> > What about the lack of pre-range guard page? That seems like a
>> > critical feature for this.
>>
>> If VM_NO_GUARD is disallowed, and every vmalloc area has
>> a guard area behind it, then every subsequent vmalloc area
>> will have a guard page ahead of it.
>>
>> I think disallowing VM_NO_GUARD will be all that is required.
>>
>> The only thing we may want to verify on the architectures that
>> we care about is that there is nothing mapped immediately before
>> the start of the vmalloc range, otherwise the first vmalloced
>> area will not have a guard page below it.
>
> FWIW, ARM has an 8MB guard area between the linear mapping of
> physical memory and the start of the vmalloc area. I have not
> checked any of the other architectures though.

If we start banning VM_NO_GUARD in the vmalloc area, we could also
explicitly prevent use of the bottom page of the vmalloc area.

>
>         Arnd



-- 
Andy Lutomirski
AMA Capital Management, LLC
