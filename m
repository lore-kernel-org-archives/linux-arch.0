From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Patch V6 12/16] mm: provide early_memremap_ro to establish
 read-only mapping
Date: Thu, 6 Aug 2015 15:08:33 +0200
Message-ID: <55C35C51.1040005@suse.cz>
References: <1437108697-4115-1-git-send-email-jgross@suse.com>
 <1437108697-4115-13-git-send-email-jgross@suse.com>
 <55C3573B.6020509@suse.cz> <55C35AD1.7010101@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43344 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbHFNIf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Aug 2015 09:08:35 -0400
In-Reply-To: <55C35AD1.7010101@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-arch@vger.kernel.org

On 08/06/2015 03:02 PM, Juergen Gross wrote:
> On 08/06/2015 02:46 PM, Vlastimil Babka wrote:
>> On 07/17/2015 06:51 AM, Juergen Gross wrote:
>>
>> ... and here for !CONFIG_MMU.
>>
>> So, what about CONFIG_MMU && !FIXMAP_PAGE_RO combinations? Which
>> translates to CONFIG_MMU && !PAGE_KERNEL_RO. Maybe they don't exist, but
>> then it's still awkward to see the combination in the code left
>> unimplemented.
>
> At least there are some architectures without #define PAGE_KERNEL_RO but
> testing CONFIG_MMU (arm, m68k, xtensa).
>
>> Would it be perhaps simpler to assume the same thing as in
>> drivers/base/firmware_class.c ?
>>
>> /* Some architectures don't have PAGE_KERNEL_RO */
>> #ifndef PAGE_KERNEL_RO
>> #define PAGE_KERNEL_RO PAGE_KERNEL
>> #endif
>>
>> Or would it be dangerous here to silently lose the read-only protection?
>
> The only reason to use this function instead of early_memremap() is the
> mandatory read-only mapping. My intention was to let the build fail in
> case it is being used but not implemented. An architecture requiring the
> function but having no PAGE_KERNEL_RO still can define FIXMAP_PAGE_RO.

OK, in that case

Acked-by: Vlastimil Babka <vbabka@suse.cz>


> Juergen
>
