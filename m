From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 02/15] PCI: Add iobusn_resource
Date: Mon, 6 Feb 2012 10:48:41 -0800
Message-ID: <CAE9FiQXaQMGytuWYcjWc6-CqfpLcdpZ=_TNke-ED6SUr2w8-9Q@mail.gmail.com>
References: <1328136242-17725-1-git-send-email-yinghai@kernel.org>
	<1328136242-17725-3-git-send-email-yinghai@kernel.org>
	<CAErSpo44bef-Vj4LPB0QJ8HRjWxqRFK_=kpMq8hYEe=4t58zGQ@mail.gmail.com>
	<1328312292.30631.5.camel@pasglop>
	<CAE9FiQVG9YbZW=Usv0drxuyQ=ZTERK5KZK3TF6aX-iWuAS8L6Q@mail.gmail.com>
	<CAErSpo46ZTbqu1+KMomHrD9KQxTT3j+Dc8F_byKfvTJ=EDw+ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo46ZTbqu1+KMomHrD9KQxTT3j+Dc8F_byKfvTJ=EDw+ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 6, 2012 at 9:14 AM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:

> The current bus number allocation in pci_scan_bridge() is very simple
> -- we just add one to the highest-numbered bridge we've seen. =A0That
> works in many cases, but it means any holes in the range of used bus
> numbers are just wasted.
>
> Here's a case I tripped over where the current scheme fails. =A0The
> machine boots with bridge 00:03.0 to [bus 05-19]. =A0Now we hot-add a
> hierarchy that is currently configured like this:
>
> =A0 =A0 =A005:00.0 bridge to [bus 06-1e]
> =A0 =A0 =A006:05.0 bridge to [bus 1c]
> =A0 =A0 =A006:06.0 bridge to [bus 1d]
> =A0 =A0 =A01c:00.0 NIC0
> =A0 =A0 =A01d:00.0 NIC1
>
> [bus 1a-1e] is inaccessible because the 00:03.0 aperture only include=
s
> [bus 05-19]. =A0There's plenty of space to reconfigure the hierarchy,
> e.g., to make 05:00.0 lead to [bus 06-19], 06:05.0 lead to [bus 18],
> and 06:06.0 lead to [bus 19]. =A0But we aren't smart enough to do tha=
t.

Yes, this patchset will reject 05:00.0 bus setting from bios, and
assign it with 06-19.

Yinghai
