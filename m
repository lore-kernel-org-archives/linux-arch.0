Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40711 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbcILQnH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 12:43:07 -0400
Date: Mon, 12 Sep 2016 18:43:03 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 16/20] x86: Check for memory encryption on the APs
Message-ID: <20160912164303.kaqx2ayqjtbkcc2z@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223829.29880.10341.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223829.29880.10341.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160912164303.Ky_Lb1TBrHq5NJpXXhA-sHxmvpM0N0XSHenwIgFOdcE@z>

On Mon, Aug 22, 2016 at 05:38:29PM -0500, Tom Lendacky wrote:
> Add support to check if memory encryption is active in the kernel and that
> it has been enabled on the AP. If memory encryption is active in the kernel

A small nit: let's write out "AP" the first time at least: "... on the
Application Processors (AP)." for more clarity.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
