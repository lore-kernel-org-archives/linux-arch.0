Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:22183 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1945998AbWKJG64 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Nov 2006 01:58:56 -0500
Subject: [PATCH 0/2] Add dev_sysdata and use it for ACPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 17:58:48 +1100
Message-Id: <1163141928.4982.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Due to the total absence of feedback (except Cornelia who'd like to use
this for s390 too), I'm reposting them here as they affect all archs
(and Willy admitted not seeing them on lkml).

I've already rebased all of my pending 2.6.20 powerpc stuff on top of
Patch 1/2, so I hope there won't be any major objection.

Patch 2/2 is not as urgent/important, Len, it's up to you to decide
wether you want to take the approach or not, but I feel like this void *
firmware_data in struct device is now userless, so ...

1/2 - Add a dev_sysdata structure to struct device whose content is arch
specific. It will allow architectures like powerpc, arm, i386, ... who
need different types of DMA ops for busses and other kind of auxilliary
data for devices in general (numa node id, firmware data, etc...) to put
them in there, without bloating all architectures. The patch adds an
empty definition for the structure to all architectures.

2/2 - As an example (patch test built but not test booted), I removed
ACPI usage of device->firmware_data, removed the firmware_data field
completely from struct device (as it was, apparently, the only user),
and instead used an "acpi_handle" field in i386, x86_64 and ia64
dev_sysdata.

Cheers,
Ben.

