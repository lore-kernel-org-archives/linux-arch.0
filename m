From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 08/18] ia64/PCI: SN: convert to pci_scan_root_bus() for
 correct root bus resources
Date: Thu, 9 Feb 2012 18:46:39 -0800
Message-ID: <CAErSpo7SY+ShKF_gOeV13Z8YH4je_EkW5CvGFcMdz_-wRKy4VA@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com> <20120210023702.10311.31450.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45998 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350Ab2BJCrA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2012 21:47:00 -0500
Received: by werb13 with SMTP id b13so1700334wer.19
        for <linux-arch@vger.kernel.org>; Thu, 09 Feb 2012 18:46:59 -0800 (PST)
In-Reply-To: <20120210023702.10311.31450.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Jack Steiner <steiner@sgi.com>

On Thu, Feb 9, 2012 at 6:37 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> Convert from pci_scan_bus() to pci_scan_root_bus(). =A0Supply the roo=
t
> bus resources from bussoft. =A0When we move the resource adjustment f=
rom
> pcibios_fixup_resources() to the PCI core, it will be important to ha=
ve
> the root bus resources correct from the beginning.

Hi Jack, this ia64 box has some of the more complicated PCI code, and
of course, I have no way to test it.  If I understand correctly, these
boxes don't have ACPI.  If any of these still exist and if you're
interested in testing this series on them, I'd be happy to help
resolve any issues.

Bjorn
