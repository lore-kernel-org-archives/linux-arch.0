From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 09/13] PCI: Probe safe range that we can use for
 unassigned bridge.
Date: Mon, 30 Jan 2012 10:51:30 -0800
Message-ID: <CAE9FiQWLRvXXyeEhvW+n55_Q+P88xyfgLCKwyK8d4tg679-8gg@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
	<1327718971-9598-10-git-send-email-yinghai@kernel.org>
	<CAErSpo5QYvx6dtL4NqW4Pu29HXbS-kcTq-GKvpJO8AJ6vRYeBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5QYvx6dtL4NqW4Pu29HXbS-kcTq-GKvpJO8AJ6vRYeBw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 7:59 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> Try to allocate from parent bus busn_res. if can not find any big en=
ough, will try
>> to extend parent bus top. even the extending is through allocating, =
after allocating
>> will pad the range to parent buses top.
>>
>> When extending happens, We will record the parent_res, so could use =
it as stopper
>> for really extend/shrink top later.
>>
=2E.
>
> I think what this does is "find the largest available area in 'res'."
> That *sounds* sort of useful (and like something that could go
> somewhere more generic than drivers/pci/probe.c), but there's no
> locking, so we don't have any assurance that the area we find will
> *remain* available.

two usages:
1. init booting : should be safe, that is sequential scanning
2. hotplug: we should have overall lock somewhere for it?

>
> Since the caller should deal with failure anyway (if the largest
> available area is no longer available by the time it gets around to
> allocating it), it seems like it'd be better to fold this into the
> caller somehow.



>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* release busn_res */
>
> Comments like this that repeat exactly what the next line of code doe=
s
> without adding any useful information are unnecessary and distracting=
=2E

ok, will remove them.

Yinghai
