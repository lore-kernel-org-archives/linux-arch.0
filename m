From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v1 11/18] mips/PCI: get rid of device resource fixups
Date: Wed, 8 Feb 2012 13:16:52 -0800
Message-ID: <CAErSpo7oTngzPLb7+HHyOgYPB7Toc2yOtr1i0Z+85gLy4Mik0g@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165805.3231.99160.stgit@bhelgaas.mtv.corp.google.com>
 <20120131114250.b0e6af10.yuasa@linux-mips.org> <CAErSpo7xUL++rqnJug7=Wd_nfvaUDOewGjz1C2Fp-oQrkxO2yg@mail.gmail.com>
 <CAErSpo7ry8piDCTpgkdr01=Kd7=G6HTNwDAQAockPgXtyhJvuw@mail.gmail.com> <20120208132234.710f19be.yuasa@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53497 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405Ab2BHVRN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2012 16:17:13 -0500
Received: by wgbdt10 with SMTP id dt10so1015746wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 08 Feb 2012 13:17:12 -0800 (PST)
In-Reply-To: <20120208132234.710f19be.yuasa@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoichi Yuasa <yuasa@linux-mips.org>, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

On Tue, Feb 7, 2012 at 8:22 PM, Yoichi Yuasa <yuasa@linux-mips.org> wro=
te:
> Hi,
>
> On Tue, 7 Feb 2012 18:56:46 -0800
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> On Mon, Jan 30, 2012 at 7:54 PM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> > On Mon, Jan 30, 2012 at 6:42 PM, Yoichi Yuasa <yuasa@linux-mips.or=
g> wrote:
>> >> Hi,
>> >>
>> >> On Mon, 30 Jan 2012 09:58:05 -0700
>> >> Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >>
>> >>> Tell the PCI core about host bridge address translation so it ca=
n take
>> >>> care of bus-to-resource conversion for us.
>> >>>
>> >>> N.B. cobalt_legacy_ide_fixup() does scary things with resources,=
 but I
>> >>> *think* it will still work because we're still making the same a=
djustments,
>> >>> just in the opposite order. =A0Here are the legacy IDE resource.=
start
>> >>> values I expect:
>> >>>
>> >>> =A0 =A0 =A0 =A0 =A0current =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new
>> >>>
>> >>> =A0 =A0 =A0 =A0 =A0 =A00x1f0 =A0 (pci_setup_device) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x1f0
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pci_bus_to_resource) =A0=
 =A0 =A0 + 0xf0000000
>> >>> =A0 =A0 - 0xf0000000 =A0 (cobalt_legacy_ide_fixup) =A0 - 0xf0000=
000
>> >>> =A0 =A0 + 0xf0000000 =A0 (pcibios_fixup_bus)
>> >>> =A0 =A0 ------------ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ------------
>> >>> =A0 =A0 =A0 =A0 =A0 =A00x1f0 =A0 =A0final value =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1f0
>> >>
>> >> It seems to be unable to handle the offset correctly.
>> >>
>> >> failed on Cobalt:
>> >>
>> >> pata_via 0000:00:09.1: BAR 0: can't reserve [io =A00x100001f0-0x1=
00001f7]
>> >> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (e=
rrno=3D-16)
>> >> pata_via 0000:00:09.1: BAR 2: can't reserve [io =A00x10000170-0x1=
0000177]
>> >> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (e=
rrno=3D-16)
>> >> pata_via 0000:00:09.1: no available native port
>> >
>> > Thank you very much for testing this. =A0Could you collect the com=
plete
>> > dmesg and /proc/ioport contents, before and after my patches?
>>
>> Ping :) =A0I'll try to figure this out, but it would be easier if I =
had
>> the info mentioned above. =A0Thanks!
>
> It cannot mount rootfs with your patches.
> I cannot get /proc/ioports yet.
>
> I attach only boot logs.

Ah, I see the trouble.  The original MIPS pcibios_fixup_bus() applied
the io_offset to all IORESOURE_IO resources, but the generic
pcibios_bus_to_resource() only applies the offset to things that are
in the host bridge's window.

The legacy IDE addresses aren't in the window, so we didn't apply the
offset, and it didn't work.

I'll rework this and update my patches.

Thanks!

Bjorn
