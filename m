Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:8691
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030334AbXCOM5n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Mar 2007 08:57:43 -0400
Message-Id: <45F94C45.76E4.0078.0@novell.com>
Date: Thu, 15 Mar 2007 12:38:13 +0000
From: "Jan Beulich" <jbeulich@novell.com>
Subject: PCI DAC DMA APIs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

While the kernel headers provide for this, there don't appear to be any
in-tree users (which seems contrary to general Linux policies). Would there
be objections to remove all of these?

Jan
