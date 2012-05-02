From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v11 17/30] resources: Add probe_resource()
Date: Tue, 1 May 2012 22:19:01 -0700
Message-ID: <CAE9FiQURuG9z655PZgP-QR3w7LoSFondt4fhioO0whP=Q7+2rA@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
	<1332135781-13695-18-git-send-email-yinghai@kernel.org>
	<CAErSpo4BZAf_i3ojXpg5WSFJ00G5i_vscVTu2va_Z3WJ0UHg=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4BZAf_i3ojXpg5WSFJ00G5i_vscVTu2va_Z3WJ0UHg=g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 1, 2012 at 4:57 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>> It is changed from busn_res only version, because Bjorn found that v=
ersion
>> was not holding resource_lock.
>> Even it may be ok for busn_res not holding resource_lock.
>> It would be better to have it to be generic and use lock and we woul=
d
>> use it for other resources.
>>
>> probe_resource() will try to find specified size or more in parent b=
us.
>> If can not find current parent resource, and it will try to expand p=
arents
>> top.
>> If still can not find that specified on top, it will try to reduce t=
arget size
>> until find one.
>>
>> It will return 0, if it find any resource that it could use.
>>
>> Returned resource already register in the tree.
>>
>> So caller may still need call resource_replace to put real resource =
in
>> the tree.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> =A0include/linux/ioport.h | =A0 =A07 ++
>> =A0kernel/resource.c =A0 =A0 =A0| =A0160 +++++++++++++++++++++++++++=
+++++++++++++++++++--
>> =A02 files changed, 162 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index e885ba2..20a30df 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -156,6 +156,13 @@ extern int allocate_resource(struct resource *r=
oot, struct resource *new,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *alignf=
_data);
>> +void resource_shrink_parents_top(struct resource *b_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lon=
g size, struct resource *parent_res);
>> +struct device;
>> +int probe_resource(struct resource *b_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *dev, st=
ruct resource *busn_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t needed=
_size, struct resource **p,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int skip_nr, int limit=
, char *name);
>
> This interface is a mess. =A0I have a vague impression that this is
> supposed to figure out whether a resource can be expanded, but why
> does it need a struct device *? =A0(I can read the code and see how y=
ou
> use it, but it just doesn't fit in the resource abstraction.)

for debug printing purpose.

> Supplying one struct resource * makes sense, but you have three. =A0A
> char * name? =A0What's skip_nr? =A0This just doesn't make sense to me=
=2E

name is for debug purpose too.

skip_nr is for skipping.

for example: parent [60-7e]

when we try to probe for child buses, we need skip 60 as it is used alr=
eady for
pci devices.


>
> I think you need a simpler, more general interface. =A0update_resourc=
e()
> seems OK to me -- it's pretty straightforward and has an obvious
> meaning. =A0Maybe you can make a resource_expand() or something that
> just expands a resource in both directions as far as possible (until
> it hits a sibling or the parent limits). =A0Then you would know the
> maximum possible size, and you could use update_resource() to shrink
> it again and give up anything you don't need.

both directions may need more code.

>
> I spent most of the day merging the patches up to this point, and the=
y
> mostly make sense, but this one and the following ones are beyond my
> ken, so I gave up.

ok, let me check if i could simplify that code more.

Thanks

Yinghai
