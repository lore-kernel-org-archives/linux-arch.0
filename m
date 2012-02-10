From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
Date: Fri, 10 Feb 2012 14:37:13 -0800
Message-ID: <CAErSpo50HORbMF+R3cbemn1YpdMZodZmBqd6ouP_L9nvGmVrZw@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
 <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com>
 <CAE9FiQVx7=cSVkApbh_8dnoBqdrRYDOVtMqdC=mDCwq0fuVZpA@mail.gmail.com>
 <CAErSpo6zHhpz+N6y3ybDVp-oabVWAYeTt9pPJS3nz+nD2C8xkg@mail.gmail.com>
 <CAE9FiQVqKZGacZYqXETVVaqzobiw01OyCmASUfxwZ075rdX7XA@mail.gmail.com>
 <CAErSpo6MWS0=3gin7P6HQ7CNZwxD9cPfB6QNr1GDF7DVMhx2tw@mail.gmail.com> <CAE9FiQUZ8aDOe6oUxSrCgS9_3io4hpJdQsiJ=Hm7NACrcNBSDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56752 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760369Ab2BJWhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 17:37:34 -0500
Received: by werb13 with SMTP id b13so2348580wer.19
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 14:37:33 -0800 (PST)
In-Reply-To: <CAE9FiQUZ8aDOe6oUxSrCgS9_3io4hpJdQsiJ=Hm7NACrcNBSDg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: jbarnes@virtuousgeek.org, Tony Luck <tony.luck@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 10, 2012 at 12:25 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> On Fri, Feb 10, 2012 at 9:24 AM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>> On Fri, Feb 10, 2012 at 9:20 AM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>>
>> That's exactly what I said above, isn't it? =A0(In the paragraph
>> starting "Let me try again.")
>
> no, not create one. make them looks like one struct with some common =
fields.

The difference I see is that you kept the ugliness (enforcing
cut-and-paste of generic members across all architectures) and threw
out the possible goodness (replacing a "void *" with a "struct
pci_sysdata *").

>> As I said, the reason I don't like that approach is that I don't wan=
t
>> a dozen copies of first_busno, last_busno, domain, node, io_offset,
>> mem_offset, etc. =A0That information is not architecture-specific, s=
o we
>> shouldn't keep it in an architecture-specific struct.
>
> but you want to add hostbridge struct list and that just produce
> duplicated info.

You can think of it as merely being duplicated uselessly.  I think of
it as "putting it in the logical place and enabling its removal from
the wrong places."

> and search hostbridge for dev looks not good.
> Now you try to: for every device or resource find root bus and then
> check hostbridge list to get hostbridge and get offset.
>
> use sysdata pointer to get sys data like hostbridge info quickly
>
> i drafted one patch, and it seems not ugly with macro. please check i=
t.

I hate to say it, but I think it's ugly.  It looks like a hack bolted
on at the end because we were too lazy to do a nice design up front.
It might be the fewest lines of code change, but I think it's much
harder to read.  It's much more important that code be easier to read
and understand than it is to minimize code change.

Bjorn
