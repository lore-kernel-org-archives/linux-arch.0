From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 39/39] x86, PCI: kill busn in acpi pci_root_info
Date: Wed, 29 Feb 2012 16:27:43 -0800
Message-ID: <20120229162743.49d78c21@jbarnes-x220>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
	<1330556858-11768-40-git-send-email-yinghai@kernel.org>
	<CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
	<CAE9FiQUeRno4ZCy37XQ+cwrFYG-XoDq7q=XjKrOVy5E85bS-ig@mail.gmail.com>
	<20120229235128.GA5484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:33439 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756920Ab2CAA14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 19:27:56 -0500
In-Reply-To: <20120229235128.GA5484@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 29 Feb 2012 15:51:28 -0800
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 29, 2012 at 03:37:53PM -0800, Yinghai Lu wrote:
> > On Wed, Feb 29, 2012 at 3:32 PM, Bjorn Helgaas

> > > You just *added* this stuff in a prior patch that hasn't been
> > > merged yet. =C2=A0Why can't you just fix that series rather than =
doing
> > > the add/remove churn?
> >=20
> > as i said before, I'm not quite sure about the life cycle about
> > that object.

I thought Bjorn figured that out for you in the last thread?

> >=20
> > still need to wait some months to verify that on system that does
> > support pci root bus hot plug etc.
> >=20
> > or we can just this patch for now.
>=20
> A statement like that would cause all of these patches to be instantl=
y
> deleted from any queue that I had control over, and I strongly
> recommend that Jesse just ignore them all.
>=20
> If you don't know this thing, then you have no right to change it,
> flat out.  Why do we trust these patches from you?  I sure don't.

Oh don't worry, this patch set isn't going upstream anytime soon.
Bjorn has raised several good points that Yinghai has yet to
address...  I trust Bjorn's judgment on these, so until he's happy I
likely won't be merging them.
