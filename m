From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 39/39] x86, PCI: kill busn in acpi pci_root_info
Date: Wed, 29 Feb 2012 18:57:28 -0800
Message-ID: <CAE9FiQUTVq10LpE_uqwOewxCftSu0Y9=-6gOfYg-9H4_6mW8DA@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
	<1330556858-11768-40-git-send-email-yinghai@kernel.org>
	<CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
	<CAE9FiQUeRno4ZCy37XQ+cwrFYG-XoDq7q=XjKrOVy5E85bS-ig@mail.gmail.com>
	<20120229235128.GA5484@kroah.com>
	<20120229162743.49d78c21@jbarnes-x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120229162743.49d78c21@jbarnes-x220>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 29, 2012 at 4:27 PM, Jesse Barnes <jbarnes@virtuousgeek.org=
> wrote:
> On Wed, 29 Feb 2012 15:51:28 -0800
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
>> On Wed, Feb 29, 2012 at 03:37:53PM -0800, Yinghai Lu wrote:
>> > On Wed, Feb 29, 2012 at 3:32 PM, Bjorn Helgaas
>
>> > > You just *added* this stuff in a prior patch that hasn't been
>> > > merged yet. =A0Why can't you just fix that series rather than do=
ing
>> > > the add/remove churn?
>> >
>> > as i said before, I'm not quite sure about the life cycle about
>> > that object.
>
> I thought Bjorn figured that out for you in the last thread?
>
>> >
>> > still need to wait some months to verify that on system that does
>> > support pci root bus hot plug etc.
>> >
>> > or we can just this patch for now.
>>
>> A statement like that would cause all of these patches to be instant=
ly
>> deleted from any queue that I had control over, and I strongly
>> recommend that Jesse just ignore them all.
>>
>> If you don't know this thing, then you have no right to change it,
>> flat out. =A0Why do we trust these patches from you? =A0I sure don't=
=2E
>
> Oh don't worry, this patch set isn't going upstream anytime soon.
> Bjorn has raised several good points that Yinghai has yet to
> address... =A0I trust Bjorn's judgment on these, so until he's happy =
I
> likely won't be merging them.

Sorry for upsetting Greg.

will reorder patch sequence to mold that patch.

      Yinghai
