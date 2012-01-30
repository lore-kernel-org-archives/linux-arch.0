From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 08/13] PCI: Add pci_bus_extend/shrink_top()
Date: Mon, 30 Jan 2012 10:42:01 -0800
Message-ID: <CAE9FiQX1=U=ysmvRY4Kwx8MAR1KWxn3JaD32xjdCSnbWXT7V2A@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
	<1327718971-9598-9-git-send-email-yinghai@kernel.org>
	<CAErSpo6dihCWme3bgVV0AjHXnKd78BskLVj2LZqHocoAp83h+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6dihCWme3bgVV0AjHXnKd78BskLVj2LZqHocoAp83h+Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 7:50 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> extend or shrink bus and parent buses top (subordinate)
>>
>> extended range is verified safe range, and stop at recorded parent_r=
es.
=2E..
> This makes me nervous for the same reason as
> pci_bus_update_busn_res_end() -- we're changing res->end for resource=
s
> already in a tree. =A0How do we know the tree remains consistent?
>

Yes, we already try to allocate near the top and later pad the top. So
it is safe to just adjust top.

Yinghai
