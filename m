Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36421 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbcD0Odl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2016 10:33:41 -0400
Received: by mail-ob0-f172.google.com with SMTP id j9so23450874obd.3
        for <linux-arch@vger.kernel.org>; Wed, 27 Apr 2016 07:33:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160426225604.13567.55443.stgit@tlendack-t1.amdoffice.net>
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net> <20160426225604.13567.55443.stgit@tlendack-t1.amdoffice.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 27 Apr 2016 07:33:21 -0700
Message-ID: <CALCETrU9ozp1mBKG-P88cKRJRY5bifn2Ab__AZcn5b33n3j2cg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/18] x86: Set the write-protect cache mode for
 AMD processors
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160427143321.w2UBzkj8ngx8ngbBMf73ZOuTyL92mU5dPdPC9qvaySs@z>

On Tue, Apr 26, 2016 at 3:56 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> For AMD processors that support PAT, set the write-protect cache mode
> (_PAGE_CACHE_MODE_WP) entry to the actual write-protect value (x05).

What's the purpose of using the WP memory type?

--Andy
