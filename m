Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39511 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab2BCLq2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Feb 2012 06:46:28 -0500
Message-ID: <1328269579.30631.2.camel@pasglop>
Subject: Re: [RFC PATCH v1 10/18] microblaze/PCI: get rid of device resource
 fixups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Feb 2012 22:46:19 +1100
In-Reply-To: <4F2A6A87.6020308@monstr.eu>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
	 <20120130165800.3231.42814.stgit@bhelgaas.mtv.corp.google.com>
	 <4F2A6A87.6020308@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120203114619.S6x3C4-SyGchxuYWnvQj3pUdpbHGN8FlTENMYVIuxcE@z>

On Thu, 2012-02-02 at 11:50 +0100, Michal Simek wrote:

> I don't have any pci board for testing this. The most of things come from ppc.
> We share pci IPs with xilinx ppc405/440.
> 
> Sorry that I can't help you with it and I have no problem with unification patches.
> If someone has any problem with it can be bisected and solved in future.

Yeah I'll have to test that one :-) Give me a few more days to sort out
some other stuff and I'll give this series a good go.

Cheers,
Ben.


