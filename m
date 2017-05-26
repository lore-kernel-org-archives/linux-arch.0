Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932649AbdEZCt4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 22:49:56 -0400
Date: Fri, 26 May 2017 10:49:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 31/32] x86: Add sysfs support for Secure Memory
 Encryption
Message-ID: <20170526024933.GA3228@dhcp-128-65.nay.redhat.com>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212212.10190.73484.stgit@tlendack-t1.amdoffice.net>
 <20170518170153.eqiyat5s6q3yeejl@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170518170153.eqiyat5s6q3yeejl@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, xlpang@redhat.com
Message-ID: <20170526024933.WtHOEDm_WBaa5mvoYjrA89Q9wSI8Q0pHM1lbVFtyq6U@z>

Ccing Xunlei he is reading the patches see what need to be done for
kdump. There should still be several places to handle to make kdump work.

On 05/18/17 at 07:01pm, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:22:12PM -0500, Tom Lendacky wrote:
> > Add sysfs support for SME so that user-space utilities (kdump, etc.) can
> > determine if SME is active.
> 
> But why do user-space tools need to know that?
> 
> I mean, when we load the kdump kernel, we do it with the first kernel,
> with the kexec_load() syscall, AFAICT. And that code does a lot of
> things during that init, like machine_kexec_prepare()->init_pgtable() to
> prepare the ident mapping of the second kernel, for example.
> 
> What I'm aiming at is that the first kernel knows *exactly* whether SME
> is enabled or not and doesn't need to tell the second one through some
> sysfs entries - it can do that during loading.
> 
> So I don't think we need any userspace things at all...

If kdump kernel can get the SME status from hardware register then this
should be not necessary and this patch can be dropped.

Thanks
Dave
