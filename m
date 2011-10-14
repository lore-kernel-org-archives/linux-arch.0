From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
Date: Fri, 14 Oct 2011 09:33:28 -0600
Message-ID: <CAErSpo7d3hHeJU87zYo=yJoG3eqOZ4QggkOyNnu7xuJe8oG9Qg@mail.gmail.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com> <1318605254.3018.20.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:24887 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab1JNPdv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 11:33:51 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p9EFXoq0024614
	for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 08:33:50 -0700
Received: from vws18 (vws18.prod.google.com [10.241.21.146])
	by hpaq7.eem.corp.google.com with ESMTP id p9EFWqMr032049
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 08:33:48 -0700
Received: by vws18 with SMTP id 18so1772037vws.5
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 08:33:48 -0700 (PDT)
In-Reply-To: <1318605254.3018.20.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 14, 2011 at 9:14 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2011-10-13 at 22:27 -0600, Bjorn Helgaas wrote:
>> The most generic way to create a PCI root bus is with pci_scan_bus()=
, but
>> that doesn't allow you to specify what resources are available on th=
e bus,
>> i.e., what the host bridge apertures are.
>
> Do you have an actual tree for this? =A0The PARISC pieces look a bit
> non-trivial and I'd like to test them out on the various sba/astro/di=
no
> systems.

I don't yet, but it'd be great if you were willing to test them out,
so I'll set one up.

While this is on your mind, I'm dubious about the pci_enable_bridges()
call in lba_driver_probe() and the pci_bus_assign_resources() call in
dino_probe().  These stand out as exceptions because no other arches
do that.

If they weren't there, both places could use pci_scan_root_bus() like
most other arches.

Bjorn
