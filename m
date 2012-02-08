From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v1 11/18] mips/PCI: get rid of device resource fixups
Date: Tue, 7 Feb 2012 18:56:46 -0800
Message-ID: <CAErSpo7ry8piDCTpgkdr01=Kd7=G6HTNwDAQAockPgXtyhJvuw@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165805.3231.99160.stgit@bhelgaas.mtv.corp.google.com>
 <20120131114250.b0e6af10.yuasa@linux-mips.org> <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 7:54 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Mon, Jan 30, 2012 at 6:42 PM, Yoichi Yuasa <yuasa@linux-mips.org> =
wrote:
>> Hi,
>>
>> On Mon, 30 Jan 2012 09:58:05 -0700
>> Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>> Tell the PCI core about host bridge address translation so it can t=
ake
>>> care of bus-to-resource conversion for us.
>>>
>>> N.B. cobalt_legacy_ide_fixup() does scary things with resources, bu=
t I
>>> *think* it will still work because we're still making the same adju=
stments,
>>> just in the opposite order. =A0Here are the legacy IDE resource.sta=
rt
>>> values I expect:
>>>
>>> =A0 =A0 =A0 =A0 =A0current =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A00x1f0 =A0 (pci_setup_device) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0x1f0
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pci_bus_to_resource) =A0 =A0=
 =A0 + 0xf0000000
>>> =A0 =A0 - 0xf0000000 =A0 (cobalt_legacy_ide_fixup) =A0 - 0xf0000000
>>> =A0 =A0 + 0xf0000000 =A0 (pcibios_fixup_bus)
>>> =A0 =A0 ------------ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ------------
>>> =A0 =A0 =A0 =A0 =A0 =A00x1f0 =A0 =A0final value =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 0x1f0
>>
>> It seems to be unable to handle the offset correctly.
>>
>> failed on Cobalt:
>>
>> pata_via 0000:00:09.1: BAR 0: can't reserve [io =A00x100001f0-0x1000=
01f7]
>> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errn=
o=3D-16)
>> pata_via 0000:00:09.1: BAR 2: can't reserve [io =A00x10000170-0x1000=
0177]
>> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errn=
o=3D-16)
>> pata_via 0000:00:09.1: no available native port
>
> Thank you very much for testing this. =A0Could you collect the comple=
te
> dmesg and /proc/ioport contents, before and after my patches?

Ping :)  I'll try to figure this out, but it would be easier if I had
the info mentioned above.  Thanks!

Bjorn
