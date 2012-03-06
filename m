From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: lib/string.h build failure in linux-next
Date: Tue, 6 Mar 2012 16:10:07 -0500
Message-ID: <CAP=VYLpM6Dg0R6hjGmc0Bt=h=OZjTFWMEn7wjF0D4tGRkpF5mw@mail.gmail.com>
References: <1331048540.17099.9.camel@deneb.redhat.com>
	<201203061602.23512.arnd@arndb.de>
	<1331050578.17099.13.camel@deneb.redhat.com>
	<CAP=VYLpwBth3YyHQ17Gs_GbfQHBWfcJO+VHLNnD=oBXgtCK0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAP=VYLpwBth3YyHQ17Gs_GbfQHBWfcJO+VHLNnD=oBXgtCK0wQ@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 6, 2012 at 2:55 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Tue, Mar 6, 2012 at 11:16 AM, Mark Salter <msalter@redhat.com> wro=
te:
>> On Tue, 2012-03-06 at 16:02 +0000, Arnd Bergmann wrote:
>>> On Tuesday 06 March 2012, Mark Salter wrote:
>>> > I'm seeing a build failure in lib/string.h in linux-next:
>>> >
>>> > /es/linux/linux-next/lib/string.c: In function 'strlcat':
>>> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declarat=
ion of function 'printk'
>>> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declarat=
ion of function 'panic'
>>> >
>>> > Commit e2950c2b6ecb928bfd3a13dd237df1f29f712704 removed an includ=
e of
>>> > linux/module.h which triggered the problem for arch/c6x and proba=
bly
>>> > other architectures using the asm-generic BUG macro.
>>> >
>>> > I think this needs fixing in asm-generic/bug.h which should inclu=
de
>>> > linux/kernel.h for panic and linux/printk.h for printk.
>>>
>>> I think you cannot do that as long as linux/kernel.h includes asm/b=
ug.h,
>>> or you will get a lot of other build failures.
>>
>> It didn't for my build, but to tell the truth, I really wasn't too k=
een
>> on adding an include of kernel.h to asm/bug.h since kernel.h pulls i=
n so
>> much other stuff.
>>
>>>
>>> The safer option is probably to add the two missing headers separat=
ely
>>> to string.c.
>>
>> Okay, I can put together a patch that does that.
>
> I can deal with this, since it is interaction between my bug commits =
and my
> module commits that trigger it. =A0Can you tell me what config you ar=
e using, so
> I can double check I have it sorted properly?

Never mind the config.  I missed the arch/c6x initially.  I've got a
c6x toolchain
now and can reproduce it with the dsk6455_defconfig.  Will be fixed for=
 this
evening's linux-next.

Thanks for the report.
Paul.


> Thanks.
> Paul.
>
>>
>> --Mark
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
