From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 00/34] Create PCI root buses with correct resources
Date: Sat, 29 Oct 2011 10:25:00 -0600
Message-ID: <CAErSpo5X00LFs6XUcnqoogZEZhR2H4G7AJvh9+FAsvr3vMHkeA@mail.gmail.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:16730 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933Ab1J2QZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2011 12:25:27 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p9TGPNZT022803
	for <linux-arch@vger.kernel.org>; Sat, 29 Oct 2011 09:25:23 -0700
Received: from pzk2 (pzk2.prod.google.com [10.243.19.130])
	by wpaz1.hot.corp.google.com with ESMTP id p9TGPL44023818
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Sat, 29 Oct 2011 09:25:22 -0700
Received: by pzk2 with SMTP id 2so18590823pzk.4
        for <linux-arch@vger.kernel.org>; Sat, 29 Oct 2011 09:25:21 -0700 (PDT)
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, Oct 28, 2011 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> The most generic way to create a PCI root bus is with pci_scan_bus(),=
 but that
> doesn't allow you to specify what resources are available on the bus,=
 i.e.,
> what the host bridge apertures are. =A0This series fixes the problem =
by adding
> a new pci_scan_root_bus() interface that takes a list of bus resource=
s.

These patches are also available here:
git://github.com/bjorn-helgaas/linux.git on
the "pci-scan-v3" branch.
