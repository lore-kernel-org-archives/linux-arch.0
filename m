Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65207 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbcCJHqT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 02:46:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 08:45:30 +0100
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201603100845.30602.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Noam Camus <noamc@ezchip.com>
Message-ID: <20160310074530.k0q3Vq-jwJ3fz76rgpjyg0IyYEPcoqw0ufsSRYDeMQQ@z>

On Thursday 10 March 2016, Vineet Gupta wrote:
> On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
> > Memory access primitives should use cpu_to_le16, cpu_to_le32, le16_to_cpu
> > and le32_to_cpu because it is not really guaranteed that drivers handles
> > any ordering themselves.
> 
> That is the driver issue. readxx as API simply returns data in native endianness.
> We've had EZChip running big endian and so far and they didn't need this change.

Most drivers using readl() or readl_relaxed() expect those to perform byte
swaps on big-endian architectures, as the registers tend to be fixed endian,
so the change seems reasonable.

It depends a little bit on how endian mode is implemented in the CPU: do you
follow the normal model of swapping byte order in the load/store instructions
of the CPU when running big-endian, or is the CPU always running little-endian
but the bus addresses get mangled on byte accesses to give the illusion
of a big-endian system?

	Arnd
