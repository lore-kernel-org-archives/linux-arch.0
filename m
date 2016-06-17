Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36075 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbcFQPvt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2016 11:51:49 -0400
Received: by mail-wm0-f48.google.com with SMTP id f126so3416949wma.1
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2016 08:51:49 -0700 (PDT)
Date: Fri, 17 Jun 2016 16:51:45 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [RFC PATCH v1 10/18] x86/efi: Access EFI related tables in the
 clear
Message-ID: <20160617155145.GJ2658@codeblueprint.co.uk>
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
 <20160426225740.13567.85438.stgit@tlendack-t1.amdoffice.net>
 <20160608111844.GV2658@codeblueprint.co.uk>
 <5759B67A.4000800@amd.com>
 <20160613135110.GC2658@codeblueprint.co.uk>
 <57615561.4090502@amd.com>
 <5762B9E7.80903@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5762B9E7.80903@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160617155145.-n-UNxScgVJP3mExqvee4qLJKjA6ffyguwqAWngeR4o@z>

On Thu, 16 Jun, at 09:38:31AM, Tom Lendacky wrote:
> 
> Ok, I think this was happening before the commit to build our own
> EFI page table structures:
> 
> commit 67a9108ed ("x86/efi: Build our own page table structures")
> 
> Before this commit the boot services ended up mapped into the kernel
> page table entries as un-encrypted during efi_map_regions() and I needed
> to change those entries back to encrypted. With your change above,
> this appears to no longer be needed.

Great news! Things are as they should be ;)
