Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33107 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbcD0OkB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2016 10:40:01 -0400
Received: by mail-ob0-f179.google.com with SMTP id x1so5174110obt.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Apr 2016 07:40:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 27 Apr 2016 07:39:24 -0700
Message-ID: <CALCETrUdrMAmE6Vgj6_PALdmRZVVKa3QDwJtO=YDTOQdox=rhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/18] x86: Secure Memory Encryption (AMD)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160427143924.hgW4u_Ldj3AVspu0qwonj4hAUfJihgCLgRR_dInOFxg@z>

On Tue, Apr 26, 2016 at 3:55 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> This RFC patch series provides support for AMD's new Secure Memory
> Encryption (SME) feature.
>
> SME can be used to mark individual pages of memory as encrypted through the
> page tables. A page of memory that is marked encrypted will be automatically
> decrypted when read from DRAM and will be automatically encrypted when
> written to DRAM. Details on SME can found in the links below.

Having read through the docs briefly, some questions:

1. How does the crypto work?  Is it straight AES-ECB?  Is it a
tweakable mode?  If so, what does into the tweak?  For example, if I
swap the ciphertext of two pages, does the plaintext of the pages get
swapped?  If not, why not?

2. In SEV mode, how does the hypervisor relocate a physical backing
page?  Does it simple move it and update the 2nd-level page tables?
If so, is the result of decryption guaranteed to be garbage if it
relocates a page and re-inserts it at the wrong guest physical
address?

3. In SEV mode, does anything prevent the hypervisor from resuming a
guest with the wrong ASID, or is this all relying on the resulting
corruption of the guest code and data to cause a crash?

4. As I understand it, the caches are all unencrypted, and they're
tagged with the physical address, *including* the SME bit (bit 47).
In SEV mode, are they also tagged with the ASID?  I.e. if I have a
page in cache for ASID 1 and I try to read it with ASID 2, will I get
a fresh copy decrypted with ASID 2's key?  If so, will the old ASID 1
copy be evicted, or will it stay in cache and be non-coherent?

--Andy
