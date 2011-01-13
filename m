From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PAGE_KERNEL_RO
Date: Thu, 13 Jan 2011 08:27:24 +0100
Message-ID: <4D2EA95C.7000900@ladisch.de>
References: <20110112160722.6486a6c2.akpm@linux-foundation.org>	<1294877484.9586.66.camel@pasglop> <20110113073458.2179590a@stein> <522C1DF17AF50042AD8AE87F7887BD3D01E1655529@exch.hq.tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45945 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752778Ab1AMH1f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Jan 2011 02:27:35 -0500
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D01E1655529@exch.hq.tensilica.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Gauthier <marc@tensilica.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux1394-devel@lists.sourceforge.net

Marc Gauthier wrote:
> Stefan Richter wrote:
>> On Jan 13 Benjamin Herrenschmidt wrote at linux-arch:
>>> On Wed, 2011-01-12 at 16:07 -0800, Andrew Morton wrote:
>>>> drivers/firewire/ohci.c now needs PAGE_KERNEL_RO, but many
>>>> architectures don't implement it.  Broke my sparc64 build.
>>>
>>> Some architectures actually cannot implement it even... at least some
>>> variants of powerpc MMUs don't have a combination of protection bits
>>> that allow a kernel-only RO mapping (yeah odd).
>>
>> The simplest perceivable fix, to disable firewire-ohci on
>> architectures which don't have PAGE_KERNEL_RO, would be bad since
>> there are actually sparc64 machines with these controllers.
>>
>> As far as I can tell, the new RO mapping in firewire-ohci can as well be
>> an r/w mapping.  We just never need to write at these virtual
>> addresses. So, should we just change the driver to map it r/w when we
>> can't have PAGE_KERNEL_RO, or for simplicity on all architectures?
> 
> What do I know...  Is a simple:
> 
>   #ifndef PAGE_KERNEL_RO
>   #define PAGE_KERNEL_RO PAGE_KERNEL
>   #endif
> 
> in drivers/firewire/ohci.c too hacky?

--8<---------------------------------------------------------------->8--
firewire: ohci: fix compilation on arches without PAGE_KERNEL_RO, e.g. sparc

PAGE_KERNEL_RO is not available on all architectures, so its use in the
new AR code broke compilation on sparc64.

Because the R/O mapping is only used to catch drivers that try to write
to the reception buffer and not actually required for correct operation,
we can just use a normal PAGE_KERNEL mapping where _RO is not available.

Thanks to Stefan Richter and Marc Gauthier <marc@tensilica.com> for
suggesting this fix.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -91,6 +91,14 @@ struct descriptor {
 #define MAX_AR_PACKET_SIZE	(16 + MAX_ASYNC_PAYLOAD + 4)
 #define AR_WRAPAROUND_PAGES	DIV_ROUND_UP(MAX_AR_PACKET_SIZE, PAGE_SIZE)
 
+/*
+ * For archs where PAGE_KERNEL_RO is not supported;
+ * mapping the AR buffers readonly for the CPU is just a debugging aid.
+ */
+#ifndef PAGE_KERNEL_RO
+#define PAGE_KERNEL_RO PAGE_KERNEL
+#endif
+
 struct ar_context {
 	struct fw_ohci *ohci;
 	struct page *pages[AR_BUFFERS];
