From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFC PATCH v1 02/18] PCI: add struct pci_host_bridge and a list
 of all bridges found
Date: Mon, 30 Jan 2012 14:29:50 -0800
Message-ID: <CAE9FiQUUvdG4R=sg3R6K_ZxPGT2WwWJj6ZvPSwvkyHh=ApFAuw@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
	<20120130165719.3231.43751.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQUXjjk=twgwWVB01JMD9GokEVjOoiRLYZYRTPSPXHYfFw@mail.gmail.com>
	<CAErSpo6WqUa5AcEBNwa1g4O1M+MvKwr9RXhVSo04APDLncp+tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6WqUa5AcEBNwa1g4O1M+MvKwr9RXhVSo04APDLncp+tA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 2:00 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:

>>
>
> pci_bus->self points to a struct pci_dev. =A0A host bridge is not a
> pci_dev. =A0I don't think it's a good idea to simply reuse "self" to
> point to something of a different type, but maybe you have something
> different in mind.

oh, maybe some root bus will not self to null. (that is why
is_pci_root_bus() is checking parent).

>
>> or just do not add host_bridge , and instead only add another field
>> like struct list_head windows in pci_sysdata?
>
> The pci_sysdata I see is an x86-specific thing, so I don't see how
> that would help.

then expand it.

after that you don't need to go over up to find root bus for one pci
dev and compare root bus with hostbridge list to find out hostbridge.

Yinghai
