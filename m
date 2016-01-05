From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v3 05/17] ia64: Set System RAM type and descriptor
Date: Tue, 5 Jan 2016 11:04:12 -0800
Message-ID: <20160105190412.GA6746@agluck-desk.sc.intel.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
 <1452020081-26534-5-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2068 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbcAETEg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Jan 2016 14:04:36 -0500
Content-Disposition: inline
In-Reply-To: <1452020081-26534-5-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org

On Tue, Jan 05, 2016 at 11:54:29AM -0700, Toshi Kani wrote:
> Change efi_initialize_iomem_resources() to set 'flags' and 'desc'
> from EFI memory types.  IORESOURCE_SYSRAM, a modifier bit, is
> set to 'flags' for System RAM as IORESOURCE_MEM is already set.
> IORESOURCE_SYSTEM_RAM is defined as (IORESOURCE_MEM|IORESOURCE_SYSRAM).
> I/O resource descritor is set to 'desc' for "ACPI Non-volatile
> Storage" and "Persistent Memory".
> 
> Also set IORESOURCE_SYSTEM_RAM to 'flags' for "Kernel code",
> "Kernel data", and "Kernel bss".
> 
Acked-by: Tony Luck <tony.luck@intel.com>
