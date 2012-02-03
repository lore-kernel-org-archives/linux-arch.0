Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35942 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab2BCQB6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2012 11:01:58 -0500
Date: Fri, 3 Feb 2012 16:01:46 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v1 07/18] arm/PCI: get rid of device resource fixups
Message-ID: <20120203160146.GM889@n2100.arm.linux.org.uk>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com> <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120203160146.1xuJzjwM1fqVwfPbiBbRcVfwIkQMuwLwvTpyR7fGQPU@z>

On Mon, Jan 30, 2012 at 09:57:45AM -0700, Bjorn Helgaas wrote:
> Tell the PCI core about host bridge address translation so it can take
> care of bus-to-resource conversion for us.

Are the rest of these patches (in particular whereever is introduced
the generic versions) available somewhere?

Thanks.
