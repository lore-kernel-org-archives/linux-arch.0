From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: lib/string.h build failure in linux-next
Date: Tue, 6 Mar 2012 14:55:40 -0500
Message-ID: <CAP=VYLpwBth3YyHQ17Gs_GbfQHBWfcJO+VHLNnD=oBXgtCK0wQ@mail.gmail.com>
References: <1331048540.17099.9.camel@deneb.redhat.com>
	<201203061602.23512.arnd@arndb.de>
	<1331050578.17099.13.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:48576 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965199Ab2CFTzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2012 14:55:41 -0500
In-Reply-To: <1331050578.17099.13.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Mar 6, 2012 at 11:16 AM, Mark Salter <msalter@redhat.com> wrote=
:
> On Tue, 2012-03-06 at 16:02 +0000, Arnd Bergmann wrote:
>> On Tuesday 06 March 2012, Mark Salter wrote:
>> > I'm seeing a build failure in lib/string.h in linux-next:
>> >
>> > /es/linux/linux-next/lib/string.c: In function 'strlcat':
>> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declarati=
on of function 'printk'
>> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declarati=
on of function 'panic'
>> >
>> > Commit e2950c2b6ecb928bfd3a13dd237df1f29f712704 removed an include=
 of
>> > linux/module.h which triggered the problem for arch/c6x and probab=
ly
>> > other architectures using the asm-generic BUG macro.
>> >
>> > I think this needs fixing in asm-generic/bug.h which should includ=
e
>> > linux/kernel.h for panic and linux/printk.h for printk.
>>
>> I think you cannot do that as long as linux/kernel.h includes asm/bu=
g.h,
>> or you will get a lot of other build failures.
>
> It didn't for my build, but to tell the truth, I really wasn't too ke=
en
> on adding an include of kernel.h to asm/bug.h since kernel.h pulls in=
 so
> much other stuff.
>
>>
>> The safer option is probably to add the two missing headers separate=
ly
>> to string.c.
>
> Okay, I can put together a patch that does that.

I can deal with this, since it is interaction between my bug commits an=
d my
module commits that trigger it.  Can you tell me what config you are us=
ing, so
I can double check I have it sorted properly?

Thanks.
Paul.

>
> --Mark
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
