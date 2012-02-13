From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 04/24] PCI: Add busn_res operation functions
Date: Sun, 12 Feb 2012 16:11:48 -0800
Message-ID: <CAErSpo7F4caRyFVjrQKoCZLMo-45Vy+oEr4fMUXLeMojpuDNag@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-5-git-send-email-yinghai@kernel.org> <CAErSpo6=t1XtdUMBAn7Ag5XNLS3wKueybfrsUzmht6GL9XSGLQ@mail.gmail.com>
 <CAE9FiQXrFARy4+ynOTRyEuoyRxTc9qqzUaYJH8e19Wt3JRRxug@mail.gmail.com>
 <CAErSpo5_9N-HX3Ja8k04QaS6nss8SAm-NUtuQyHt0t-Dczt8-w@mail.gmail.com> <CAE9FiQV=nAK3KDUVvqiQ=otVUAHQf9GpxbR1gLvPc5ofHjOJaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35975 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab2BMAMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2012 19:12:09 -0500
Received: by wgbdt10 with SMTP id dt10so4360851wgb.1
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2012 16:12:08 -0800 (PST)
In-Reply-To: <CAE9FiQV=nAK3KDUVvqiQ=otVUAHQf9GpxbR1gLvPc5ofHjOJaA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Feb 12, 2012 at 4:03 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sun, Feb 12, 2012 at 3:51 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>>>
>>>>
>>>> I think it would be better to remove the bus resource from the tre=
e,
>>>> change its "end," then re-insert it.
>>>
>>> how about parent buses that have extended top?
>>
>> I don't understand your question. =A0I assume you mean there's a cas=
e
>> where remove/update/reinsert doesn't work, but I don't see why that
>> would be a problem. =A0Can you show an example?
>
> I mean parent busn_res already had several level's children busn_res.
> and every level may have some siblings.
> before remove will need to record those resources, to later to put th=
em back.
>
> that just increase not necessary complexity. because we already know
> those resource could be extended safely.

You're doing surgery on the middle of a relatively complicated data
structure.  Now readers of the code have to trust that not only does
kernel/resource.c work correctly, but they also have to examine this
PCI code to make sure that these alterations are safe.  I know this is
all crystal-clear in your mind, and no doubt it is correct right now,
but I don't think it is a reader-friendly approach.

But I don't expect to convince you, so I'll stop trying :)

Bjorn
